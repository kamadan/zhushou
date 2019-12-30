﻿#include "stdafx.h"
#include "Hotkeys.h"

#include <GWCA\Constants\Constants.h>
#include <GWCA\GameContainers\Array.h>
#include <GWCA\GameContainers\GamePos.h>

#include <GWCA\GameEntities\Agent.h>
#include <GWCA\GameEntities\Skill.h>

#include <GWCA\Managers\ChatMgr.h>
#include <GWCA\Managers\ItemMgr.h>
#include <GWCA\Managers\AgentMgr.h>
#include <GWCA\Managers\EffectMgr.h>
#include <GWCA\Managers\PlayerMgr.h>
#include <GWCA\Managers\SkillbarMgr.h>

#include "logger.h"
#include <Keys.h>
#include "BuildsWindow.h"
#include "HeroBuildsWindow.h"
#include "HotkeysWindow.h"
#include "PconsWindow.h"
#include <ImGuiAddons.h>


bool TBHotkey::show_active_in_header = true;
bool TBHotkey::show_run_in_header = true;
bool TBHotkey::hotkeys_changed = false;
unsigned int TBHotkey::cur_ui_id = 0;

TBHotkey* TBHotkey::HotkeyFactory(CSimpleIni* ini, const char* section) {
	std::string str(section);
	if (str.compare(0, 7, "hotkey-") != 0) return nullptr;
	size_t first_sep = 6;
	size_t second_sep = str.find(L':', first_sep);
	std::string id = str.substr(first_sep + 1, second_sep - first_sep - 1);
	std::string type = str.substr(second_sep + 1);

	if (type.compare(HotkeySendChat::IniSection()) == 0) {
		return new HotkeySendChat(ini, section);
	} else if (type.compare(HotkeyUseItem::IniSection()) == 0) {
		return new HotkeyUseItem(ini, section);
	} else if (type.compare(HotkeyDropUseBuff::IniSection()) == 0) {
		return new HotkeyDropUseBuff(ini, section);
	} else if (type.compare(HotkeyToggle::IniSection()) == 0) {
		return new HotkeyToggle(ini, section);
	} else if (type.compare(HotkeyAction::IniSection()) == 0) {
		return new HotkeyAction(ini, section);
	} else if (type.compare(HotkeyTarget::IniSection()) == 0) {
		return new HotkeyTarget(ini, section);
	} else if (type.compare(HotkeyMove::IniSection()) == 0) {
		return new HotkeyMove(ini, section);
	} else if (type.compare(HotkeyDialog::IniSection()) == 0) {
		return new HotkeyDialog(ini, section);
	} else if (type.compare(HotkeyPingBuild::IniSection()) == 0) {
		return new HotkeyPingBuild(ini, section);
	} else if (type.compare(HotkeyHeroTeamBuild::IniSection()) == 0) {
		return new HotkeyHeroTeamBuild(ini, section);
	} else {
		return nullptr;
	}
}

TBHotkey::TBHotkey(CSimpleIni* ini, const char* section) : ui_id(++cur_ui_id) {
	hotkey = ini ? ini->GetLongValue(section, VAR_NAME(hotkey), 0) : 0;
	modifier = ini ? ini->GetLongValue(section, VAR_NAME(modifier), 0) : 0;
	active = ini ? ini->GetBoolValue(section, VAR_NAME(active), true) : true;
}
void TBHotkey::Save(CSimpleIni* ini, const char* section) const {
	ini->SetLongValue(section, VAR_NAME(hotkey), hotkey);
	ini->SetLongValue(section, VAR_NAME(modifier), modifier);
	ini->SetBoolValue(section, VAR_NAME(active), active);
}
void TBHotkey::Draw(Op* op) {
	auto ShowHeaderButtons = [&]() {
		if (show_active_in_header || show_run_in_header) {
			ImGui::PushID(ui_id);
			ImGui::PushID("header");
			ImGuiStyle& style = ImGui::GetStyle();
			if (show_active_in_header) {
				ImGui::SameLine(ImGui::GetContentRegionAvailWidth() 
					- ImGui::GetTextLineHeight() 
					- style.FramePadding.y * 2
					- (show_run_in_header ? (50.0f + ImGui::GetStyle().ItemSpacing.x) : 0));
				if (ImGui::Checkbox("", &active)) hotkeys_changed = true;
				if (ImGui::IsItemHovered()) ImGui::SetTooltip("The hotkey can trigger only when selected");
			}
			if (show_run_in_header) {
				ImGui::SameLine(ImGui::GetContentRegionAvailWidth() - 50.0f);
				if (ImGui::Button("Run", ImVec2(50.0f, 0.0f))) {
					Execute();
				}
			}
			ImGui::PopID();
			ImGui::PopID();
		}
	};

	// === Header ===
	char header[256];
	char desbuf[128];
	char keybuf[128];
	Description(desbuf, 128);
	ModKeyName(keybuf, 128, modifier, hotkey, "<None>");
	snprintf(header, 128, "%s [%s]###header%u", desbuf, keybuf, ui_id);
	ImGuiTreeNodeFlags flags = (show_active_in_header || show_run_in_header) 
		? ImGuiTreeNodeFlags_AllowItemOverlap : 0;
	if (!ImGui::CollapsingHeader(header, flags)) {
		ShowHeaderButtons();
	} else {
		ShowHeaderButtons();
		ImGui::PushID(ui_id);
		ImGui::PushItemWidth(-70.0f);
		// === Specific section ===
		Draw();

		// === Hotkey section ===
		ImGui::Separator();
		if (ImGui::Checkbox("###active", &active)) hotkeys_changed = true;
		if (ImGui::IsItemHovered()) ImGui::SetTooltip("The hotkey can trigger only when selected");
		ImGui::SameLine();
		static LONG newkey = 0;
		char keybuf2[128];
		snprintf(keybuf2, 128, "快键: %s", keybuf);
		if (ImGui::Button(keybuf2, ImVec2(-70.0f, 0))) {
			ImGui::OpenPopup("选择快键");
			newkey = 0;
		}
		if (ImGui::IsItemHovered()) ImGui::SetTooltip("击此以重配快键");
		if (ImGui::BeginPopup("选择快键")) {
			*op = Op_BlockInput;
			ImGui::Text("按键");
			int newmod = 0;
			if (ImGui::GetIO().KeyCtrl) newmod |= ModKey_Control;
			if (ImGui::GetIO().KeyAlt) newmod |= ModKey_Alt;
			if (ImGui::GetIO().KeyShift) newmod |= ModKey_Shift;

			if (newkey == 0) { // we are looking for the key
				for (int i = 0; i < 512; ++i) {
					if (i == VK_CONTROL) continue;
					if (i == VK_SHIFT) continue;
					if (i == VK_MENU) continue;
					if (ImGui::GetIO().KeysDown[i]) {
						newkey = i;
					}
				}
			} else { // key was pressed, close if it's released
				if (!ImGui::GetIO().KeysDown[newkey]) {
					hotkey = newkey;
					modifier = newmod;
					ImGui::CloseCurrentPopup();
					hotkeys_changed = true;
				}
			}

			// write the key
			char newkey_buf[256];
			ModKeyName(newkey_buf, 256, newmod, newkey);
			ImGui::Text("%s", newkey_buf);
			if (ImGui::Button("取消", ImVec2(-1.0f, 0))) ImGui::CloseCurrentPopup();
			ImGui::EndPopup();
		}
		ImGui::SameLine();
		if (ImGui::Button("Run", ImVec2(70.0f, 0.0f))) {
			Execute();
		}
		if (ImGui::IsItemHovered()) ImGui::SetTooltip("即刻触发快键");

		// === Move and delete buttons ===
		if (ImGui::Button("Move Up", ImVec2(ImGui::GetWindowContentRegionWidth() / 3.0f, 0))) {
			*op = Op_MoveUp;
			hotkeys_changed = true;
		}
		if (ImGui::IsItemHovered()) ImGui::SetTooltip("Move the hotkey up in the list");
		ImGui::SameLine();
		if (ImGui::Button("Move Down", ImVec2(ImGui::GetWindowContentRegionWidth() / 3.0f, 0))) {
			*op = Op_MoveDown;
			hotkeys_changed = true;
		}
		if (ImGui::IsItemHovered()) ImGui::SetTooltip("Move the hotkey down in the list");
		ImGui::SameLine();
		if (ImGui::Button("删除", ImVec2(ImGui::GetWindowContentRegionWidth() / 3.0f, 0))) {
			ImGui::OpenPopup("删除快键?");
		}
		if (ImGui::IsItemHovered()) ImGui::SetTooltip("删除快键");
		if (ImGui::BeginPopupModal("删除快键?", nullptr, ImGuiWindowFlags_AlwaysAutoResize)) {
			ImGui::Text("Are you sure?\nThis operation cannot be undone\n\n", Name());
			if (ImGui::Button("OK", ImVec2(120, 0))) {
				*op = Op_Delete;
				hotkeys_changed = true;
				ImGui::CloseCurrentPopup();
			}
			ImGui::SameLine();
			if (ImGui::Button("取消", ImVec2(120, 0))) {
				ImGui::CloseCurrentPopup();
			}
			ImGui::EndPopup();
		}
		ImGui::PopItemWidth();
		ImGui::PopID();
	}
}

HotkeySendChat::HotkeySendChat(CSimpleIni* ini, const char* section) 
	: TBHotkey(ini, section) {
	strcpy_s(message, ini ? ini->GetValue(section, "msg", "") : "");
	channel = ini ? ini->GetValue(section, "频道", "/")[0] : '/';
}
void HotkeySendChat::Save(CSimpleIni* ini, const char* section) const {
	TBHotkey::Save(ini, section);
	ini->SetValue(section, "msg", message);
	char buf[8];
	snprintf(buf, 8, "%c", channel);
	ini->SetValue(section, "频道", buf);
}
void HotkeySendChat::Description(char* buf, int bufsz) const {
	snprintf(buf, bufsz, "Send chat '%c%s'", channel, message);
}
void HotkeySendChat::Draw() {
	int index = 0;
	switch (channel) {
	case '/': index = 0; break;
	case '!': index = 1; break;
	case '@': index = 2; break;
	case '#': index = 3; break;
	case '$': index = 4; break;
	case '%': index = 5; break;
	case '"': index = 6; break;
	}
	static const char* channels[] = {
		"/ Commands",
		"! 地区频道",
		"@ 公会频道",
		"# 队伍频道",
		"$ 交易频道",
		"% 同盟频道",
		"\" Whisper"
	};
	if (ImGui::Combo("频道", &index, channels, 7)) {
		switch (index) {
		case 0: channel = '/'; break;
		case 1: channel = '!'; break;
		case 2: channel = '@'; break;
		case 3: channel = '#'; break;
		case 4: channel = '$'; break;
		case 5: channel = '%'; break;
		case 6: channel = '"'; break;
		default: channel = '/';break;
		}
		hotkeys_changed = true;
	}
	if (ImGui::InputText("Message", message, 139)) hotkeys_changed = true;
}
void HotkeySendChat::Execute() {
	if (isLoading()) return;
	if (channel == L'/') {
		Log::Info("/%s", message);
	}
	GW::Chat::SendChat(channel, message);
}

HotkeyUseItem::HotkeyUseItem(CSimpleIni* ini, const char* section) : TBHotkey(ini, section) {
	item_id = ini ? ini->GetLongValue(section, "ItemID", 0) : 0;
	strcpy_s(name, ini ? ini->GetValue(section, "ItemName", "") : "");
}
void HotkeyUseItem::Save(CSimpleIni* ini, const char* section) const {
	TBHotkey::Save(ini, section);
	ini->SetLongValue(section, "ItemID", item_id);
	ini->SetValue(section, "ItemName", name);
}
void HotkeyUseItem::Description(char* buf, int bufsz) const {
	if (name[0] == '\0') {
		snprintf(buf, bufsz, "Use #%d", item_id);
	} else {
		snprintf(buf, bufsz, "Use %s", name);
	}
}
void HotkeyUseItem::Draw() {
	if (ImGui::InputInt("Item ID", (int*)&item_id)) hotkeys_changed = true;
	if (ImGui::InputText("Item Name", name, 140)) hotkeys_changed = true;
}
void HotkeyUseItem::Execute() {
	if (isLoading()) return;
	if (item_id == 0) return;

	bool used = GW::Items::UseItemByModelId(item_id, 1, 4);
	if (!used && GW::Map::GetInstanceType() == GW::Constants::InstanceType::Outpost) {
		used = GW::Items::UseItemByModelId(item_id, 8, 16);
	}

	if (!used) {
		if (name[0] == '\0') {
			Log::Info("Item #%d not found!", item_id);
		} else {
			Log::Info("%s 失寻!", name);
		}
	}
}

bool HotkeyDropUseBuff::GetText(void* data, int idx, const char** out_text) {
	static char other_buf[64];
	switch ((SkillIndex)idx) {
	case Recall: *out_text = "回归"; break;
	case UA: *out_text = "UA"; break;
	case HolyVeil: *out_text = "神圣遮罩"; break;
	default:
		snprintf(other_buf, 64, "Skill#%d", (int)data);
		*out_text = other_buf;
		break;
	}
	return true;
}
HotkeyDropUseBuff::SkillIndex HotkeyDropUseBuff::GetIndex() const {
	switch (id) {
	case GW::Constants::SkillID::Recall: return Recall;
	case GW::Constants::SkillID::Unyielding_Aura: return UA;
	case GW::Constants::SkillID::Holy_Veil: return HolyVeil;
	default: return Other;
	}
}
HotkeyDropUseBuff::HotkeyDropUseBuff(CSimpleIni* ini, const char* section) : TBHotkey(ini, section) {
	id = ini ? (GW::Constants::SkillID)ini->GetLongValue(
		section, "技能号", (long)GW::Constants::SkillID::Recall) : GW::Constants::SkillID::Recall;
}
void HotkeyDropUseBuff::Save(CSimpleIni* ini, const char* section) const {
	TBHotkey::Save(ini, section);
	ini->SetLongValue(section, "技能号", (long)id);
}
void HotkeyDropUseBuff::Description(char* buf, int bufsz) const {
	const char* skillname;
	GetText((void*)id, GetIndex(), &skillname);
	snprintf(buf, bufsz, "Drop/Use %s", skillname);
}
void HotkeyDropUseBuff::Draw() {
	SkillIndex index = GetIndex();
	if (ImGui::Combo("Skill", (int*)&index, "回归\0坚毅灵气\0神圣遮罩\0其他", 4)) {
		switch (index) {
		case HotkeyDropUseBuff::Recall: id = GW::Constants::SkillID::Recall; break;
		case HotkeyDropUseBuff::UA: id = GW::Constants::SkillID::Unyielding_Aura; break;
		case HotkeyDropUseBuff::HolyVeil: id = GW::Constants::SkillID::Holy_Veil; break;
		case HotkeyDropUseBuff::Other: id = (GW::Constants::SkillID)0; break;
		default: break;
		}
		hotkeys_changed = true;
	}
	if (index == Other) {
		if (ImGui::InputInt("Skill ID", (int*)&id)) hotkeys_changed = true;
	}
}
void HotkeyDropUseBuff::Execute() {
	if (!isExplorable()) return;

	GW::Buff *buff = GW::Effects::GetPlayerBuffBySkillId(id);
	if (buff && buff->skill_id) {
		GW::Effects::DropBuff(buff->buff_id);
	} else {
		int slot = GW::SkillbarMgr::GetSkillSlot(id);
		if (slot >= 0 && GW::SkillbarMgr::GetPlayerSkillbar()->skills[slot].recharge == 0) {
			GW::SkillbarMgr::UseSkill(slot, GW::Agents::GetTargetId(), ImGui::IsKeyDown(VK_CONTROL));
		}
	}
}

bool HotkeyToggle::GetText(void*, int idx, const char** out_text) {
	switch ((Toggle)idx) {
	case Clicker: *out_text = "Clicker"; return true;
	case Pcons: *out_text = "补品"; return true;
	case CoinDrop: *out_text = "Coin Drop"; return true;
	default: return false;
	}
}
HotkeyToggle::HotkeyToggle(CSimpleIni* ini, const char* section) : TBHotkey(ini, section) {
	target = ini ? (Toggle)ini->GetLongValue(section, "ToggleID", (long)Clicker) : Clicker;
}
void HotkeyToggle::Save(CSimpleIni* ini, const char* section) const {
	TBHotkey::Save(ini, section);
	ini->SetLongValue(section, "ToggleID", (long)target);
}
void HotkeyToggle::Description(char* buf, int bufsz) const {
	const char* name;
	GetText(nullptr, (int)target, &name);
	snprintf(buf, bufsz, "Toggle %s", name);
}
void HotkeyToggle::Draw() {
	if (ImGui::Combo("Toggle###combo", (int*)&target, GetText, nullptr, n_targets)) hotkeys_changed = true;
}
void HotkeyToggle::Execute() {
	bool active;
	switch (target) {
	case HotkeyToggle::Clicker:
		active = HotkeysWindow::Instance().ToggleClicker();
		Log::Info("Clicker is %s", active ? "active" : "已关闭");
		break;
	case HotkeyToggle::Pcons:
		PconsWindow::Instance().ToggleEnable();
		// writing to chat is done by ToggleActive if needed
		break;
	case HotkeyToggle::CoinDrop:
		active = HotkeysWindow::Instance().ToggleCoinDrop();
		Log::Info("Coin dropper is %s", active ? "active" : "已关闭");
		break;
	}
}

bool HotkeyAction::GetText(void*, int idx, const char** out_text) {
	switch ((Action)idx) {
	case OpenXunlaiChest: *out_text = "打开桑莱保险箱"; return true;
	case OpenLockedChest: *out_text = "打开锁住的宝箱"; return true;
	case DropGoldCoin: *out_text = "Drop Gold Coin"; return true;
	case ReapplyTitle: *out_text = "重新展示相关头衔"; return true;
	case EnterChallenge: *out_text = "进入挑战任务"; return true;
	default: return false;
	}
}
HotkeyAction::HotkeyAction(CSimpleIni* ini, const char* section) : TBHotkey(ini, section) {
	action = ini ? (Action)ini->GetLongValue(section, "ActionID", (long)OpenXunlaiChest) : OpenXunlaiChest;
}
void HotkeyAction::Save(CSimpleIni* ini, const char* section) const {
	TBHotkey::Save(ini, section);
	ini->SetLongValue(section, "ActionID", (long)action);
}
void HotkeyAction::Description(char* buf, int bufsz) const {
	const char* name;
	GetText(nullptr, (int)action, &name);
	snprintf(buf, bufsz, "%s", name);
}
void HotkeyAction::Draw() {
	if (ImGui::Combo("Action###combo", (int*)&action, GetText, nullptr, n_actions)) hotkeys_changed = true;
}
void HotkeyAction::Execute() {
	if (isLoading()) return;
	switch (action) {
	case HotkeyAction::OpenXunlaiChest:
		if (isOutpost()) {
			GW::Items::OpenXunlaiWindow();
		}
		break;
	case HotkeyAction::OpenLockedChest: {
		if (isExplorable()) {
			GW::Agent* target = GW::Agents::GetTarget();
			if (target && target->type == 0x200) {
				GW::Agents::GoSignpost(target);
				GW::Items::OpenLockedChest();
			}
		}
		break;
	}
	case HotkeyAction::DropGoldCoin:
		if (isExplorable()) {
			GW::Items::DropGold(1);
		}
		break;
	case HotkeyAction::ReapplyTitle:
		GW::PlayerMgr::RemoveActiveTitle();

		switch (GW::Map::GetMapID()) {
		case GW::Constants::MapID::Rata_Sum_outpost:
		case GW::Constants::MapID::Tarnished_Haven_outpost:
		case GW::Constants::MapID::Vloxs_Falls:
		case GW::Constants::MapID::Gadds_Encampment_outpost:
		case GW::Constants::MapID::Umbral_Grotto_outpost:
		case GW::Constants::MapID::Magus_Stones:
		case GW::Constants::MapID::Riven_Earth:
		case GW::Constants::MapID::Arbor_Bay:
		case GW::Constants::MapID::Alcazia_Tangle:
		case GW::Constants::MapID::Sparkfly_Swamp:
		case GW::Constants::MapID::Verdant_Cascades:
			GW::PlayerMgr::SetActiveTitle(GW::Constants::TitleID::Asuran);
			break;
		case GW::Constants::MapID::Glints_Challenge_mission:
		case GW::Constants::MapID::Central_Transfer_Chamber_outpost:
		case GW::Constants::MapID::Genius_Operated_Living_Enchanted_Manifestation:
		case GW::Constants::MapID::A_Gate_Too_Far_Level_1:
		case GW::Constants::MapID::A_Gate_Too_Far_Level_2:
		case GW::Constants::MapID::A_Gate_Too_Far_Level_3:
		case GW::Constants::MapID::Destructions_Depths_Level_1:
		case GW::Constants::MapID::Destructions_Depths_Level_2:
		case GW::Constants::MapID::Destructions_Depths_Level_3:
		case GW::Constants::MapID::A_Time_for_Heroes:
		case GW::Constants::MapID::Ravens_Point_Level_1:
		case GW::Constants::MapID::Ravens_Point_Level_2:
		case GW::Constants::MapID::Ravens_Point_Level_3:
			GW::PlayerMgr::SetActiveTitle(GW::Constants::TitleID::Deldrimor);
			break;
		case GW::Constants::MapID::Boreal_Station_outpost:
		case GW::Constants::MapID::Eye_of_the_North_outpost:
		case GW::Constants::MapID::Gunnars_Hold_outpost:
		case GW::Constants::MapID::Sifhalla_outpost:
		case GW::Constants::MapID::Olafstead_outpost:
		case GW::Constants::MapID::Ice_Cliff_Chasms:
		case GW::Constants::MapID::Norrhart_Domains:
		case GW::Constants::MapID::Drakkar_Lake:
		case GW::Constants::MapID::Jaga_Moraine:
		case GW::Constants::MapID::Bjora_Marches:
		case GW::Constants::MapID::Varajar_Fells:
		case GW::Constants::MapID::Attack_of_the_Nornbear:
		case GW::Constants::MapID::Curse_of_the_Nornbear:
		case GW::Constants::MapID::Blood_Washes_Blood:
		case GW::Constants::MapID::Mano_a_Norn_o:
		case GW::Constants::MapID::Service_In_Defense_of_the_Eye:
		case GW::Constants::MapID::Cold_as_Ice:
		case GW::Constants::MapID::The_Norn_Fighting_Tournament:				
		// @todo: case MapID for Bear Club for Women/Men
			GW::PlayerMgr::SetActiveTitle(GW::Constants::TitleID::Norn);
			break;
		case GW::Constants::MapID::Doomlore_Shrine_outpost:
		case GW::Constants::MapID::Longeyes_Ledge_outpost:
		case GW::Constants::MapID::Grothmar_Wardowns:
		case GW::Constants::MapID::Dalada_Uplands:
		case GW::Constants::MapID::Sacnoth_Valley:
		case GW::Constants::MapID::Against_the_Charr:
		case GW::Constants::MapID::Warband_of_Brothers_Level_1:
		case GW::Constants::MapID::Warband_of_Brothers_Level_2:
		case GW::Constants::MapID::Warband_of_Brothers_Level_3:
		case GW::Constants::MapID::Assault_on_the_Stronghold:
		case GW::Constants::MapID::Cathedral_of_Flames_Level_1:
		case GW::Constants::MapID::Cathedral_of_Flames_Level_2:
		case GW::Constants::MapID::Cathedral_of_Flames_Level_3:
		case GW::Constants::MapID::Rragars_Menagerie_Level_1:
		case GW::Constants::MapID::Rragars_Menagerie_Level_2:
		case GW::Constants::MapID::Rragars_Menagerie_Level_3:
		case GW::Constants::MapID::Warband_Training:
		case GW::Constants::MapID::Ascalon_City_outpost:
		case GW::Constants::MapID::The_Great_Northern_Wall:
		case GW::Constants::MapID::Fort_Ranik:
		case GW::Constants::MapID::Ruins_of_Surmia:
		case GW::Constants::MapID::Nolani_Academy:
		case GW::Constants::MapID::Frontier_Gate_outpost:
		case GW::Constants::MapID::Grendich_Courthouse_outpost:
		case GW::Constants::MapID::Sardelac_Sanitarium_outpost:
		case GW::Constants::MapID::Piken_Square_outpost:
		case GW::Constants::MapID::Old_Ascalon:
		case GW::Constants::MapID::Regent_Valley:
		case GW::Constants::MapID::The_Breach:
		case GW::Constants::MapID::Diessa_Lowlands:
		case GW::Constants::MapID::Flame_Temple_Corridor:
		case GW::Constants::MapID::Dragons_Gullet:
			GW::PlayerMgr::SetActiveTitle(GW::Constants::TitleID::Vanguard);
			break;
		default:
			GW::PlayerMgr::SetActiveTitle(GW::Constants::TitleID::Lightbringer);
		}
		break;
	case HotkeyAction::EnterChallenge:
		GW::Map::EnterChallenge();
		break;

	}
}

HotkeyTarget::HotkeyTarget(CSimpleIni* ini, const char* section) : TBHotkey(ini, section) {
	id = ini ? ini->GetLongValue(section, "TargetID", 0) : 0;
	strcpy_s(name, ini ? ini->GetValue(section, "TargetName", "") : "");
}
void HotkeyTarget::Save(CSimpleIni* ini, const char* section) const {
	TBHotkey::Save(ini, section);
	ini->SetLongValue(section, "TargetID", id);
	ini->SetValue(section, "TargetName", name);
}
void HotkeyTarget::Description(char* buf, int bufsz) const {
	if (name[0] == '\0') {
		snprintf(buf, bufsz, "Target #%d", id);
	} else {
		snprintf(buf, bufsz, "Target %s", name);
	}
}
void HotkeyTarget::Draw() {
	if (ImGui::InputInt("Target ID", (int*)&id)) hotkeys_changed = true;
	if (ImGui::InputText("Name", name, 140)) hotkeys_changed = true;
}
void HotkeyTarget::Execute() {
	if (isLoading()) return;
	if (id == 0) return;

	GW::AgentArray agents = GW::Agents::GetAgentArray();
	if (!agents.valid()) {
		return;
	}

	GW::Agent* me = agents[GW::Agents::GetPlayerId()];
	if (me == nullptr) return;

	float distance = GW::Constants::SqrRange::Compass;
	int closest = -1;

	for (size_t i = 0; i < agents.size(); ++i) {
		GW::Agent* agent = agents[i];
		if (agent == nullptr) continue;
		if (agent->player_number == id && agent->hp > 0) {
			float newDistance = GW::GetSquareDistance(me->pos, agents[i]->pos);
			if (newDistance < distance) {
				closest = i;
				distance = newDistance;
			}
		}
	}
	if (closest > 0) {
		GW::Agents::ChangeTarget(agents[closest]);
	}
}

HotkeyMove::HotkeyMove(CSimpleIni* ini, const char* section) : TBHotkey(ini, section) {
	x = ini ? (float)ini->GetDoubleValue(section, "x", 0.0) : 0.0f;
	y = ini ? (float)ini->GetDoubleValue(section, "y", 0.0) : 0.0f;
	range = ini ? (float)ini->GetDoubleValue(section, "距离", 5000.0f) : 5000.0f;
	mapid = ini ? ini->GetLongValue(section, "地图号", 0) : 0;
	strcpy_s(name, ini ? ini->GetValue(section, "name", "") : "");
}
void HotkeyMove::Save(CSimpleIni* ini, const char* section) const {
	TBHotkey::Save(ini, section);
	ini->SetDoubleValue(section, "x", x);
	ini->SetDoubleValue(section, "y", y);
	ini->SetDoubleValue(section, "距离", range);
	ini->SetLongValue(section, "地图号", mapid);
	ini->SetValue(section, "name", name);
}
void HotkeyMove::Description(char* buf, int bufsz) const {
	if (name[0] == '\0') {
		snprintf(buf, bufsz, "前往坐标 (%.0f, %.0f)", x, y);
	} else {
		snprintf(buf, bufsz, "前往 %s", name);
	}
}
void HotkeyMove::Draw() {
	if (ImGui::InputFloat("x", &x, 0.0f, 0.0f, 3)) hotkeys_changed = true;
	if (ImGui::InputFloat("y", &y, 0.0f, 0.0f, 3)) hotkeys_changed = true;
	if (ImGui::InputFloat("Range", &range, 0.0f, 0.0f, 0)) hotkeys_changed = true;
	ImGui::ShowHelp("The hotkey will only trigger within this range.\nUse 0 for no limit.");
	if (ImGui::InputInt("Map", (int*)&mapid, 0)) hotkeys_changed = true;
	ImGui::ShowHelp("The hotkey will only trigger in this map.\nUse 0 for any map.");
	if (ImGui::InputText("Name", name, 140)) hotkeys_changed = true;
}
void HotkeyMove::Execute() {
	if (!isExplorable()) return;

	GW::Agent* me = GW::Agents::GetPlayer();
	if (mapid != 0 && mapid != (DWORD)GW::Map::GetMapID()) return;
	double dist = GW::GetDistance(me->pos, GW::Vec2f(x, y));
	if (range != 0 && dist > range) return;
	GW::Agents::Move(x, y);
	if (name[0] == '\0') {
		Log::Info("正在前往坐标 (%.0f, %.0f)", x, y);
	} else {
		Log::Info("正在前往 %s", name);
	}
}

HotkeyDialog::HotkeyDialog(CSimpleIni* ini, const char* section) : TBHotkey(ini, section) {
	id = ini ? ini->GetLongValue(section, "DialogID", 0) : 0;
	strcpy_s(name, ini ? ini->GetValue(section, "DialogName", "") : "");
}
void HotkeyDialog::Save(CSimpleIni* ini, const char* section) const {
	TBHotkey::Save(ini, section);
	ini->SetLongValue(section, "DialogID", id);
	ini->SetValue(section, "DialogName", name);
}
void HotkeyDialog::Description(char* buf, int bufsz) const {
	if (name[0] == '\0') {
		snprintf(buf, bufsz, "Dialog #%d", id);
	} else {
		snprintf(buf, bufsz, "Dialog %s", name);
	}
}
void HotkeyDialog::Draw() {
	if (ImGui::InputInt("Dialog ID", (int*)&id)) hotkeys_changed = true;
	if (ImGui::InputText("Dialog Name", name, 140)) hotkeys_changed = true;
}
void HotkeyDialog::Execute() {
	if (isLoading()) return;
	if (id == 0) return;
	GW::Agents::SendDialog(id);
	Log::Info("已发令码 %s (%d)", name, id);
}

bool HotkeyPingBuild::GetText(void*, int idx, const char** out_text) {
	if (idx >= (int)BuildsWindow::Instance().BuildCount()) return false;
	*out_text = BuildsWindow::Instance().BuildName(idx);
	return true;
}
HotkeyPingBuild::HotkeyPingBuild(CSimpleIni* ini, const char* section) : TBHotkey(ini, section) {
	index = ini ? ini->GetLongValue(section, "样本索引号", 0) : 0;
}
void HotkeyPingBuild::Save(CSimpleIni* ini, const char* section) const {
	TBHotkey::Save(ini, section);
	ini->SetLongValue(section, "样本索引号", index);
}
void HotkeyPingBuild::Description(char* buf, int bufsz) const {
	const char* buildname = BuildsWindow::Instance().BuildName(index);
	if (buildname == nullptr) buildname = "<not found>";
	snprintf(buf, bufsz, "Ping build '%s'", buildname);
}
void HotkeyPingBuild::Draw() {
	if (ImGui::Combo("样本", &index, GetText, nullptr, BuildsWindow::Instance().BuildCount())) hotkeys_changed = true;
}
void HotkeyPingBuild::Execute() {
	if (isLoading()) return;

	BuildsWindow::Instance().Send(index);
}

bool HotkeyHeroTeamBuild::GetText(void*, int idx, const char** out_text) {
	if (idx >= (int)HeroBuildsWindow::Instance().BuildCount()) return false;
	*out_text = HeroBuildsWindow::Instance().BuildName(idx);
	return true;
}
HotkeyHeroTeamBuild::HotkeyHeroTeamBuild(CSimpleIni* ini, const char* section) : TBHotkey(ini, section) {
	index = ini ? ini->GetLongValue(section, "样本索引号", 0) : 0;
}
void HotkeyHeroTeamBuild::Save(CSimpleIni* ini, const char* section) const {
	TBHotkey::Save(ini, section);
	ini->SetLongValue(section, "样本索引号", index);
}
void HotkeyHeroTeamBuild::Description(char* buf, int bufsz) const {
	const char* buildname = HeroBuildsWindow::Instance().BuildName(index);
	if (buildname == nullptr) buildname = "<not found>";
	snprintf(buf, bufsz, "Load Team Hero Build '%s'", buildname);
}
void HotkeyHeroTeamBuild::Draw() {
	if (ImGui::Combo("样本", &index, GetText, nullptr, HeroBuildsWindow::Instance().BuildCount())) hotkeys_changed = true;
}
void HotkeyHeroTeamBuild::Execute() {
	if (isLoading()) return;

	HeroBuildsWindow::Instance().Load(index);
}
