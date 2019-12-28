#include "stdafx.h"

#include <GWCA/Packets/CtoSHeaders.h>
#include <GWCA/Utilities/Export.h>
#include <GWCA/Utilities/Macros.h>
#include <GWCA/Utilities/Hooker.h>
#include <GWCA/Utilities/Scanner.h>

#include <GWCA/GameContainers/GamePos.h>

#include <GWCA/GameEntities/Agent.h>
#include <GWCA/GameEntities/Party.h>

#include <GWCA/Context/GameContext.h>
#include <GWCA/Context/PartyContext.h>

#include <GWCA/Managers/Module.h>

#include <GWCA/Managers/CtoSMgr.h>
#include <GWCA/Managers/AgentMgr.h>
#include <GWCA/Managers/PartyMgr.h>

namespace {
    using namespace GW;

#if 0
    typedef uint32_t (__stdcall *Tick_pt)(uint32_t unk1);
    Tick_pt RetTick;
    Tick_pt Tick_Func;

    bool tick_work_as_toggle = false;

    // Parameter is always 1 or 2 creating "Ready" or "Not ready"
    uint32_t __stdcall OnTick(uint32_t unk1) {
        HookBase::EnterHook();
        // this func is always called twice so use this hack to tick only once
        static bool toggle = true;
        toggle = !toggle;

        uint32_t retval = 4;
        if (!tick_work_as_toggle) {
            retval = RetTick(unk1);
        } else if (!toggle) {
            PartyMgr::Tick(!PartyMgr::GetIsPlayerTicked());
        }
        HookBase::LeaveHook();
        return retval;
    }
#endif

    void Init() {
    #if 0
        // @Replace:
        // This actually doesn't work, but the pattern is the right place
        Tick_pt Tick_Func = (Tick_pt)Scanner::Find(
            "\x83\xC4\x04\xE9\x00\x00\x00\x00\x68\x8D\x01\x01", "xxxx????xxx", +8);
        printf("[SCAN] addr_tick = %p\n", Tick_Func);

        if (Verify(Tick_Func))
            HookBase::CreateHook(Tick_Func, OnTick, (void **)&RetTick);
    #endif
    }

    void Exit() {
    #if 0
        if (Tick_Func)
            HookBase::RemoveHook(Tick_Func);
    #endif
    }
}

namespace GW {

    Module PartyModule = {
        "PartyModule",  // name
        NULL,           // param
        ::Init,         // init_module
        ::Exit,         // exit_module
        NULL,           // enable_hooks
        NULL,           // disable_hooks
    };
    
    void PartyMgr::Tick(bool flag) {
        CtoS::SendPacket(0x8, CtoGS_MSGTick, flag);
    }

    PartyInfo* PartyMgr::GetPartyInfo() {
        return GameContext::instance()->party->player_party;
    }

    uint32_t PartyMgr::GetPartySize() {
        PartyInfo* info = GetPartyInfo();
        if (info == nullptr) return 0;
        return info->players.size() + info->heroes.size() + info->henchmen.size();
    }

    uint32_t PartyMgr::GetPartyPlayerCount() {
        if (GetPartyInfo()) {
            return GetPartyInfo()->players.size();
        } else {
            return 0;
        }
    }
    uint32_t PartyMgr::GetPartyHeroCount() {
        if (GetPartyInfo()) {
            return GetPartyInfo()->heroes.size();
        } else {
            return 0;
        }
    }
    uint32_t PartyMgr::GetPartyHenchmanCount() {
        if (GetPartyInfo()) {
            return GetPartyInfo()->henchmen.size();
        } else {
            return 0;
        }
    }

    bool PartyMgr::GetIsPartyDefeated() {
        return GameContext::instance()->party->IsDefeated(); 
    }

    void PartyMgr::SetHardMode(bool flag) {
        CtoS::SendPacket(0x8, CtoGS_MSGSwitchMode, flag);
    }
    bool PartyMgr::GetIsPartyInHardMode() {
        return GameContext::instance()->party->InHardMode();
    }

    bool PartyMgr::GetIsPartyTicked() {
        PartyInfo* info = GetPartyInfo();
        if (info == nullptr) return false;
        if (!info->players.valid()) return false;
        for (PlayerPartyMember player : info->players) {
            if (!player.ticked()) return false;
        }
        return true;
    }

    bool PartyMgr::GetIsPartyLoaded() {
        PartyInfo* info = GetPartyInfo();
        if (info == nullptr) return false;
        if (!info->players.valid()) return false;
        for (PlayerPartyMember player : info->players) {
            if (!player.connected()) return false;
        }
        return true;
    }

    bool PartyMgr::GetIsTicked(uint32_t player_index) {
        PartyInfo* info = GetPartyInfo();
        if (info == nullptr) return false;
        if (!info->players.valid()) return false;
        if (player_index >= info->players.size()) return false;
        return (info->players[player_index].ticked());
    }

    bool PartyMgr::GetIsPlayerTicked() {
        PartyInfo* info = GetPartyInfo();
        if (info == nullptr) return false;
        if (!info->players.valid()) return false;
        Agent* me = Agents::GetPlayer();
        if (me == nullptr) return false;
        for (uint32_t i = 0; i < info->players.size(); i++) {
            if (info->players[i].login_number == me->login_number) {
                return info->players[i].ticked();
            }
        }
        return false;
    }

    bool PartyMgr::GetPlayerIsLeader() {
        PartyInfo *party = GetPartyInfo();
        if (!party) return false;
        Agent *player_agent = Agents::GetPlayer();
        if (!player_agent) return false;
        if (!party->players.size()) return false;
        return (party->players[0].login_number == player_agent->login_number);
    }

    void PartyMgr::RespondToPartyRequest(bool accept) {
        CtoS::SendPacket(0x8, accept ? CtoGS_MSGAcceptPartyRequest : CtoGS_MSGDenyPartyRequest, 1);
    }

    void PartyMgr::AddHero(uint32_t heroid) {
        CtoS::SendPacket(0x8, CtoGS_MSGAddHero, heroid);
    }

    void PartyMgr::KickHero(uint32_t heroid) {
        CtoS::SendPacket(0x8, CtoGS_MSGKickHero, heroid);
    }

    void PartyMgr::KickAllHeroes() {
        KickHero(0x26);
    }

    void PartyMgr::LeaveParty() {
        CtoS::SendPacket(0x4, CtoGS_MSGLeaveParty);
    }

    void PartyMgr::FlagHero(uint32_t hero_index, GamePos pos) {
        uint32_t agent_id = Agents::GetHeroAgentID(hero_index);
        FlagHeroAgent(agent_id, pos);
    }

    void PartyMgr::FlagHeroAgent(AgentID agent_id, GamePos pos) {
        struct FlagHero { // Flag Hero
            const uint32_t header = CtoGS_MSGCommandHero;
            uint32_t id;
            GamePos pos;
        };
        if (agent_id == 0) return;
        if (agent_id == Agents::GetPlayerId()) return;
        static FlagHero pak; // TODO
        pak.id = agent_id;
        pak.pos = pos;
        CtoS::SendPacket(&pak);
    }

    void PartyMgr::FlagAll(GamePos pos) {
        struct FlagAll { // Flag All
            const uint32_t header = CtoGS_MSGCommandAll;
            GamePos pos;
        };
        static FlagAll pak;
        pak.pos = pos; // TODO
        CtoS::SendPacket(&pak);
    }

    void PartyMgr::UnflagHero(uint32_t hero_index) {
        FlagHero(hero_index, GamePos(HUGE_VALF, HUGE_VALF, 0));
    }

    void PartyMgr::UnflagAll() {
        FlagAll(GamePos(HUGE_VALF, HUGE_VALF, 0)); 
    }

#if 0
    void PartyMgr::SetTickToggle(bool enable) {
        tick_work_as_toggle = enable;
    }
#endif

} // namespace GW