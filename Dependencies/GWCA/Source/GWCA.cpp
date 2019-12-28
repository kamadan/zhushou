#include "stdafx.h"

#include <GWCA/GWCA.h>

#include <GWCA/Constants/Constants.h>

#include <GWCA/GameContainers/Array.h>
#include <GWCA/GameContainers/GamePos.h>
#include <GWCA/Packets/StoC.h>

#include <GWCA/Utilities/Hooker.h>
#include <GWCA/Utilities/Macros.h>
#include <GWCA/Utilities/Scanner.h>

#include <GWCA/Context/GameContext.h>

#include <GWCA/Managers/Module.h>

#include <GWCA/Managers/UIMgr.h>
#include <GWCA/Managers/MapMgr.h>
#include <GWCA/Managers/ChatMgr.h>
#include <GWCA/Managers/CtoSMgr.h>
#include <GWCA/Managers/ItemMgr.h>
#include <GWCA/Managers/StoCMgr.h>
#include <GWCA/Managers/AgentMgr.h>
#include <GWCA/Managers/GuildMgr.h>
#include <GWCA/Managers/PartyMgr.h>
#include <GWCA/Managers/TradeMgr.h>
#include <GWCA/Managers/CameraMgr.h>
#include <GWCA/Managers/EffectMgr.h>
#include <GWCA/Managers/RenderMgr.h>
#include <GWCA/Managers/PlayerMgr.h>
#include <GWCA/Managers/MemoryMgr.h>
#include <GWCA/Managers/MerchantMgr.h>
#include <GWCA/Managers/SkillbarMgr.h>
#include <GWCA/Managers/GameThreadMgr.h>
#include <GWCA/Managers/FriendListMgr.h>

namespace GW {
    static std::vector<Module *> modules;
    static uintptr_t base_ptr;

    bool Initialize() {
        modules.push_back(&UIModule);
        modules.push_back(&MapModule);
        modules.push_back(&ChatModule);
        modules.push_back(&CtoSModule);
        modules.push_back(&ItemModule);
        modules.push_back(&StoCModule);
        modules.push_back(&AgentModule);
        modules.push_back(&GuildModule);
        modules.push_back(&PartyModule);
        modules.push_back(&TradeModule);
        modules.push_back(&CameraModule);
        modules.push_back(&EffectModule);
        modules.push_back(&PlayerModule);
        modules.push_back(&RenderModule);
        modules.push_back(&MerchantModule);
        modules.push_back(&SkillbarModule);
        modules.push_back(&GameThreadModule);
        modules.push_back(&FriendListModule);

        if (MemoryMgr::Scan()) {

            // We could get it from thread ctx
            uintptr_t address = Scanner::Find("\x50\x6A\x0F\x6A\x00\xFF\x35", "xxxxxxx", +7);
            printf("[SCAN] base_ptr = %p\n", (void *)address);
            if (Verify(address))
                base_ptr = *(uintptr_t *)address;

            HookBase::Initialize();

            for (Module *module : modules) {
                printf("Initializing module '%s'\n", module->name);
                if (module->init_module)
                    module->init_module();
            }

            HookBase::EnableHooks();
            for (Module *module : modules) {
                if (module->enable_hooks)
                    module->enable_hooks();
            }

            return true;
        } else {
            return false;
        }
    }

    void DisableHooks() {
        HookBase::DisableHooks();
        for (Module *module : modules) {
            if (module->disable_hooks)
                module->disable_hooks();
        }
    }

    void Terminate() {
        for (Module *module : modules) {
            if (module->exit_module)
                module->exit_module();
        }

        HookBase::Deinitialize();
    }

    GameContext* GameContext::instance() {
        return *(GameContext**)((*(uint8_t **)base_ptr) + 0x18);
    }
} // namespace GW