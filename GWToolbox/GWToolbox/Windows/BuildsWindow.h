﻿#pragma once

#include "ToolboxWindow.h"

#include <vector>
#include <queue>
#include <string>

#include "Timer.h"
#include "GuiUtils.h"

class BuildsWindow : public ToolboxWindow {
private:
	struct Build {
		Build(const char* n, const char* c) {
			GuiUtils::StrCopy(name, n, sizeof(name));
			GuiUtils::StrCopy(code, c, sizeof(code));
		}
		char name[128];
		char code[128];
	};
	struct TeamBuild {
		static unsigned int cur_ui_id;
		TeamBuild(const char* n)
			: ui_id(++cur_ui_id) {
			GuiUtils::StrCopy(name, n, sizeof(name));
		}
		bool edit_open = false;
		bool show_numbers = false;
		char name[128];
		std::vector<Build> builds;
		unsigned int ui_id; // should be const but then assignment operator doesn't get created automatically, and I'm too lazy to redefine it, so just don't change this value, okay?
	};

	BuildsWindow() {};
	~BuildsWindow() {};
public:
	static BuildsWindow& Instance() {
		static BuildsWindow instance;
		return instance;
	}

	const char* Name() const override { return "样本"; }

	void Initialize() override;
	void Terminate() override;

	// Update. Will always be called every frame.
	void Update(float delta) override;

	// Draw user interface. Will be called every frame if the element is visible
	void Draw(IDirect3DDevice9* pDevice) override;

	void LoadSettings(CSimpleIni* ini) override;
	void SaveSettings(CSimpleIni* ini) override;

	void LoadFromFile();
	void SaveToFile();
	bool MoveOldBuilds(CSimpleIni* ini);

	void Send(unsigned int idx);
	const char* BuildName(unsigned int idx) const;
	inline unsigned int BuildCount() const { return teambuilds.size(); }
private:
	// Send a teambuild
	void Send(const TeamBuild& tbuild);
	// Send a specific build from a teambuild
	void Send(const TeamBuild& tbuild, unsigned int idx);

	bool builds_changed = false;
	std::vector<TeamBuild> teambuilds;

	clock_t send_timer = 0;
	std::queue<std::string> queue;

	CSimpleIni* inifile = nullptr;
};
