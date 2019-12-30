#include "stdafx.h"
#include "TravelWindow.h"

#include <GWCA\Constants\Constants.h>
#include <GWCA\GameEntities\Map.h>
#include <GWCA\Managers\UIMgr.h>
#include <GWCA\Managers\MapMgr.h>

#include "GWToolbox.h"
#include "GuiUtils.h"
#include <Modules\Resources.h>

#define N_OUTPOSTS 180
#define N_DISTRICTS 14

namespace {
	bool outpost_name_array_getter(void* data, int idx, const char** out_text);

	bool ImInPresearing() { return GW::Map::GetCurrentMapInfo()->region == GW::Region_Presearing; }
}

void TravelWindow::Initialize() {
	ToolboxWindow::Initialize();
	Resources::Instance().LoadTextureAsync(&button_texture, Resources::GetPath(L"img/icons", L"airplane.png"), IDB_Icon_Airplane);

	district = GW::Constants::District::Current;
	district_number = 0;
}

void TravelWindow::TravelButton(const char* text, int x_idx, GW::Constants::MapID mapid) {
	if (x_idx != 0) ImGui::SameLine(0, ImGui::GetStyle().ItemInnerSpacing.x);
	float w = (ImGui::GetWindowContentRegionWidth() - ImGui::GetStyle().ItemInnerSpacing.x) / 2;
	if (ImGui::Button(text, ImVec2(w, 0))) {
		TravelWindow::Travel(mapid, district, district_number);
		if (close_on_travel) visible = false;
	}
}

void TravelWindow::Draw(IDirect3DDevice9* pDevice) {
	if (!visible) return;

	if (ImInPresearing()) {
		ImGui::SetNextWindowPosCenter(ImGuiSetCond_FirstUseEver);
		ImGui::SetNextWindowSize(ImVec2(300, 0), ImGuiSetCond_FirstUseEver);
		if (ImGui::Begin(Name(), GetVisiblePtr(), GetWinFlags())) {
			TravelButton("阿斯卡隆城", 0, GW::Constants::MapID::Ascalon_City_pre_searing);
			TravelButton("灰色浅滩修道院", 1, GW::Constants::MapID::Ashford_Abbey_outpost);
			TravelButton("佛伊伯市集", 0, GW::Constants::MapID::Foibles_Fair_outpost);
			TravelButton("瑞尼克要塞", 1, GW::Constants::MapID::Fort_Ranik_pre_Searing_outpost);
			TravelButton("巴拉丁庄园", 0, GW::Constants::MapID::The_Barradin_Estate_outpost);
		}
		ImGui::End();
	} else {
		ImGui::SetNextWindowPosCenter(ImGuiSetCond_FirstUseEver);
		ImGui::SetNextWindowSize(ImVec2(300, 0), ImGuiSetCond_FirstUseEver);
		if (ImGui::Begin(Name(), GetVisiblePtr(), GetWinFlags())) {
			ImGui::PushItemWidth(-1.0f);
			static int travelto_index = -1;
			if (ImGui::MyCombo("travelto", "前往...", &travelto_index, outpost_name_array_getter, nullptr, N_OUTPOSTS)) {
				GW::Constants::MapID id = IndexToOutpostID(travelto_index);
				TravelWindow::Travel(id, district, district_number);
				travelto_index = -1;
				if (close_on_travel) visible = false;
			}

			static int district_index = 0;
			static const char* const district_words[] = { "现有区域",
				"国际区",
				"北美洲",
				"北美一区",
				"欧洲 英语",
				"欧洲 法语",
				"欧洲 德语",
				"欧洲 意大利语",
				"欧洲 西班牙语",
				"欧洲 波兰语",
				"欧洲 俄罗斯语",
				"亚洲 朝文",
				"亚洲 中文",
				"亚洲 日文", };
			if (ImGui::Combo("###district", &district_index, district_words, N_DISTRICTS)) {
				district_number = 0;
				switch (district_index) {
					case 0: district = GW::Constants::District::Current; break;
					case 1: district = GW::Constants::District::International; break;
					case 2: district = GW::Constants::District::American; break;
					case 3: // American District 1
						district = GW::Constants::District::American;
						district_number = 1;
						break;
					case 4: district = GW::Constants::District::EuropeEnglish; break;
					case 5: district = GW::Constants::District::EuropeFrench; break;
					case 6: district = GW::Constants::District::EuropeGerman; break;
					case 7: district = GW::Constants::District::EuropeItalian; break;
					case 8: district = GW::Constants::District::EuropeSpanish; break;
					case 9: district = GW::Constants::District::EuropePolish; break;
					case 10: district = GW::Constants::District::EuropeRussian; break;
					case 11: district = GW::Constants::District::AsiaKorean; break;
					case 12: district = GW::Constants::District::AsiaChinese; break;
					case 13: district = GW::Constants::District::AsiaJapanese; break;
					default:
						break;
				}
			}
			ImGui::PopItemWidth();

			TravelButton("ToA", 0, GW::Constants::MapID::Temple_of_the_Ages);
			TravelButton("DoA", 1, GW::Constants::MapID::Domain_of_Anguish);
			TravelButton("卡玛丹", 0, GW::Constants::MapID::Kamadan_Jewel_of_Istan_outpost);
			TravelButton("Embark", 1, GW::Constants::MapID::Embark_Beach);
			TravelButton("Vlox's", 0, GW::Constants::MapID::Vloxs_Falls);
			TravelButton("Gadd's", 1, GW::Constants::MapID::Gadds_Encampment_outpost);
			// TravelButton("尔果", 0, GW::Constants::MapID::Urgozs_Warren);
			// TravelButton("深处", 1, GW::Constants::MapID::The_Deep);

			for (int i = 0; i < fav_count; ++i) {
				ImGui::PushID(i);
				ImGui::PushItemWidth(-40.0f - ImGui::GetStyle().ItemInnerSpacing.x);
				ImGui::MyCombo("", "Select a favorite", &fav_index[i], outpost_name_array_getter, nullptr, N_OUTPOSTS);
				ImGui::PopItemWidth();
				ImGui::SameLine(0, ImGui::GetStyle().ItemInnerSpacing.x);
				if (ImGui::Button("Go", ImVec2(40.0f, 0))) {
					TravelFavorite(i);
				}
				ImGui::PopID();
			}
		}
		ImGui::End();
	}
}

bool TravelWindow::TravelFavorite(unsigned int idx) {
	if (idx >= 0 && idx < fav_index.size()) {
		TravelWindow::Travel(IndexToOutpostID(fav_index[idx]), district, district_number);
		if (close_on_travel) visible = false;
		return true;
	} else {
		return false;
	}
}

void TravelWindow::DrawSettingInternal() {
	ImGui::Checkbox("Close on travel", &close_on_travel);
	ImGui::ShowHelp("Will close the travel window when clicking on a travel destination");
	ImGui::PushItemWidth(100.0f);
	if (ImGui::InputInt("Number of favorites", &fav_count)) {
		if (fav_count < 0) fav_count = 0;
		if (fav_count > 100) fav_count = 100;
		fav_index.resize(fav_count, -1);
	}
	ImGui::PopItemWidth();
}

void TravelWindow::LoadSettings(CSimpleIni* ini) {
	ToolboxWindow::LoadSettings(ini);
	show_menubutton = ini->GetBoolValue(Name(), VAR_NAME(show_menubutton), true);

	fav_count = ini->GetLongValue(Name(), VAR_NAME(fav_count), 3);
	fav_index.resize(fav_count, -1);
	for (int i = 0; i < fav_count; ++i) {
		char key[32];
		snprintf(key, 32, "Fav%d", i);
		fav_index[i] = ini->GetLongValue(Name(), key, -1);
	}
	close_on_travel = ini->GetBoolValue(Name(), VAR_NAME(close_on_travel), false);
}

void TravelWindow::SaveSettings(CSimpleIni* ini) {
	ToolboxWindow::SaveSettings(ini);
	ini->SetLongValue(Name(), VAR_NAME(fav_count), fav_count);
	for (int i = 0; i < fav_count; ++i) {
		char key[32];
		snprintf(key, 32, "Fav%d", i);
		ini->SetLongValue(Name(), key, fav_index[i]);
	}
	ini->SetBoolValue(Name(), VAR_NAME(close_on_travel), close_on_travel);
}

GW::Constants::MapID TravelWindow::IndexToOutpostID(int index) {
	using namespace GW::Constants;
	switch (index) {
	case 0: return MapID::Abaddons_Gate;
	case 1: return MapID::Abaddons_Mouth;
	case 2: return MapID::Altrumm_Ruins;
	case 3: return MapID::Amatz_Basin;
	case 4: return MapID::The_Amnoon_Oasis_outpost;
	case 5: return MapID::Arborstone_outpost_mission;
	case 6: return MapID::Ascalon_City_outpost;
	case 7: return MapID::Aspenwood_Gate_Kurzick_outpost;
	case 8: return MapID::Aspenwood_Gate_Luxon_outpost;
	case 9: return MapID::The_Astralarium_outpost;
	case 10: return MapID::Augury_Rock_outpost;
	case 11: return MapID::The_Aurios_Mines;
	case 12: return MapID::Aurora_Glade;
	case 13: return MapID::Bai_Paasu_Reach_outpost;
	case 14: return MapID::Basalt_Grotto_outpost;
	case 15: return MapID::Beacons_Perch_outpost;
	case 16: return MapID::Beetletun_outpost;
	case 17: return MapID::Beknur_Harbor;
	case 18: return MapID::Bergen_Hot_Springs_outpost;
	case 19: return MapID::Blacktide_Den;
	case 20: return MapID::Bloodstone_Fen;
	case 21: return MapID::Bone_Palace_outpost;
	case 22: return MapID::Boreal_Station_outpost;
	case 23: return MapID::Boreas_Seabed_outpost_mission;
	case 24: return MapID::Borlis_Pass;
	case 25: return MapID::Brauer_Academy_outpost;
	case 26: return MapID::Breaker_Hollow_outpost;
	case 27: return MapID::Camp_Hojanu_outpost;
	case 28: return MapID::Camp_Rankor_outpost;
	case 29: return MapID::Cavalon_outpost;
	case 30: return MapID::Central_Transfer_Chamber_outpost;
	case 31: return MapID::Chahbek_Village;
	case 32: return MapID::Champions_Dawn_outpost;
	case 33: return MapID::Chantry_of_Secrets_outpost;
	case 34: return MapID::Codex_Arena_outpost;
	case 35: return MapID::Consulate_Docks;
	case 36: return MapID::Copperhammer_Mines_outpost;
	case 37: return MapID::DAlessio_Seaboard;
	case 38: return MapID::Dajkah_Inlet;
	case 39: return MapID::Dasha_Vestibule;
	case 40: return MapID::The_Deep;
	case 41: return MapID::Deldrimor_War_Camp_outpost;
	case 42: return MapID::Destinys_Gorge_outpost;
	case 43: return MapID::Divinity_Coast;
	case 44: return MapID::Doomlore_Shrine_outpost;
	case 45: return MapID::The_Dragons_Lair;
	case 46: return MapID::Dragons_Throat;
	case 47: return MapID::Droknars_Forge_outpost;
	case 48: return MapID::Druids_Overlook_outpost;
	case 49: return MapID::Dunes_of_Despair;
	case 50: return MapID::Durheim_Archives_outpost;
	case 51: return MapID::Dzagonur_Bastion;
	case 52: return MapID::Elona_Reach;
	case 53: return MapID::Embark_Beach;
	case 54: return MapID::Ember_Light_Camp_outpost;
	case 55: return MapID::Eredon_Terrace_outpost;
	case 56: return MapID::The_Eternal_Grove_outpost_mission;
	case 57: return MapID::Eye_of_the_North_outpost;
	case 58: return MapID::Fishermens_Haven_outpost;
	case 59: return MapID::Fort_Aspenwood_Kurzick_outpost;
	case 60: return MapID::Fort_Aspenwood_Luxon_outpost;
	case 61: return MapID::Fort_Ranik;
	case 62: return MapID::Frontier_Gate_outpost;
	case 63: return MapID::The_Frost_Gate;
	case 64: return MapID::Gadds_Encampment_outpost;
	case 65: return MapID::Domain_of_Anguish;
	case 66: return MapID::Gate_of_Desolation;
	case 67: return MapID::Gate_of_Fear_outpost;
	case 68: return MapID::Gate_of_Madness;
	case 69: return MapID::Gate_of_Pain;
	case 70: return MapID::Gate_of_Secrets_outpost;
	case 71: return MapID::Gate_of_the_Nightfallen_Lands_outpost;
	case 72: return MapID::Gate_of_Torment_outpost;
	case 73: return MapID::Gates_of_Kryta;
	case 74: return MapID::Grand_Court_of_Sebelkeh;
	case 75: return MapID::The_Granite_Citadel_outpost;
	case 76: return MapID::The_Great_Northern_Wall;
	case 77: return MapID::Great_Temple_of_Balthazar_outpost;
	case 78: return MapID::Grendich_Courthouse_outpost;
	case 79: return MapID::Gunnars_Hold_outpost;
	case 80: return MapID::Gyala_Hatchery_outpost_mission;
	case 81: return MapID::Harvest_Temple_outpost;
	case 82: return MapID::Hells_Precipice;
	case 83: return MapID::Henge_of_Denravi_outpost;
	case 84: return MapID::Heroes_Ascent_outpost;
	case 85: return MapID::Heroes_Audience_outpost;
	case 86: return MapID::Honur_Hill_outpost;
	case 87: return MapID::House_zu_Heltzer_outpost;
	case 88: return MapID::Ice_Caves_of_Sorrow;
	case 89: return MapID::Ice_Tooth_Cave_outpost;
	case 90: return MapID::Imperial_Sanctum_outpost_mission;
	case 91: return MapID::Iron_Mines_of_Moladune;
	case 92: return MapID::Jade_Flats_Kurzick_outpost;
	case 93: return MapID::Jade_Flats_Luxon_outpost;
	case 94: return MapID::The_Jade_Quarry_Kurzick_outpost;
	case 95: return MapID::The_Jade_Quarry_Luxon_outpost;
	case 96: return MapID::Jennurs_Horde;
	case 97: return MapID::Jokanur_Diggings;
	case 98: return MapID::Kaineng_Center_outpost;
	case 99: return MapID::Kamadan_Jewel_of_Istan_outpost;
	case 100: return MapID::The_Kodash_Bazaar_outpost;
	case 101: return MapID::Kodlonu_Hamlet_outpost;
	case 102: return MapID::Kodonur_Crossroads;
	case 103: return MapID::Lair_of_the_Forgotten_outpost;
	case 104: return MapID::Leviathan_Pits_outpost;
	case 105: return MapID::Lions_Arch_outpost;
	case 106: return MapID::Longeyes_Ledge_outpost;
	case 107: return MapID::Lutgardis_Conservatory_outpost;
	case 108: return MapID::Maatu_Keep_outpost;
	case 109: return MapID::Maguuma_Stade_outpost;
	case 110: return MapID::Marhans_Grotto_outpost;
	case 111: return MapID::The_Marketplace_outpost;
	case 112: return MapID::Mihanu_Township_outpost;
	case 113: return MapID::Minister_Chos_Estate_outpost_mission;
	case 114: return MapID::Moddok_Crevice;
	case 115: return MapID::The_Mouth_of_Torment_outpost;
	case 116: return MapID::Nahpui_Quarter_outpost_mission;
	case 117: return MapID::Nolani_Academy;
	case 118: return MapID::Nundu_Bay;
	case 119: return MapID::Olafstead_outpost;
	case 120: return MapID::Piken_Square_outpost;
	case 121: return MapID::Pogahn_Passage;
	case 122: return MapID::Port_Sledge_outpost;
	case 123: return MapID::Quarrel_Falls_outpost;
	case 124: return MapID::Raisu_Palace_outpost_mission;
	case 125: return MapID::Ran_Musu_Gardens_outpost;
	case 126: return MapID::Random_Arenas_outpost;
	case 127: return MapID::Rata_Sum_outpost;
	case 128: return MapID::Remains_of_Sahlahja;
	case 129: return MapID::Rilohn_Refuge;
	case 130: return MapID::Ring_of_Fire;
	case 131: return MapID::Riverside_Province;
	case 132: return MapID::Ruins_of_Morah;
	case 133: return MapID::Ruins_of_Surmia;
	case 134: return MapID::Saint_Anjekas_Shrine_outpost;
	case 135: return MapID::Sanctum_Cay;
	case 136: return MapID::Sardelac_Sanitarium_outpost;
	case 137: return MapID::Seafarers_Rest_outpost;
	case 138: return MapID::Seekers_Passage_outpost;
	case 139: return MapID::Seitung_Harbor_outpost;
	case 140: return MapID::Senjis_Corner_outpost;
	case 141: return MapID::Serenity_Temple_outpost;
	case 142: return MapID::The_Shadow_Nexus;
	case 143: return MapID::Shing_Jea_Arena;
	case 144: return MapID::Shing_Jea_Monastery_outpost;
	case 145: return MapID::Sifhalla_outpost;
	case 146: return MapID::Sunjiang_District_outpost_mission;
	case 147: return MapID::Sunspear_Arena;
	case 148: return MapID::Sunspear_Great_Hall_outpost;
	case 149: return MapID::Sunspear_Sanctuary_outpost;
	case 150: return MapID::Tahnnakai_Temple_outpost_mission;
	case 151: return MapID::Tanglewood_Copse_outpost;
	case 152: return MapID::Tarnished_Haven_outpost;
	case 153: return MapID::Temple_of_the_Ages;
	case 154: return MapID::Thirsty_River;
	case 155: return MapID::Thunderhead_Keep;
	case 156: return MapID::Tihark_Orchard;
	case 157: return MapID::Tomb_of_the_Primeval_Kings;
	case 158: return MapID::Tsumei_Village_outpost;
	case 159: return MapID::Umbral_Grotto_outpost;
	case 160: return MapID::Unwaking_Waters_Kurzick_outpost;
	case 161: return MapID::Unwaking_Waters_Luxon_outpost;
	case 162: return MapID::Urgozs_Warren;
	case 163: return MapID::Vasburg_Armory_outpost;
	case 164: return MapID::Venta_Cemetery;
	case 165: return MapID::Ventaris_Refuge_outpost;
	case 166: return MapID::Vizunah_Square_Foreign_Quarter_outpost;
	case 167: return MapID::Vizunah_Square_Local_Quarter_outpost;
	case 168: return MapID::Vloxs_Falls;
	case 169: return MapID::Wehhan_Terraces_outpost;
	case 170: return MapID::The_Wilds;
	case 171: return MapID::Yahnur_Market_outpost;
	case 172: return MapID::Yaks_Bend_outpost;
	case 173: return MapID::Yohlon_Haven_outpost;
	case 174: return MapID::Zaishen_Challenge_outpost;
	case 175: return MapID::Zaishen_Elite_outpost;
	case 176: return MapID::Zaishen_Menagerie_outpost;
	case 177: return MapID::Zen_Daijun_outpost_mission;
	case 178: return MapID::Zin_Ku_Corridor_outpost;
	case 179: return MapID::Zos_Shivros_Channel;
	default: return MapID::Great_Temple_of_Balthazar_outpost;
	}
}

void TravelWindow::Travel(GW::Constants::MapID map_id,
	GW::Constants::District district, int district_number)
{
	struct UITravelPacket {
		uint32_t map_id;
		uint32_t region_id;
		uint32_t language_id;
		uint32_t district;
	};

	UITravelPacket packet;
	packet.map_id = static_cast<uint32_t>(map_id);
	packet.district = district_number;

	switch (district) {
	case GW::Constants::District::Current:
        packet.region_id = GW::Map::GetRegion();
        packet.language_id = GW::Map::GetLanguage();
        break;
    case GW::Constants::District::International:
        packet.region_id = GW::Constants::Region::International;
        packet.language_id = 0;
        break;
    case GW::Constants::District::American:
        packet.region_id = GW::Constants::Region::America;
        packet.language_id = 0;
        break;
    case GW::Constants::District::EuropeEnglish:
        packet.region_id = GW::Constants::Region::Europe;
        packet.language_id = GW::Constants::EuropeLanguage::English;
        break;
    case GW::Constants::District::EuropeFrench:
        packet.region_id = GW::Constants::Region::Europe;
        packet.language_id = GW::Constants::EuropeLanguage::French;
        break;
    case GW::Constants::District::EuropeGerman:
        packet.region_id = GW::Constants::Region::Europe;
        packet.language_id = GW::Constants::EuropeLanguage::German;
        break;
    case GW::Constants::District::EuropeItalian:
        packet.region_id = GW::Constants::Region::Europe;
        packet.language_id = GW::Constants::EuropeLanguage::Italian;
        break;
    case GW::Constants::District::EuropeSpanish:
        packet.region_id = GW::Constants::Region::Europe;
        packet.language_id = GW::Constants::EuropeLanguage::Spanish;
        break;
    case GW::Constants::District::EuropePolish:
        packet.region_id = GW::Constants::Region::Europe;
        packet.language_id = GW::Constants::EuropeLanguage::Polish;
        break;
    case GW::Constants::District::EuropeRussian:
        packet.region_id = GW::Constants::Region::Europe;
        packet.language_id = GW::Constants::EuropeLanguage::Russian;
        break;
    case GW::Constants::District::AsiaKorean:
        packet.region_id = GW::Constants::Region::Korea;
        packet.language_id = 0;
        break;
    case GW::Constants::District::AsiaChinese:
        packet.region_id = GW::Constants::Region::China;
        packet.language_id = 0;
        break;
    case GW::Constants::District::AsiaJapanese:
        packet.region_id = GW::Constants::Region::Japan;
        packet.language_id = 0;
        break;
    }

    GW::UI::SendUIMessage(GW::UI::kTravel, &packet);
}

namespace {
	bool outpost_name_array_getter(void* data, int idx, const char** out_text) {
		switch (idx) {
		case 0: *out_text = "亚霸顿之门";				break;
		case 1: *out_text = "地狱隘口";				break;
		case 2: *out_text = "奥楚兰废墟";				break;
		case 3: *out_text = "亚马兹盆地";					break;
		case 4: *out_text = "安奴绿洲";			break;
		case 5: *out_text = "亭石";					break;
		case 6: *out_text = "阿斯卡隆城";					break;
		case 7: *out_text = "杨木大门 (库兹柯)";		break;
		case 8: *out_text = "杨木大门 (勒克森)";		break;
		case 9: *out_text = "亚斯特拉利姆";				break;
		case 10: *out_text = "占卜之石";					break;
		case 11: *out_text = "奥里欧斯矿坑";			break;
		case 12: *out_text = "欧若拉林地";				break;
		case 13: *out_text = "拜巴苏区域";				break;
		case 14: *out_text = "玄武岩石穴";				break;
		case 15: *out_text = "毕肯高地";				break;
		case 16: *out_text = "甲虫镇";					break;
		case 17: *out_text = "别克诺港";				break;
		case 18: *out_text = "卑尔根温泉";			break;
		case 19: *out_text = "黑潮之穴";				break;
		case 20: *out_text = "血石沼泽";				break;
		case 21: *out_text = "白骨宫殿";					break;
		case 22: *out_text = "北极驻地";				break;
		case 23: *out_text = "风神海床";				break;
		case 24: *out_text = "柏里斯通道";					break;
		case 25: *out_text = "巴尔学院";				break;
		case 26: *out_text = "断崖谷";				break;
		case 27: *out_text = "何加努营地";					break;
		case 28: *out_text = "蓝口营地";					break;
		case 29: *out_text = "卡瓦隆";						break;
		case 30: *out_text = "中央转送室";	break;
		case 31: *out_text = "夏贝克村庄";				break;
		case 32: *out_text = "勇士曙光";				break;
		case 33: *out_text = "隐秘教堂";			break;
		case 34: *out_text = "Codex 竞技场";					break;
		case 35: *out_text = "领事馆码头";				break;
		case 36: *out_text = "铜锤矿坑";			break;
		case 37: *out_text = "达雷西海滨";			break;
		case 38: *out_text = "达卡港";				break;
		case 39: *out_text = "达沙走廊";				break;
		case 40: *out_text = "深处";					break;
		case 41: *out_text = "戴尔狄摩兵营";			break;
		case 42: *out_text = "命运峡谷";				break;
		case 43: *out_text = "神圣海岸";				break;
		case 44: *out_text = "末日传说神殿";				break;
		case 45: *out_text = "龙穴";			break;
		case 46: *out_text = "龙喉";				break;
		case 47: *out_text = "卓克纳熔炉";				break;
		case 48: *out_text = "德鲁伊高地";			break;
		case 49: *out_text = "绝望沙丘";			break;
		case 50: *out_text = "杜汉姆卷藏室";			break;
		case 51: *out_text = "萨岗诺棱堡";			break;
		case 52: *out_text = "伊洛那流域";					break;
		case 53: *out_text = "Embark Beach";				break;
		case 54: *out_text = "残火营地";			break;
		case 55: *out_text = "尔雷登平地";				break;
		case 56: *out_text = "永恒之林";			break;
		case 57: *out_text = "极地之眼";			break;
		case 58: *out_text = "渔人避风港";			break;
		case 59: *out_text = "杨木要塞 (库兹柯)";		break;
		case 60: *out_text = "杨木要塞 (勒克森)";		break;
		case 61: *out_text = "瑞尼克要塞";					break;
		case 62: *out_text = "边境关所";				break;
		case 63: *out_text = "寒霜之门";				break;
		case 64: *out_text = "盖德营地";			break;
		case 65: *out_text = "悲难之门";				break;
		case 66: *out_text = "荒芜之地入口";			break;
		case 67: *out_text = "恐惧之门";				break;
		case 68: *out_text = "疯狂之门";				break;
		case 69: *out_text = "惩罚之门";				break;
		case 70: *out_text = "奥秘之门";				break;
		case 71: *out_text = "夜蚀暗殒领地之门"; break;
		case 72: *out_text = "苦痛之门";				break;
		case 73: *out_text = "科瑞塔关所";				break;
		case 74: *out_text = "希贝克大公廷";		break;
		case 75: *out_text = "花岗岩堡垒";		break;
		case 76: *out_text = "北方长城";	break;
		case 77: *out_text = "巴萨泽圣殿";	break;
		case 78: *out_text = "葛兰迪法院";			break;
		case 79: *out_text = "甘拿的占领地";				break;
		case 80: *out_text = "盖拉孵化所";				break;
		case 81: *out_text = "丰收神殿";				break;
		case 82: *out_text = "地狱悬崖";			break;
		case 83: *out_text = "丹拉维圣地";			break;
		case 84: *out_text = "英雄之路";				break;
		case 85: *out_text = "英雄之痕";			break;
		case 86: *out_text = "霍奴尔丘陵";					break;
		case 87: *out_text = "凤荷议院";			break;
		case 88: *out_text = "悲伤冰谷";			break;
		case 89: *out_text = "冰牙洞穴";				break;
		case 90: *out_text = "帝国圣所";			break;
		case 91: *out_text = "莫拉登矿山";		break;
		case 92: *out_text = "翡翠浅滩 (库兹柯)";			break;
		case 93: *out_text = "翡翠浅滩 (勒克森)";			break;
		case 94: *out_text = "翡翠矿场 (库兹柯)";	break;
		case 95: *out_text = "翡翠矿场 (勒克森)";		break;
		case 96: *out_text = "征钠群落";				break;
		case 97: *out_text = "卓坎诺挖掘点";			break;
		case 98: *out_text = "凯宁中心";				break;
		case 99: *out_text = "卡玛丹，艾斯坦之钻";		break;
		case 100: *out_text = "库丹西市集广场";			break;
		case 101: *out_text = "克拓奴，哈姆雷特";				break;
		case 102: *out_text = "科登诺路口";			break;
		case 103: *out_text = "被遗忘者的巢穴";		break;
		case 104: *out_text = "利拜亚森矿场";				break;
		case 105: *out_text = "狮子拱门";				break;
		case 106: *out_text = "长眼岩脉";			break;
		case 107: *out_text = "路嘉帝斯温室";		break;
		case 108: *out_text = "麻都堡垒";					break;
		case 109: *out_text = "梅古玛丛林";				break;
		case 110: *out_text = "马翰洞穴";			break;
		case 111: *out_text = "市集";			break;
		case 112: *out_text = "米哈努小镇";			break;
		case 113: *out_text = "周大臣庄园";		break;
		case 114: *out_text = "摩多克裂缝";				break;
		case 115: *out_text = "苦痛之地隘口";		break;
		case 116: *out_text = "纳普区";				break;
		case 117: *out_text = "若拉尼学院";				break;
		case 118: *out_text = "纳度湾";					break;
		case 119: *out_text = "欧拉夫之地";					break;
		case 120: *out_text = "派肯广场";				break;
		case 121: *out_text = "波甘驿站";				break;
		case 122: *out_text = "雪橇港";				break;
		case 123: *out_text = "怨言瀑布";				break;
		case 124: *out_text = "莱苏皇宫";				break;
		case 125: *out_text = "岚穆苏花园";			break;
		case 126: *out_text = "随机竞技场";				break;
		case 127: *out_text = "洛达顶点";					break;
		case 128: *out_text = "萨拉迦遗址";		break;
		case 129: *out_text = "里欧恩难民营";				break;
		case 130: *out_text = "火环群岛";				break;
		case 131: *out_text = "河畔地带";			break;
		case 132: *out_text = "摩拉废墟";				break;
		case 133: *out_text = "苏米亚废墟";			break;
		case 134: *out_text = "圣者安捷卡的祭坛";		break;
		case 135: *out_text = "神圣沙滩";				break;
		case 136: *out_text = "萨德拉克疗养院";		break;
		case 137: *out_text = "航海者休憩处";			break;
		case 138: *out_text = "探索者通道";			break;
		case 139: *out_text = "青函港";				break;
		case 140: *out_text = "山吉之街";				break;
		case 141: *out_text = "宁静神殿";			break;
		case 142: *out_text = "阴郁核心";			break;
		case 143: *out_text = "星岬竞技场";			break;
		case 144: *out_text = "星岬寺";		break;
		case 145: *out_text = "袭哈拉";					break;
		case 146: *out_text = "孙江行政区";			break;
		case 147: *out_text = "日戟竞技场";				break;
		case 148: *out_text = "日戟大会堂";		break;
		case 149: *out_text = "日戟避难所";			break;
		case 150: *out_text = "谭纳凯神殿";			break;
		case 151: *out_text = "谭格梧树林";			break;
		case 152: *out_text = "灰暗避难所";			break;
		case 153: *out_text = "世纪神殿";			break;
		case 154: *out_text = "干枯河流";				break;
		case 155: *out_text = "雷云要塞";			break;
		case 156: *out_text = "提亚克林地";				break;
		case 157: *out_text = "先王之墓";	break;
		case 158: *out_text = "苏梅村";				break;
		case 159: *out_text = "阴影石穴";				break;
		case 160: *out_text = "沉睡之水 (库兹柯)";	break;
		case 161: *out_text = "沉睡之水 (勒克森)";		break;
		case 162: *out_text = "尔果的养殖场";				break;
		case 163: *out_text = "维思伯兵营";				break;
		case 164: *out_text = "凡特墓地";				break;
		case 165: *out_text = "凡特里庇护所";			break;
		case 166: *out_text = "薇茹广场 (外地)";	break;
		case 167: *out_text = "薇茹广场 (本地)";		break;
		case 168: *out_text = "弗洛克斯瀑布";				break;
		case 169: *out_text = "薇恩平台";			break;
		case 170: *out_text = "荒原";					break;
		case 171: *out_text = "雅诺尔市集";				break;
		case 172: *out_text = "牦牛村";					break;
		case 173: *out_text = "犹朗避难所";				break;
		case 174: *out_text = "战承挑战赛";			break;
		case 175: *out_text = "战承精英";				break;
		case 176: *out_text = "战承动物园";			break;
		case 177: *out_text = "祯台郡";					break;
		case 178: *out_text = "辛库走廊";			break;
		case 179: *out_text = "佐席洛斯水道";		break;
		default: *out_text = "";
		}
		return true;
	}
}
