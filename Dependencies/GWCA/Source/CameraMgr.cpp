#include "stdafx.h"

#include <GWCA/Utilities/Export.h>
#include <GWCA/Utilities/Macros.h>
#include <GWCA/Utilities/Scanner.h>
#include <GWCA/Utilities/MemoryPatcher.h>

#include <GWCA/GameContainers/GamePos.h>

#include <GWCA/GameEntities/Camera.h>

#include <GWCA/Managers/Module.h>
#include <GWCA/Managers/CameraMgr.h>

namespace {
    using namespace GW;

    MemoryPatcher patch_max_dist;
    MemoryPatcher patch_cam_update;
    MemoryPatcher patch_fog;
    MemoryPatcher patch_fov;

    uintptr_t patch_fog_addr;
    uintptr_t patch_max_dist_addr;
    uintptr_t patch_cam_update_addr;

    uintptr_t scan_cam_class;

    void Init() {
        patch_fog_addr = Scanner::Find(
            "\x83\xE0\x01\x8B\x09\x50\x6A\x1C", "xxxxxxxx", +2);
        printf("[SCAN] patch_fog_addr = %p\n", (void *)patch_fog_addr);

        patch_max_dist_addr = Scanner::Find(
            "\xD8\xD9\xDF\xE0\xF6\xC4\x41\x75\x26\xD9\x46", "xxxxxxxxxxx", +0x9B);
        printf("[SCAN] patch_max_dist_addr = %p\n", (void *)patch_max_dist_addr);

        patch_cam_update_addr = Scanner::Find(
            "\x89\x0E\xDD\xD9\x89\x56\x04\xDD", "xxxxxxxx", 0);
        printf("[SCAN] patch_cam_update_addr = %p\n", (void *)patch_cam_update_addr);

        {
            uintptr_t address = Scanner::Find("\xD9\xEE\xB9\x00\x00\x00\x00\xD9\x55\xFC", "xxx????xxx", +3);
            printf("[SCAN] scan_cam_class = %p\n", (void *)address);
            if (Verify(address))
                scan_cam_class = *(uintptr_t *)address;
        }

        if (Verify(patch_max_dist_addr))
            patch_max_dist.SetPatch(patch_max_dist_addr, "\x90\x90\x90", 3);
        if (Verify(patch_cam_update_addr))
            patch_cam_update.SetPatch(patch_cam_update_addr, "\xEB\x0C", 2);
        if (Verify(patch_fog_addr))
            patch_fog.SetPatch(patch_fog_addr, "\x00", 1);
    }

    void Exit() {
        patch_max_dist.Reset();
        patch_cam_update.Reset();
        patch_fog.Reset();
    }

    void EnableHooks() {
        if (patch_max_dist_addr)
            patch_max_dist.TogglePatch(true);
    }

    void DisableHooks() {
        if (patch_max_dist_addr)
            patch_max_dist.TogglePatch(false);
        if (patch_cam_update_addr)
            patch_cam_update.TogglePatch(false);
        if (patch_fog_addr)
            patch_fog.TogglePatch(false);
    }
}

namespace GW {
    
    Module CameraModule = {
        "CameraModule",     // name
        NULL,               // param
        ::Init,             // init_module
        ::Exit,             // exit_module
        ::EnableHooks,      // enable_hooks
        ::DisableHooks,     // disable_hooks
    };

    Camera *CameraMgr::GetCamera() {
        Camera *camera = (Camera *)scan_cam_class;
        return camera;
    }

    void CameraMgr::SetMaxDist(float dist) {
        GetCamera()->max_distance2 = dist;
    }

    void CameraMgr::SetFieldOfView(float fov) {
        GetCamera()->field_of_view = fov;
    }

    bool CameraMgr::UnlockCam(bool flag) {
        if (patch_cam_update_addr) {
            return patch_cam_update.TogglePatch(flag);
        } else {
            return false;
        }
    }

    bool CameraMgr::GetCameraUnlock() {
        if (patch_cam_update_addr) {
            return patch_cam_update.GetIsEnable();
        } else {
            return false;
        }
    }

    bool CameraMgr::SetFog(bool flag) {
        if (patch_fog_addr) {
            return patch_fog.TogglePatch(!flag);
        } else {
            return false;
        }
    }

    void CameraMgr::ForwardMovement(float amount, bool true_forward) {
        if (amount == 0.f) return;
        Camera *cam = GetCamera();
        if (true_forward) {
            float pitchX = sqrtf(1.f - cam->pitch * cam->pitch);
            cam->look_at_target.x += amount * pitchX * cosf(cam->yaw);
            cam->look_at_target.y += amount * pitchX * sinf(cam->yaw);
            cam->look_at_target.z += amount * cam->pitch;
        } else {
            cam->look_at_target.x += amount * cosf(cam->yaw);
            cam->look_at_target.y += amount * sinf(cam->yaw);
        }
    }

    void CameraMgr::VerticalMovement(float amount) {
        Camera *cam = GetCamera();
        cam->look_at_target.z += amount;
    }

    void CameraMgr::SideMovement(float amount) {
        if (amount == 0.f) return;
        Camera *cam = GetCamera();
        cam->look_at_target.x += amount * -sinf(cam->yaw);
        cam->look_at_target.y += amount *  cosf(cam->yaw);
    }

    void CameraMgr::RotateMovement(float angle) {
        if (angle == 0.f) return;
        // rotation with fixed z (vertical axe)
        Camera *cam = GetCamera();
        float pos_x = cam->position.x;
        float pos_y = cam->position.y;
        float px = cam->look_at_target.x - pos_x;
        float py = cam->look_at_target.y - pos_y;

        Vec3f newPos;
        newPos.x = pos_x + (cosf(angle) * px - sinf(angle) * py);
        newPos.y = pos_y + (sinf(angle) * px + cosf(angle) * py);
        newPos.z = cam->look_at_target.z;

        cam->SetYaw(cam->yaw + angle);
        GetCamera()->look_at_target = newPos;
    }

    Vec3f CameraMgr::ComputeCamPos(float dist) {
        Camera *cam = GetCamera();
        if (dist == 0) dist = cam->GetCameraZoom();

        Vec3f newPos = cam->GetLookAtTarget();

        float pitchX = sqrtf(1.f - GetCamera()->pitch*GetCamera()->pitch);
        newPos.x -= dist * pitchX * cosf(GetCamera()->yaw);
        newPos.y -= dist * pitchX * sinf(GetCamera()->yaw);
        newPos.z -= dist * 0.95f * GetCamera()->pitch; // 0.95 is the max pitch, not 1.0

        return newPos;
    }

    void CameraMgr::UpdateCameraPos() {
        Camera *cam = GetCamera();
        cam->SetCameraPos(ComputeCamPos());
    }

    float CameraMgr::GetFieldOfView() {
        Camera *cam = GetCamera();
        return cam->GetFieldOfView();
    }

    float CameraMgr::GetYaw() {
        Camera *cam = GetCamera();
        return cam->GetYaw();
    }
} // namespace GW
