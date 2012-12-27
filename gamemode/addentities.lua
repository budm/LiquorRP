AddEntity("Big Moonshine Still",{
 ent = "big_still",
 model = "models/props/CS_Militia/furnace01.mdl",
 price =100,
 max = 2,
 cmd = "/buybigstill",
})

AddEntity("Small Moonshine Still",{
 ent = "small_still",
 model = "models/props_C17/FurnitureFireplace001.mdl",
 price =50,
 max = 2,
 cmd = "/buysmallstill",
})

AddEntity("Toilet Wine",{
 ent = "toilet_wine",
 model = "models/props/CS_Militia/toilet.mdl",
 price =5,
 max = 10,
 cmd = "/buycheapwine",
})

AddEntity("Fermenation Bucket",{
 ent = "beer_bucket",
 model = "models/props_junk/plasticbucket001a.mdl",
 price =50,
 max = 10,
 cmd = "/buybucket",
})
AddEntity("Beer Barrel",{
 ent = "beer_barrel",
 model = "models/props_c17/woodbarrel001.mdl",
 price =400,
 max = 5,
 cmd = "/buybarrel",
 allowed = {TEAM_GUN}
})

AddEntity("Knife", {
	ent = "weapon_real_cs_knife",
	model = "models/weapons/w_knife_t.mdl",
	price = 400,
	max = 5,
	cmd = "/buyknife",
})

AddEntity("Pill lab", {
	ent = "drug_lab",
	model = "models/props_lab/crematorcase.mdl",
	price = 400,
	max = 3,
	cmd = "/buypilllab",
	allowed = {TEAM_DRUGDEALER}
})

AddEntity("Liquor Money Maker", {
	ent = "money_printer",
	model = "models/props_c17/consolebox01a.mdl",
	price = 1000,
	max = 2,
	cmd = "/buymoneyprinter"
})

AddEntity("Microwave", {
	ent = "microwave",
	model = "models/props/cs_office/microwave.mdl",
	price = 400,
	max = 1,
	cmd = "/buymicrowave",
	allowed = TEAM_COOK
})

--AddEntity("Gun lab", {
--	ent = "gunlab",
--	model = "models/props_c17/TrapPropeller_Engine.mdl",
--	price = 500,
--	max = 1,
--	cmd = "/buygunlab",
--	allowed = TEAM_GUN
--})

-- ADD CUSTOM SHIPMENTS HERE(next line):
