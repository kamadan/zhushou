#include "stdafx.h"
#include "SettingsWindow.h"

#include "Defines.h"
#include "GuiUtils.h" 
#include "GWToolbox.h"
#include "Windows/MainWindow.h"

#include <Modules/Updater.h>
#include <Modules/Resources.h>
#include <Modules/ChatCommands.h>
#include <Modules/GameSettings.h>
#include <Modules/ToolboxTheme.h>
#include <Modules/ToolboxSettings.h>


void SettingsWindow::Initialize() {
	ToolboxWindow::Initialize();
	Resources::Instance().LoadTextureAsync(&button_texture, Resources::GetPath(L"img/icons", L"settings.png"), IDB_Icon_Settings);
}

void SettingsWindow::LoadSettings(CSimpleIni* ini) {
	ToolboxWindow::LoadSettings(ini);
	show_menubutton = ini->GetBoolValue(Name(), VAR_NAME(show_menubutton), true);
}

void SettingsWindow::Draw(IDirect3DDevice9* pDevice) {
	if (!visible) return;
	
	ImGui::SetNextWindowPosCenter(ImGuiSetCond_FirstUseEver);
	ImGui::SetNextWindowSize(ImVec2(450, 600), ImGuiSetCond_FirstUseEver);
	if (ImGui::Begin(Name(), GetVisiblePtr(), GetWinFlags())) {
		ImGui::PushTextWrapPos();
		ImGui::Text("GWToolbox++ version %s by Has and KAOS", GWTOOLBOX_VERSION);
		if (BETA_VERSION[0]) {
			ImGui::SameLine();
			ImGui::Text("- %s", BETA_VERSION);
		} else {
			const std::string server_version = Updater::Instance().GetServerVersion();
			if (!server_version.empty()) {
				if (server_version.compare(GWTOOLBOX_VERSION) == 0) {
					ImGui::SameLine();
					ImGui::Text("(Up to date)");
				} else {
					ImGui::Text("Version %s is available!", server_version.c_str());
				}
			}
		}
		float w = (ImGui::GetWindowContentRegionWidth() - ImGui::GetStyle().ItemSpacing.x) / 2;
		if (ImGui::Button("Open Settings Folder", ImVec2(w, 0))) {
			CoInitializeEx(NULL, COINIT_APARTMENTTHREADED | COINIT_DISABLE_OLE1DDE);
			ShellExecuteW(NULL, L"open", Resources::GetSettingsFolderPath().c_str(), NULL, NULL, SW_SHOWNORMAL);
		}
		ImGui::SameLine();
		if (ImGui::Button("Open GWToolbox++ Website", ImVec2(w, 0))) {
			CoInitializeEx(NULL, COINIT_APARTMENTTHREADED | COINIT_DISABLE_OLE1DDE);
			ShellExecute(NULL, "open", GWTOOLBOX_WEBSITE, NULL, NULL, SW_SHOWNORMAL);
		}

		ToolboxSettings::Instance().DrawFreezeSetting();

		ImGui::Text("General:");
		if (ImGui::CollapsingHeader("Help")) {
			if (ImGui::TreeNode("General Interface")) {
				ImGui::Bullet(); ImGui::Text("Double-click on the title bar to collapse a window.");
				ImGui::Bullet(); ImGui::Text("Click and drag on the lower right corner to resize a window.");
				ImGui::Bullet(); ImGui::Text("Click and drag on any empty space to move a window.");
				ImGui::Bullet(); ImGui::Text("Mouse Wheel to scroll.");
				if (ImGui::GetIO().FontAllowUserScaling) {
					ImGui::Bullet(); ImGui::Text("CTRL+Mouse Wheel to zoom window contents.");
				}
				ImGui::Bullet(); ImGui::Text("TAB or SHIFT+TAB to cycle through keyboard editable fields.");
				ImGui::Bullet(); ImGui::Text("CTRL+Click or Double Click on a slider or drag box to input text.");
				ImGui::Bullet(); ImGui::Text(
					"While editing text:\n"
					"- Hold SHIFT or use mouse to select text\n"
					"- CTRL+Left/Right to word jump\n"
					"- CTRL+A or double-click to select all\n"
					"- CTRL+X,CTRL+C,CTRL+V clipboard\n"
					"- CTRL+Z,CTRL+Y undo/redo\n"
					"- ESCAPE to revert\n"
					"- You can apply arithmetic operators +,*,/ on numerical values. Use +- to subtract.\n");
				ImGui::TreePop();
			}
			if (ImGui::TreeNode("Opening and closing windows")) {
				ImGui::Text("There are several ways to open and close toolbox windows and widgets:");
				ImGui::Bullet(); ImGui::Text("Buttons in the main window.");
				ImGui::Bullet(); ImGui::Text("Checkboxes in the Info window.");
				ImGui::Bullet(); ImGui::Text("Checkboxes on the right of each setting header below.");
				ImGui::Bullet(); ImGui::Text("Chat command '/hide <name>' to hide a window or widget.");
				ImGui::Bullet(); ImGui::Text("Chat command '/show <name>' to show a window or widget.");
				ImGui::Bullet(); ImGui::Text("Chat command '/tb <name>' to toggle a window or widget.");
				ImGui::Indent();
				ImGui::Text("In the commands above, <name> is the title of the window as shown in the title bar. For example, try '/hide settings' and '/show settings'.");
				ImGui::Text("Note: the names of the widgets without a visible title bar are the same as in the setting headers below.");
				ImGui::Unindent();
				ImGui::Bullet(); ImGui::Text("Send Chat hotkey to enter one of the commands above.");
				ImGui::TreePop();
			}
			if (ImGui::TreeNode("Chat Commands")) {
				ChatCommands::Instance().DrawHelp();
				ImGui::TreePop();
			}
		}

		ToolboxTheme::Instance().DrawSettings();
		ToolboxSettings::Instance().DrawSettings();
		MainWindow::Instance().DrawSettings();

		const std::vector<ToolboxModule*>& optional_modules = ToolboxSettings::Instance().GetOptionalModules();
		for (unsigned i = 0; i < optional_modules.size(); ++i) {
			if (i == sep_windows) ImGui::Text("Windows:");
			if (i == sep_widgets) ImGui::Text("Widgets:");
            optional_modules[i]->DrawSettings();
		}

		if (ImGui::Button("Save Now", ImVec2(w, 0))) {
			GWToolbox::Instance().SaveSettings();
		}
		if (ImGui::IsItemHovered()) ImGui::SetTooltip("Toolbox normally saves settings on exit.\nClick to save to disk now.");
		ImGui::SameLine();
		if (ImGui::Button("Load Now", ImVec2(w, 0))) {
			GWToolbox::Instance().OpenSettingsFile();
			GWToolbox::Instance().LoadModuleSettings();
		}
		if (ImGui::IsItemHovered()) ImGui::SetTooltip("Toolbox normally loads settings on launch.\nClick to re-load from disk now.");
		ImGui::PopTextWrapPos();
	}
	ImGui::End();
}
