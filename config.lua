print("^2Jim-Mining ^7v^4"..GetResourceMetadata(GetCurrentResourceName(), 'version', nil):gsub("%.", "^7.^4").."^7 - ^2Mining Script by ^1Jimathy^7")

Loc = {}

Config = {
	Debug = false, -- enable debug mode
	img = "qb-inventory/html/images/", --Set this to the image directory of your inventory script or "nil" if using newer qb-menu

	Lan = "en", -- Pick your language here

	JimShops = false, 		-- Set this to true if using jim-shops

	Inv = "qb",				--"qb" or "ox"
	Menu = "qb",			--"qb" or "ox"
	ProgressBar = "qb",		--"qb" or "ox"
	Notify = "qb",			--"qb" or "ox"

	DrillSound = true,		-- disable drill sounds

	MultiCraft = true,		-- Enable multicraft
	MultiCraftAmounts = { [1], [5], [10] },

	K4MB1Prop = false, -- Enable this to make use of K4MB1's ore props provided with their Mining Cave MLO

	Timings = { -- Time it takes to do things
		["Cracking"] = math.random(5000, 6000),
		["Washing"] = math.random(5000, 6000),
		["Panning"] = math.random(25000, 30000),
		["Pickaxe"] = math.random(10000, 15000),
		["Mining"] = math.random(10000, 13000),
		["Laser"] = math.random(10000, 11000),
		["OreRespawn"] = math.random(30000, 50000),
		["Crafting"] = 1000,
	},

	CrackPool = { -- Rewards from cracking stone
		"copperore",
		"copperore",
		"ironore",
		"ironore",
		"goldore",
		"silverore",
		"silverore",
	},

	WashPool = {	-- Rewards from washing stone
		"uncut_ruby",
		"uncut_emerald",
		"uncut_diamond",
		"uncut_sapphire",
	},

	PanPool = {		-- Rewards from panning
		"can",
		"can",
		"can",
		"can",
		"bottle",
		"bottle",
		"bottle",
		"bottle",
		"goldore",
		"silverore",
	},

------------------------------------------------------------
	OreSell = { -- List of ores you can sell to the buyer npc
		"goldingot",
		"silveringot",
		"copperore",
		"ironore",
		"goldore",
		"silverore",
		"carbon",
	},

	SellingPrices = { -- Selling Prices
		['copperore'] = 10,
		['goldore'] = 1000,
		['silverore'] = 300,
		['ironore'] = 10,
		['carbon'] = 100,

		['goldingot'] = 15000,
		['silveringot'] = 5000,

		['uncut_emerald'] = 10,
		['uncut_ruby'] = 10,
		['uncut_diamond'] = 10,
		['uncut_sapphire'] = 10,

		['emerald'] = 100,
		['ruby'] = 800,
		['diamond'] = 1000,
		['sapphire'] = 200,

		-- ['diamond_ring'] = 100,
		-- ['emerald_ring'] = 100,
		-- ['ruby_ring'] = 100,
		-- ['sapphire_ring'] = 100,
		-- ['diamond_ring_silver'] = 100,
		-- ['emerald_ring_silver'] = 100,
		-- ['ruby_ring_silver'] = 100,
		-- ['sapphire_ring_silver'] = 100,

		-- ['diamond_necklace'] = 100,
		-- ['emerald_necklace'] = 100,
		-- ['ruby_necklace'] = 100,
		-- ['sapphire_necklace'] = 100,
		-- ['diamond_necklace_silver'] = 100,
		-- ['emerald_necklace_silver'] = 100,
		-- ['ruby_necklace_silver'] = 100,
		-- ['sapphire_necklace_silver'] = 100,

		-- ['diamond_earring'] = 100,
		-- ['emerald_earring'] = 100,
		-- ['ruby_earring'] = 100,
		-- ['sapphire_earring'] = 100,
		-- ['diamond_earring_silver'] = 100,
		-- ['emerald_earring_silver'] = 100,
		-- ['ruby_earring_silver'] = 100,
		-- ['sapphire_earring_silver'] = 100,

		-- ['gold_ring'] = 100,
		-- ['goldchain'] = 100,
		-- ['goldearring'] = 100,
		-- ['silver_ring'] = 100,
		-- ['silverchain'] = 100,
		-- ['silverearring'] = 100,

	},
------------------------------------------------------------
--Mining Store Items
	Items = {
		label = "Mining Store",  slots = 9,
		items = {
			{ name = "weapon_flashlight", price = 200, amount = 100, info = {}, type = "item", slot = 1, },
			{ name = "goldpan", price = 100, amount = 100, info = {}, type = "item", slot = 2, },
			{ name = "pickaxe",	price = 50, amount = 100, info = {}, type = "item", slot = 3, },
			{ name = "miningdrill",	price = 100000, amount = 50, info = {}, type = "item", slot = 4, },
			{ name = "mininglaser",	price = 300000, amount = 5, info = {}, type = "item", slot = 5, },
			{ name = "drillbit", price = 10, amount = 100, info = {}, type = "item", slot = 6, },
		},
	},
}
Crafting = {
	SmeltMenu = {
		{ ["copper"] = { ["copperore"] = 1 }, ['amount'] = 2 },
		{ ["iron"] = { ["ironore"] = 1 }, ['amount'] = 2 },
		{ ["goldingot"] = { ["goldore"] = 8 } },
		{ ["silveringot"] = { ["silverore"] = 8 } },
		{ ["aluminum"] = { ["can"] = 1, }, ['amount'] = 1 },
		{ ["plastic"] = { ["bottle"] = 1, }, ['amount'] = 1, },
	},
	GemCut = {
		{ ["emerald"] = { ["uncut_emerald"] = 1, } },
		{ ["diamond"] = { ["uncut_diamond"] = 1}, },
		{ ["ruby"] = { ["uncut_ruby"] = 1 }, },
		{ ["sapphire"] = { ["uncut_sapphire"] = 1 }, },
	},
	RingCut = {
		-- { ["gold_ring"] = { ["goldingot"] = 1 }, ['amount'] = 3 },
		-- { ["silver_ring"] = { ["silveringot"] = 1 }, ['amount'] = 3 },
		-- { ["diamond_ring"] = { ["gold_ring"] = 1, ["diamond"] = 1 }, },
		-- { ["emerald_ring"] = { ["gold_ring"] = 1, ["emerald"] = 1 }, },
		-- { ["ruby_ring"] = { ["gold_ring"] = 1, ["ruby"] = 1 }, },
		-- { ["sapphire_ring"] = { ["gold_ring"] = 1, ["sapphire"] = 1 }, },

		-- { ["diamond_ring_silver"] = { ["silver_ring"] = 1, ["diamond"] = 1 }, },
		-- { ["emerald_ring_silver"] = { ["silver_ring"] = 1, ["emerald"] = 1 }, },
		-- { ["ruby_ring_silver"] = { ["silver_ring"] = 1, ["ruby"] = 1 }, },
		-- { ["sapphire_ring_silver"] = { ["silver_ring"] = 1, ["sapphire"] = 1 }, },
	},
	NeckCut = {
		-- { ["goldchain"] = { ["goldingot"] = 1 }, ['amount'] = 3  },
		-- { ["silverchain"] = { ["silveringot"] = 1 }, ['amount'] = 3  },
		-- { ["diamond_necklace"] = { ["goldchain"] = 1, ["diamond"] = 1 }, },
		-- { ["ruby_necklace"] = { ["goldchain"] = 1, ["ruby"] = 1 }, },
		-- { ["sapphire_necklace"] = { ["goldchain"] = 1, ["sapphire"] = 1 }, },
		-- { ["emerald_necklace"] = { ["goldchain"] = 1, ["emerald"] = 1 }, },

		-- { ["diamond_necklace_silver"] = { ["silverchain"] = 1, ["diamond"] = 1 }, },
		-- { ["ruby_necklace_silver"] = { ["silverchain"] = 1, ["ruby"] = 1 }, },
		-- { ["sapphire_necklace_silver"] = { ["silverchain"] = 1, ["sapphire"] = 1 }, },
		-- { ["emerald_necklace_silver"] = { ["silverchain"] = 1, ["emerald"] = 1 }, },
	},
	EarCut = {
		-- { ["goldearring"] = { ["goldingot"] = 1 }, ['amount'] = 3  },
		-- { ["silverearring"] = { ["silveringot"] = 1 }, ['amount'] = 3  },
		-- { ["diamond_earring"] = { ["goldearring"] = 1, ["diamond"] = 1 }, },
		-- { ["ruby_earring"] = { ["goldearring"] = 1, ["ruby"] = 1 }, },
		-- { ["sapphire_earring"] = { ["goldearring"] = 1, ["sapphire"] = 1 }, },
		-- { ["emerald_earring"] = { ["goldearring"] = 1, ["emerald"] = 1 }, },

		-- { ["diamond_earring_silver"] = { ["silverearring"] = 1, ["diamond"] = 1 }, },
		-- { ["ruby_earring_silver"] = { ["silverearring"] = 1, ["ruby"] = 1 }, },
		-- { ["sapphire_earring_silver"] = { ["silverearring"] = 1, ["sapphire"] = 1 }, },
		-- { ["emerald_earring_silver"] = { ["silverearring"] = 1, ["emerald"] = 1 }, },
	},
}
