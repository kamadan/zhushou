﻿#pragma once

#include <Defines.h>

#include <GWCA/Constants/Constants.h>
#include <GWCA/Packets/StoC.h>

#include "ToolboxWidget.h"
#include "Timer.h"
#include "Color.h"

class PartyDamage : public ToolboxWidget {
	static const int MAX_PLAYERS = 12;

	struct PlayerDamage {
		long damage = 0;
		long recent_damage = 0;
		clock_t last_damage = 0;
		long agent_id = 0;
		std::wstring name;
		GW::Constants::Profession primary = GW::Constants::Profession::None;
		GW::Constants::Profession secondary = GW::Constants::Profession::None;

		void Reset() {
			damage = 0;
			recent_damage = 0;
			agent_id = 0;
			name = L"";
			primary = GW::Constants::Profession::None;
			secondary = GW::Constants::Profession::None;
		}
	};

	PartyDamage() {};
	~PartyDamage() {};
public:
	static PartyDamage& Instance() {
		static PartyDamage instance;
		return instance;
	}

	const char* Name() const override { return "Damage"; }

	void Initialize() override;
	void Terminate() override;

	// Draw user interface. Will be called every frame if the element is visible
	void Draw(IDirect3DDevice9* pDevice) override;

	void Update(float delta) override;

	void LoadSettings(CSimpleIni* ini) override;
	void SaveSettings(CSimpleIni* ini) override;
	void DrawSettings() override;
	void DrawSettingInternal() override;

	void WritePartyDamage();
	void WriteDamageOf(int index, int rank = 0); // party index from 0 to 12
	void WriteOwnDamage();
	void ResetDamage();

private:
	void DamagePacketCallback(GW::HookStatus *, GW::Packet::StoC::GenericModifier *packet);
	void MapLoadedCallback(GW::HookStatus *, GW::Packet::StoC::MapLoaded *packet);

	void CreatePartyIndexMap();

	float GetPartOfTotal(long dmg) const;
	inline float GetPercentageOfTotal(long dmg) const
	{ return GetPartOfTotal(dmg) * 100.0f; };

	// damage values
	long total = 0;
	PlayerDamage damage[MAX_PLAYERS];
	std::map<DWORD, long> hp_map;
	std::map<DWORD, int> party_index;
	int player_index = 0;

	// main routine variables
	bool in_explorable = false;
	clock_t send_timer = 0;
	std::queue<std::wstring> send_queue;

	// ini
	CSimpleIni* inifile = nullptr;
	Color color_background = 0;
	Color color_damage = 0;
	Color color_recent = 0;
	float width = 0.f;
	bool bars_left = false;
	int recent_max_time = 0;
	int row_height = 0;

	GW::HookEntry GenericModifier_Entry;
	GW::HookEntry MapLoaded_Entry;
};
