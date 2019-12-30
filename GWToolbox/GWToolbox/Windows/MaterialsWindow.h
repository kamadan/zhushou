﻿#pragma once

#include <GWCA/Utilities/Hook.h>
#include <GWCA/GameEntities/Item.h>
#include <GWCA/Managers/MerchantMgr.h>

#include "ToolboxWindow.h"

class MaterialsWindow : public ToolboxWindow {
	enum Item {
		Essence,
		Grail,
		Armor,
		Powerstone,
		ResScroll,
		Any
	};
	enum Material {
		BoltofCloth, Bone, ChitinFragment,
		Feather, GraniteSlab, IronIngot,
		PileofGlitteringDust, PlantFiber,
		Scale, TannedHideSquare, WoodPlank,

		AmberChunk, BoltofDamask, BoltofLinen,
		BoltofSilk, DeldrimorSteelIngot,
		Diamond, ElonianLeatherSquare, FurSquare,
		GlobofEctoplasm, JadeiteShard, LeatherSquare,
		LumpofCharcoal, MonstrousClaw, MonstrousEye,
		MonstrousFang, ObsidianShard, OnyxGemstone,
		RollofParchment, RollofVellum, Ruby,
		Sapphire, SpiritwoodPlank, SteelIngot,
		TemperedGlassVial, VialofInk,
		
		N_MATS
	};

	MaterialsWindow() {};
	~MaterialsWindow() {};
public:
	static MaterialsWindow& Instance() {
		static MaterialsWindow instance;
		return instance;
	}

	const char* Name() const override { return "材料"; }

	void Initialize() override;
	void Terminate() override;

	void DrawSettingInternal() override;
	void LoadSettings(CSimpleIni* ini) override;
	void SaveSettings(CSimpleIni* ini) override;
	
	// Update. Will always be called every frame.
	void Update(float delta) override;

	// Draw user interface. Will be called every frame if the element is visible
	void Draw(IDirect3DDevice9* pDevice) override;

private:
	DWORD GetModelID(Material mat) const;
	Material GetMaterial(DWORD modelid);
	std::string GetPrice(Material mat1, float fac1,
		Material mat2, float fac2, int extra) const;

	void FullConsPriceTooltip() const;

	// returns item id if successful, 0 if error
	DWORD RequestPurchaseQuote(Material material);
	DWORD RequestSellQuote(Material material);

	IDirect3DTexture9* tex_essence = nullptr;
	IDirect3DTexture9* tex_grail = nullptr;
	IDirect3DTexture9* tex_armor = nullptr;
	IDirect3DTexture9* tex_powerstone = nullptr;
	IDirect3DTexture9* tex_resscroll = nullptr;

	// Negative values have special meanings:
	static const int PRICE_DEFAULT = -1;
	static const int PRICE_COMPUTING_QUEUE = -2;
	static const int PRICE_COMPUTING_SENT = -3;
	static const int PRICE_NOT_AVAILABLE = -4;
	int price[N_MATS] = {};

	// int max = 0;
	GW::MerchItemArray GetMerchItems() const;
	GW::Item *GetMerchItem(Material mat) const;
	GW::Item *GetBagItem(Material mat) const;

	struct Transaction {
		enum Type { Sell, Buy, Quote };
		Type     type;
		uint32_t item_id;
		Material material;

		Transaction(Type t, Material mat)
			: type(t)
			, item_id(0)
			, material(mat)
		{
		}
	};

	void Cancel();
	void Dequeue();
	void Enqueue(Transaction::Type type, Material mat);
	void EnqueueQuote(Material material);
	void EnqueuePurchase(Material material);
	void EnqueueSell(Material material);

	std::vector<GW::ItemID> merch_items;

	std::deque<Transaction> transactions;
	bool quote_pending = false;
	bool trans_pending = false;
	DWORD quote_pending_time = 0;
	DWORD trans_pending_time = 0;

	bool cancelled = false;
	size_t trans_queued = 0;
	size_t trans_done = 0;

	bool manage_gold = false;

	GW::HookEntry QuotedItemPrice_Entry;
	GW::HookEntry TransactionDone_Entry;
	GW::HookEntry ItemStreamEnd_Entry;
};
