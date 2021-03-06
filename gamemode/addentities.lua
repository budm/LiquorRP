-----------------------------------------------------------
 --------------      LiquorRP Entities      --------------
  -------------------------------------------------------
AddEntity("Cocaine",{
ent = "durgz_cocaine",
model = "models/cocn.mdl",
price = 100,
max = 5,
cmd = "/buycocaine",
allowed = {TEAM_DRUGDEALER}
})   
   
AddEntity("Aspirin Lab",{
ent = "aspirin_lab",
model = "models/props/de_nuke/PowerPlantTank.mdl",
price = 400,
max = 2,
cmd = "/buyaspirinlab",
allowed = {TEAM_DRUGDEALER}
})   
   
AddEntity("Pot Plant",{
ent = "weed_plant",
model = "models/nater/weedplant_pot_planted.mdl",
price = 75,
max = 5,
cmd = "/buyweed",
allowed = {TEAM_DRUGDEALER}
})

AddEntity("Cannabis Seed",{
ent = "seed_weed",
model = "models/katharsmodels/contraband/zak_wiet/zak_seed.mdl",
price = 150,
max = 15,
cmd = "/buyseed",
allowed = {TEAM_DRUGDEALER}
})

AddEntity("Television",{
 ent = "television",
 model = "models/props/cs_office/TV_plasma.mdl",
 price =100,
 max = 1,
 cmd = "/buytelevision"
})

AddEntity("Cell Phone (INVISIBLE)",{
 ent = "phone",
 model = "models/weapons/w_camphone.mdl",
 price =10,
 max = 1,
 cmd = "/buyphone"
})

AddEntity("Beer",{
 ent = "durgz_alcohol",
 model = "models/props_junk/garbage_glassbottle002a.mdl",
 price =10,
 max = 15,
 cmd = "/buybeer"
})

AddEntity("Wine",{
 ent = "durgz_wine",
 model = "models/props_junk/garbage_glassbottle003a.mdl",
 price =10,
 max = 15,
 cmd = "/buywine"
})

AddEntity("Hard Liquor",{
 ent = "durgz_liquor",
 model = "models/props_junk/glassjug01.mdl",
 price =10,
 max = 15,
 cmd = "/buyliquor"
})

AddEntity("Cigarettes",{
 ent = "durgz_cigarette",
 model = "models/closedboxshib.mdl",
 price =15,
 max = 15,
 cmd = "/buycigs"
})

AddEntity("Big Moonshine Still",{
 ent = "big_still",
 model = "models/props/CS_Militia/furnace01.mdl",
 price =100,
 max = 2,
 cmd = "/buybigstill"
})

AddEntity("Small Moonshine Still",{
 ent = "small_still",
 model = "models/props_C17/FurnitureFireplace001a.mdl",
 price =50,
 max = 2,
 cmd = "/buysmallstill"
})

AddEntity("Toilet Wine",{
 ent = "toilet_wine",
 model = "models/props/CS_Militia/toilet.mdl",
 price =5,
 max = 10,
 cmd = "/buycheapwine"
})

AddEntity("Fermenation Bucket",{
 ent = "beer_bucket",
 model = "models/props_junk/plasticbucket001a.mdl",
 price =50,
 max = 10,
 cmd = "/buybucket"
})

AddEntity("Beer Barrel",{
 ent = "beer_barrel",
 model = "models/props_c17/woodbarrel001.mdl",
 price =400,
 max = 5,
 cmd = "/buybarrel",
 allowed = {TEAM_GUN}
})

AddEntity("Baseball bat", {
	ent = "baseball_bat",
	model = "models/weapons/w_basebat.mdl",
	price = 100,
	max = 5,
	cmd = "/buybat"
})

AddEntity("Pill lab", {
	ent = "drug_lab",
	model = "models/props_lab/crematorcase.mdl",
	price = 400,
	max = 3,
	cmd = "/buypilllab",
	allowed = TEAM_DRUGDEALER
})

AddEntity("Money Maker", {
	ent = "money_printer",
	model = "models/props_c17/consolebox01a.mdl",
	price = 1000,
	max = 2,
	cmd = "/buymoneyprinter"
})

AddEntity("Microwave", {
	ent = "microwave",
	model = "models/props/cs_office/microwave.mdl",
	price = 50,
	max = 1,
	cmd = "/buymicrowave"
})

-----------------------------------------------------------
 --------------        LiquorRP Cars        --------------
  -------------------------------------------------------
AddCustomVehicle("Jeep",{
 model = "models/buggy.mdl",
 price = 600,
max = 1,
cmd = "/buyjeep"
})


