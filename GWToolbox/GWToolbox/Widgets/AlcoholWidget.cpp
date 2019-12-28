#include "stdafx.h"
#include "AlcoholWidget.h"

#include <GWCA/Constants/Constants.h>

#include <GWCA/GameContainers/Array.h>
#include <GWCA/GameContainers/GamePos.h>

#include <GWCA/Managers/MapMgr.h>
#include <GWCA/Managers/StoCMgr.h>

#include <GuiUtils.h>


void AlcoholWidget::Initialize() {
	ToolboxWidget::Initialize();
	// how much time was queued up with drinks
	alcohol_time = 0;
	// last time the player used a drink
	last_alcohol = 0;
	alcohol_level = 0;
	
	GW::StoC::RegisterPacketCallback<GW::Packet::StoC::PostProcess>(&PostProcess_Entry,
	[this] (GW::HookStatus *status, GW::Packet::StoC::PostProcess *packet) -> void {
		return AlcUpdate(status, packet);
	});
}

void AlcoholWidget::AlcUpdate(GW::HookStatus *, GW::Packet::StoC::PostProcess *packet) {
	// if the player used a drink
	if (packet->level > alcohol_level){
		// if the player already had a drink going
		if (alcohol_level) {
			// set remaining time
			alcohol_time = (int)((long)alcohol_time + (long)last_alcohol - (long)time(NULL));
		}
		// add drink time
		alcohol_time += 60 * (int)(packet->level - alcohol_level);
		last_alcohol = time(NULL);
	} else if (packet->level <= alcohol_level) {
		alcohol_time = 60 * (int)packet->level;
		last_alcohol = time(NULL);
	}
	alcohol_level = packet->level;
}

void AlcoholWidget::Draw(IDirect3DDevice9* pDevice) {
	if (!visible) return;

	if (GW::Map::GetInstanceType() != GW::Constants::InstanceType::Explorable) return;

	ImGui::PushStyleColor(ImGuiCol_WindowBg, ImVec4(0, 0, 0, 0));
	ImGui::SetNextWindowSize(ImVec2(200.0f, 90.0f), ImGuiSetCond_FirstUseEver);
	if (ImGui::Begin(Name(), nullptr, GetWinFlags(0, true))) {
		static char timer[32];
		ImVec2 cur;
		long t = 0;

		if (alcohol_level) {
			t = (long)((int)last_alcohol + ((int)alcohol_time)) - (long)time(NULL);
		}
		snprintf(timer, 32, "%1ld:%02ld", (t / 60) % 60, t % 60);

		ImGui::PushFont(GuiUtils::GetFont(GuiUtils::f20));
		cur = ImGui::GetCursorPos();
		ImGui::SetCursorPos(ImVec2(cur.x + 1, cur.y + 1));
		ImGui::TextColored(ImColor(0, 0, 0), "Alcohol");
		ImGui::SetCursorPos(cur);
		ImGui::Text("Alcohol");
		ImGui::PopFont();

		ImGui::PushFont(GuiUtils::GetFont(GuiUtils::f48));
		cur = ImGui::GetCursorPos();
		ImGui::SetCursorPos(ImVec2(cur.x + 2, cur.y + 2));
		ImGui::TextColored(ImColor(0, 0, 0), timer);
		ImGui::SetCursorPos(cur);
		ImGui::Text(timer);
		ImGui::PopFont();
	}
	ImGui::End();
	ImGui::PopStyleColor();
}

void AlcoholWidget::DrawSettingInternal() {
	ImGui::Text("Note: only visible in explorable areas.");
}
