#include "stdafx.h"
#include "DialogsWindow.h"

#include <GWCA\Constants\Constants.h>
#include <GWCA\GameContainers\Array.h>

#include <GWCA\Managers\AgentMgr.h>

#include "logger.h"
#include "GuiUtils.h"
#include "GWToolbox.h"
#include <Modules\Resources.h>

static const char* const questnames[] = {
	"地下 - 清除密室的障碍",
	"地下 - 古兰斯的使者",
	"地下 - 不速之客",
	"地下 - 恶魔暗杀者",
	"地下 - 被拘禁的亡魂",
	"地下 - 多姆四骑士",
	"地下 - 恐惧蛛化精灵女王",
	"地下 - 护送灵魂",
	"地下 - 恢复古兰斯圣像",
	"地下 - 愤怒的灵魂",
	"灾难 - 保护战争圣殿",
	"灾难 - 黑暗的军队",
	"灾难 - 悲鸣领主",
	"灾难 - 狮鹫兽礼物",
	"灾难 - 孟席斯的奴隶们",
	"灾难 - 恢复圣殿",
	"灾难 - 猎杀碎片狼",
	"灾难 - 永生的锻造大师",
	"灾难 - 力量之塔",
	"灾难 - 勇气之塔",
	"灾难 - 背叛者库贝",
	"四门 - 夺心暗域 1: 死亡召唤大队",
	"四门 - 夺心暗域 2: 异世界的裂缝",
	"DoA - Gloom 3: To The Rescue",
	"四门 - 托加之城",
	"四门 - 冥狱之幕 1: 突破冥狱之幕",
	"四门 - 冥狱之幕 2: 一网打尽",
	"四门 - 铸造厂 1: 失败事物铸造厂",
	"四门 - 铸造厂 2: 逃出铸造厂"
};
static const char* const dialognames[] = {
	"(灾难内)打造黑曜石盔甲",
	"职业更换 - 战士",
	"职业更换 - 游侠",
	"职业更换 - 僧侣",
	"职业更换 - 死灵",
	"职业更换 - 幻术",
	"职业更换 - 元素",
	"职业更换 - 暗杀",
	"职业更换 - 祭祀",
	"职业更换 - 圣言",
	"职业更换 - 神唤",
	"卡玛丹 -> 领事馆码头 @ Hahnna",
	"领事馆码头 -> 凯宁中心 @ 涵洛",
	"领事馆码头 -> 狮门 @ 涵洛",
	"狮门 -> 狮子拱门 @ Neiro",
	"二章任务城",
	"三章任务城",
};

void DialogsWindow::Initialize() {
	ToolboxWindow::Initialize();
	Resources::Instance().LoadTextureAsync(&button_texture, Resources::GetPath(L"img/icons", L"dialogue.png"), IDB_Icon_Dialogue);
}

void DialogsWindow::Draw(IDirect3DDevice9* pDevice) {
	if (!visible) return;
	auto DialogButton = [](int x_idx, int x_qty, const char* text, const char* help, DWORD dialog) -> void {
		if (x_idx != 0) ImGui::SameLine(0, ImGui::GetStyle().ItemInnerSpacing.x);
		float w = (ImGui::GetWindowContentRegionWidth()
			- ImGui::GetStyle().ItemInnerSpacing.x * (x_qty - 1)) / x_qty;
		if (ImGui::Button(text, ImVec2(w, 0))) {
			GW::Agents::SendDialog(dialog);
		}
		if (text != nullptr && ImGui::IsItemHovered()) {
			ImGui::SetTooltip(help);
		}
	};

	ImGui::SetNextWindowPosCenter(ImGuiSetCond_FirstUseEver);
	ImGui::SetNextWindowSize(ImVec2(300, 0), ImGuiSetCond_FirstUseEver);
	if (ImGui::Begin(Name(), GetVisiblePtr(), GetWinFlags())) {

		if (show_common) {
			DialogButton(0, 2, "多姆四骑士", "接混沌平原的任务", QuestAcceptDialog(GW::Constants::QuestID::UW::Planes));
			DialogButton(1, 2, "恶魔暗杀者", "接双头龙山的任务", QuestAcceptDialog(GW::Constants::QuestID::UW::Mnt));
			DialogButton(0, 2, "力量之塔", "接任务", QuestAcceptDialog(GW::Constants::QuestID::Fow::Tos));
			DialogButton(1, 2, "铸造厂奖励2", "接受任务奖励", QuestRewardDialog(GW::Constants::QuestID::Doa::FoundryBreakout));
			ImGui::Separator();
		}
		if (show_uwteles) {
			DialogButton(0, 4, "迷宫", "传送至 地下世界 迷宫", GW::Constants::DialogID::UwTeleLab);
			DialogButton(1, 4, "遗忘谷", "传送至 地下世界 遗忘谷", GW::Constants::DialogID::UwTeleVale);
			DialogButton(2, 4, "骷髅墓穴", "传送至 地下世界 骷髅墓穴", GW::Constants::DialogID::UwTelePits);
			DialogButton(3, 4, "孵化池", "传送至 地下世界 孵化池", GW::Constants::DialogID::UwTelePools);

			DialogButton(0, 3, "混沌平原", "传送至 地下世界 混沌平原", GW::Constants::DialogID::UwTelePlanes);
			DialogButton(1, 3, "荒凉冰地", "传送至 地下世界 荒凉冰地", GW::Constants::DialogID::UwTeleWastes);
			DialogButton(2, 3, "双头龙山", "传送至 地下世界 双头龙山\n此 [非] 龙山 任务", GW::Constants::DialogID::UwTeleMnt);
			ImGui::Separator();
		}
		const int n_quests = _countof(questnames);
		if (show_favorites) {
			for (int i = 0; i < fav_count; ++i) {
				ImGui::PushID(i);
				ImGui::PushItemWidth(-100.0f - ImGui::GetStyle().ItemInnerSpacing.x * 2);
				ImGui::Combo("", &fav_index[i], questnames, n_quests);
				ImGui::PopItemWidth();
				ImGui::SameLine(0, ImGui::GetStyle().ItemInnerSpacing.x);
				if (ImGui::Button("接", ImVec2(40.0f, 0))) {
					GW::Agents::SendDialog(QuestAcceptDialog(IndexToQuestID(fav_index[i])));
				}
				ImGui::SameLine(0, ImGui::GetStyle().ItemInnerSpacing.x);
				if (ImGui::Button("奖励", ImVec2(60.0f, 0))) {
					GW::Agents::SendDialog(QuestRewardDialog(IndexToDialogID(fav_index[i])));
				}
				ImGui::PopID();
			}
			ImGui::Separator();
		}
		if (show_custom) {
			const int n_dialogs = _countof(dialognames);
			static int dialogindex = 0;
			ImGui::PushItemWidth(-60.0f - ImGui::GetStyle().ItemInnerSpacing.x);
			ImGui::Combo("###dialogcombo", &dialogindex, dialognames, n_dialogs);
			ImGui::PopItemWidth();
			ImGui::SameLine(0, ImGui::GetStyle().ItemInnerSpacing.x);
			if (ImGui::Button("发送##1", ImVec2(60.0f, 0))) {
				GW::Agents::SendDialog(IndexToDialogID(dialogindex));
			}

			ImGui::PushItemWidth(-60.0f - ImGui::GetStyle().ItemInnerSpacing.x);
			ImGui::InputText("###dialoginput", customdialogbuf, 64, ImGuiInputTextFlags_None);
			ImGui::PopItemWidth();
			if (ImGui::IsItemHovered()) {
				ImGui::SetTooltip("You can prefix the number by \"0x\" 指定一16位进制的数字");
			}
			ImGui::SameLine(0, ImGui::GetStyle().ItemInnerSpacing.x);
			if (ImGui::Button("发送##2", ImVec2(60.0f, 0))) {
				int id;
				if (GuiUtils::ParseInt(customdialogbuf, &id)) {
					GW::Agents::SendDialog(id);
				} else {
					Log::Error("无效令码 '%s'", customdialogbuf);
				}
			}
		}
	}
	ImGui::End();
}

void DialogsWindow::DrawSettingInternal() {
	ImGui::PushItemWidth(100.0f);
	if (ImGui::InputInt("Number of favorites", &fav_count)) {
		if (fav_count < 0) fav_count = 0;
		if (fav_count > 100) fav_count = 100;
		fav_index.resize(fav_count, 0);
	}
	ImGui::PopItemWidth();
	ImGui::Text("Show:");
	ImGui::Checkbox("Common 4", &show_common);
	ImGui::Checkbox("地下传送", &show_uwteles);
	ImGui::Checkbox("Favorites", &show_favorites);
	ImGui::Checkbox("Custom", &show_custom);
}

void DialogsWindow::LoadSettings(CSimpleIni* ini) {
	ToolboxWindow::LoadSettings(ini);
	show_menubutton = ini->GetBoolValue(Name(), VAR_NAME(show_menubutton), true);

	fav_count = ini->GetLongValue(Name(), VAR_NAME(fav_count), 3);
	fav_index.resize(fav_count, 0);
	for (int i = 0; i < fav_count; ++i) {
		char key[32];
		snprintf(key, 32, "Quest%d", i);
		fav_index[i] = ini->GetLongValue(Name(), key, 0);
	}
	show_common = ini->GetBoolValue(Name(), VAR_NAME(show_common), true);
	show_uwteles = ini->GetBoolValue(Name(), VAR_NAME(show_uwteles), true);
	show_favorites = ini->GetBoolValue(Name(), VAR_NAME(show_favorites), true);
	show_custom = ini->GetBoolValue(Name(), VAR_NAME(show_custom), true);
}

void DialogsWindow::SaveSettings(CSimpleIni* ini) {
	ToolboxWindow::SaveSettings(ini);
	ini->SetLongValue(Name(), "fav_count", fav_count);
	for (int i = 0; i < fav_count; ++i) {
		char key[32];
		snprintf(key, 32, "Quest%d", i);
		ini->SetLongValue(Name(), key, fav_index[i]);
	}
	ini->SetBoolValue(Name(), VAR_NAME(show_common), show_common);
	ini->SetBoolValue(Name(), VAR_NAME(show_uwteles), show_uwteles);
	ini->SetBoolValue(Name(), VAR_NAME(show_favorites), show_favorites);
	ini->SetBoolValue(Name(), VAR_NAME(show_custom), show_custom);
}

DWORD DialogsWindow::IndexToQuestID(int index) {
	switch (index) {
	case 0: return GW::Constants::QuestID::UW::Chamber;
	case 1: return GW::Constants::QuestID::UW::Wastes;
	case 2: return GW::Constants::QuestID::UW::UWG;
	case 3: return GW::Constants::QuestID::UW::Mnt;
	case 4: return GW::Constants::QuestID::UW::Pits;
	case 5: return GW::Constants::QuestID::UW::Planes;
	case 6: return GW::Constants::QuestID::UW::Pools;
	case 7: return GW::Constants::QuestID::UW::Escort;
	case 8: return GW::Constants::QuestID::UW::Restore;
	case 9: return GW::Constants::QuestID::UW::Vale;
	case 10: return GW::Constants::QuestID::Fow::Defend;
	case 11: return GW::Constants::QuestID::Fow::ArmyOfDarknesses;
	case 12: return GW::Constants::QuestID::Fow::WailingLord;
	case 13: return GW::Constants::QuestID::Fow::Griffons;
	case 14: return GW::Constants::QuestID::Fow::Slaves;
	case 15: return GW::Constants::QuestID::Fow::Restore;
	case 16: return GW::Constants::QuestID::Fow::Hunt;
	case 17: return GW::Constants::QuestID::Fow::Forgemaster;
	case 18: return GW::Constants::QuestID::Fow::Tos;
	case 19: return GW::Constants::QuestID::Fow::Toc;
	case 20: return GW::Constants::QuestID::Fow::Khobay;
	case 21: return GW::Constants::QuestID::Doa::DeathbringerCompany;
	case 22: return GW::Constants::QuestID::Doa::RiftBetweenUs;
	case 23: return GW::Constants::QuestID::Doa::ToTheRescue;
	case 24: return GW::Constants::QuestID::Doa::City;
	case 25: return GW::Constants::QuestID::Doa::BreachingStygianVeil;
	case 26: return GW::Constants::QuestID::Doa::BroodWars;
	case 27: return GW::Constants::QuestID::Doa::FoundryOfFailedCreations;
	case 28: return GW::Constants::QuestID::Doa::FoundryBreakout;
	default: return 0;
	}
}

DWORD DialogsWindow::IndexToDialogID(int index) {
	switch (index) {
	case 0: return GW::Constants::DialogID::FowCraftArmor;
	case 1: return GW::Constants::DialogID::ProfChangeWarrior;
	case 2: return GW::Constants::DialogID::ProfChangeRanger;
	case 3: return GW::Constants::DialogID::ProfChangeMonk;
	case 4: return GW::Constants::DialogID::ProfChangeNecro;
	case 5: return GW::Constants::DialogID::ProfChangeMesmer;
	case 6: return GW::Constants::DialogID::ProfChangeEle;
	case 7: return GW::Constants::DialogID::ProfChangeAssassin;
	case 8: return GW::Constants::DialogID::ProfChangeRitualist;
	case 9: return GW::Constants::DialogID::ProfChangeParagon;
	case 10: return GW::Constants::DialogID::ProfChangeDervish;
	case 11: return GW::Constants::DialogID::FerryKamadanToDocks;
	case 12: return GW::Constants::DialogID::FerryDocksToKaineng;
	case 13: return GW::Constants::DialogID::FerryDocksToLA;
	case 14: return GW::Constants::DialogID::FerryGateToLA;
	case 15: return GW::Constants::DialogID::FactionMissionOutpost;
	case 16: return GW::Constants::DialogID::NightfallMissionOutpost;
	default: return 0;
	}
}
