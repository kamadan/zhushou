﻿#pragma once

#include <cmath>

#include <SimpleIni.h>
#include <imgui.h>

#include <GuiUtils.h>

#ifdef RGB
#undef RGB
#endif

typedef ImU32 Color;

namespace Colors {

	static Color ARGB(int a, int r, int g, int b) {
		return (a << IM_COL32_A_SHIFT)
			| (r << IM_COL32_R_SHIFT)
			| (g << IM_COL32_G_SHIFT)
			| (b << IM_COL32_B_SHIFT);
	}

	static Color RGB(int r, int g, int b) {
		return (0xFF << IM_COL32_A_SHIFT)
			| (r << IM_COL32_R_SHIFT)
			| (g << IM_COL32_G_SHIFT)
			| (b << IM_COL32_B_SHIFT);
	}

	static Color Black() { return RGB(0, 0, 0); }
	static Color White() { return RGB(0xFF, 0xFF, 0xFF); }
	static Color Empty() { return ARGB(0, 0, 0, 0); }

	static Color Red() { return RGB(0xFF, 0x0, 0x0); }
	static Color Green() { return RGB(0x0, 0xFF, 0x0); }
	static Color Blue() { return RGB(0x0, 0x0, 0xFF); }

	static Color Load(CSimpleIni* ini, const char* section, const char* key, Color def) {
		const char* wc = ini->GetValue(section, key, nullptr);
		if (wc == nullptr) return def;
		unsigned int c;
		if (GuiUtils::ParseUInt(wc, &c, 16)) {
			// swap red and blue channels
			return c;
		} else {
			// invalid argument, out of range, whatever
			return Black();
		}
	}

	static void Save(CSimpleIni* ini, const char* section, const char* key, Color val) {
		char buf[64];
		snprintf(buf, 64, "0x%X", val);
		ini->SetValue(section, key, buf);
	}

	static void ConvertU32ToInt4(Color color, int* i) {
		i[0] = ((color >> IM_COL32_A_SHIFT) & 0xFF);
		i[1] = ((color >> IM_COL32_R_SHIFT) & 0xFF);
		i[2] = ((color >> IM_COL32_G_SHIFT) & 0xFF);
		i[3] = ((color >> IM_COL32_B_SHIFT) & 0xFF);
	}

	static Color ConvertInt4ToU32(const int* i) {
		return ((i[0] & 0xFF) << IM_COL32_A_SHIFT)
			| ((i[1] & 0xFF) << IM_COL32_R_SHIFT)
			| ((i[2] & 0xFF) << IM_COL32_G_SHIFT)
			| ((i[3] & 0xFF) << IM_COL32_B_SHIFT);
	}

    static bool DrawSettingHueWheel(const char* text, Color* color) {
        ImVec4 col = ImGui::ColorConvertU32ToFloat4(*color);
        if (ImGui::ColorEdit4(text, &col.x, ImGuiColorEditFlags_NoInputs | ImGuiColorEditFlags_NoAlpha | ImGuiColorEditFlags_NoLabel | ImGuiColorEditFlags_PickerHueWheel)) {
            *color = ImGui::ColorConvertFloat4ToU32(col);
            return true;
        }
        return false;
    }
#if 0
    static bool DrawSettingHueWheel(const char* text, GW::Chat::Color* color) {
        ImVec4 col = ImGui::ColorConvertU32ToFloat4(*color);
        if (ImGui::ColorEdit4(text, &col.x, ImGuiColorEditFlags_NoInputs | ImGuiColorEditFlags_NoAlpha | ImGuiColorEditFlags_NoLabel | ImGuiColorEditFlags_PickerHueWheel)) {
            *color = ImGui::ColorConvertFloat4ToU32(col);
            return true;
        }
        return false;
    }
#endif

	static bool DrawSetting(const char* text, Color* color, bool alpha = true) {
		int i[4];
		ConvertU32ToInt4(*color, i);

		ImGuiContext* context = ImGui::GetCurrentContext();
		const ImGuiStyle& style = ImGui::GetStyle();

		const int n_components = alpha ? 4 : 4;
		const int first_component = alpha ? 0 : 1;
		const int last_component = 4;

		bool value_changed = false;

		const float w_full = ImGui::CalcItemWidth();
		const float square_sz = ImGui::GetFontSize() + style.FramePadding.y * 2.0f;

		const float w_items_all = w_full - (square_sz + style.ItemInnerSpacing.x);
		const float w_item_one = std::round((w_items_all - style.ItemInnerSpacing.x * (n_components - 1)) / (float)n_components);
		const float w_item_last = std::round(w_items_all - (w_item_one + style.ItemInnerSpacing.x) * (n_components - 1));
		
		const char* ids[4] = { "##X", "##Y", "##Z", "##W" };
		const char* fmt[4] = { "A:%3.0f", "R:%3.0f", "G:%3.0f", "B:%3.0f" };

		ImGui::BeginGroup();
		ImGui::PushID(text);
		
		ImGui::PushItemWidth(w_item_one);
		if (alpha) {
			value_changed |= ImGui::DragInt("##A", &i[0], 1.0f, 0, 255, "A:%3.0f");
			ImGui::SameLine(0, style.ItemInnerSpacing.x);
			if (ImGui::IsItemHovered()) ImGui::SetTooltip("Alpha channel (0 - 255)\n0 is transparent, 255 is solid color");
		} else {
			if (!alpha) ImGui::SetCursorPosX(ImGui::GetCursorPosX() + w_item_one + style.ItemInnerSpacing.x);
		}

		value_changed |= ImGui::DragInt("##R", &i[1], 1.0f, 0, 255, "R:%3.0f");
		if (ImGui::IsItemHovered()) ImGui::SetTooltip("Red channel (0 - 255)");

		ImGui::SameLine(0, style.ItemInnerSpacing.x);
		value_changed |= ImGui::DragInt("##G", &i[2], 1.0f, 0, 255, "G:%3.0f");
		if (ImGui::IsItemHovered()) ImGui::SetTooltip("Green channel (0 - 255)");

		ImGui::PopItemWidth();

		ImGui::SameLine(0, style.ItemInnerSpacing.x);
		ImGui::PushItemWidth(w_item_last);
		value_changed |= ImGui::DragInt("##B", &i[3], 1.0f, 0, 255, "B:%3.0f");
		if (ImGui::IsItemHovered()) ImGui::SetTooltip("Blue channel (0 - 255)");
		ImGui::PopItemWidth();

		ImGui::SameLine(0, style.ItemInnerSpacing.x);
		ImGui::ColorButton("", ImColor(i[1], i[2], i[3]));

		if (ImGui::IsItemHovered()) ImGui::SetTooltip("Color:\n0x%02X%02X%02X%02X", i[0], i[1], i[2], i[3]);

		ImGui::SameLine(0, style.ItemInnerSpacing.x);
		ImGui::Text(text);

		ImGui::PopID();
		ImGui::EndGroup();

		if (value_changed) *color = ConvertInt4ToU32(i);

		return value_changed;
	}

	static void Clamp(int c[4]) {
		for (int i = 0; i < 4; ++i) {
			if (c[i] < 0) c[i] = 0;
			if (c[i] > 0xFF) c[i] = 0xFF;
		}
	}
	static Color Add(const Color c1, const Color c2) {
		int i1[4]; 
		int i2[4];
		int i3[4];
		ConvertU32ToInt4(c1, i1);
		ConvertU32ToInt4(c2, i2);
		for (int i = 0; i < 4; ++i) {
			i3[i] = i1[i] + i2[i];
		}
		Clamp(i3);
		return ConvertInt4ToU32(i3);
	}
	static Color Sub(const Color c1, const Color c2) {
		int i1[4]; 
		int i2[4];
		int i3[4];
		ConvertU32ToInt4(c1, i1);
		ConvertU32ToInt4(c2, i2);
		for (int i = 0; i < 4; ++i) {
			i3[i] = i1[i] - i2[i];
		}
		Clamp(i3);
		return ConvertInt4ToU32(i3);
	}

	static Color Slerp(const Color c1, const Color c2, float t) {
		int i1[4];
		int i2[4];
		int i3[4];
		ConvertU32ToInt4(c1, i1);
		ConvertU32ToInt4(c2, i2);
		for (int i = 0; i < 4; ++i) {
			i3[i] = (int)(i1[i] + (i2[i] - i1[i]) * t);
		}
		return ConvertInt4ToU32(i3);
	}
}
