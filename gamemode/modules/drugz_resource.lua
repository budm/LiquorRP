
--SERVER HOSTERS: Delete the line below if you don't want to make people have to download the DurgzMod models (or just put // in front of local).
local DURGZ_ADD_FILES = true;
--Delete the line below if you don't want to make people have to download the spawn icons. (or just put // in front of local).
local ADD_SPAWN_ICONS = true;


--Ignore this stuff if you don't Lua code.


local function AddSIcon(materials)
	for k,v in pairs(materials)do
		resource.AddFile("materials/vgui/entities/"..v..".vmt");
		resource.AddFile("materials/vgui/entities/"..v..".vtf");
	end
end

local function r(materials, models)
	if(materials)then
		for k,v in pairs(materials)do
			resource.AddFile("materials/"..v);
		end
	end
	if(models)then
		for k,v in pairs(models)do
			resource.AddFile("models/"..v);
		end
	end
end

local function syringeMats(mats)
	for k,v in pairs(mats)do
		resource.AddFile("materials/katharsmodels/syringe_out/syringe_"..v);
	end
end

local function addShib(mat, modl)
	for k,v in pairs(mat)do
		resource.AddFile("materials/models/shibboro/"..v..".vmt")
		resource.AddFile("materials/models/shibboro/"..v..".vtf")
	end
	
	for k,v in pairs(modl)do
		resource.AddFile("models/"..v..".mdl");
	end

end

local function AddFiles()
	syringeMats(
		{
			"body.vmt",
			"grip.vmt",
			"liquid.vmt",
			"lowerstopper.vmt",
			"needle.vmt",
			"stopper.vmt",
			"tip.vmt",
			"body.vtf",
			"body_mask.vtf",
			"grip.vtf",
			"liquid.vtf",
			"lowerstopper.vtf",
			"needle.vtf",
			"stopper.vtf",
			"tip.vtf"
		}
	)

	r(
		{
			
			"models/marioragdoll/Super Mario Galaxy/star/starSS01.vmt",
			"models/marioragdoll/Super Mario Galaxy/star/starSS01.vtf",
			"models/marioragdoll/Super Mario Galaxy/star/starSS06.vmt",
			"models/marioragdoll/Super Mario Galaxy/star/starSS06.vtf",
			"models/marioragdoll/Super Mario Galaxy/star/yellow.vmt",
			"models/marioragdoll/Super Mario Galaxy/star/yellow.vtf",
			"katharsmodels/contraband/contraband_normal.vtf",
			"katharsmodels/contraband/contraband_one.vmt",
			"katharsmodels/contraband/contraband_one.vtf",
			"katharsmodels/contraband/contraband_two.vmt",
			"ipha/mushd.vmt",
			"ipha/mushd.vtf",
			"models/drug/drug.vmt",
			"models/drug/drug.vtf",
			"models/druggg_mod/PopCan01a.vmt",
			"models/druggg_mod/PopCan01a.vtf",
			"jaanus/aspbtl_a.vmt",
			"jaanus/aspbtl_a.vtf",
			"jaanus/aspirin_.vtf",
			"jaanus/aspirin_.vmt",
			"models/drug/waterbottl/water_bottle.vmt",
			"models/drug/waterbottl/water_bottle.vtf",
			"models/drug/waterbottl/water_bottle_ref.vtf",
			"smile/smile.vmt",
			"smile/smile.vtf"
		},
		
		{
			"cocn.mdl",
			"shibcuppyhold.mdl",
			"ipha/mushroom_small.mdl",
			"drug_mod/alcohol_can.mdl",
			"drug_mod/the_bottle_of_water.mdl",
			"katharsmodels/contraband/zak_wiet/zak_wiet.mdl",
			"katharsmodels/syringe_out/syringe_out.mdl",
			"jaanus/aspbtl.mdl",
			"smile/smile.mdl",
			"marioragdoll/Super Mario Galaxy/star/star.mdl"
		}


	)


	addShib(
		{
			"cigsshib",
			"openyesshib"
		},
		
		{
			"boxopencigshib",
			"pissedmeoff"
		}
	)
	
	
	
end

local function AddFilesNoExceptions()
	
	if( ADD_SPAWN_ICONS )then
		AddSIcon(
			{
				"durgz_cigarette",
				"durgz_cocaine",
				"durgz_weed",
				"durgz_lsd",
				"durgz_mushroom",
				"durgz_heroine",
				"durgz_water",
				"durgz_aspirin",
				"durgz_pcp",
				"durgz_alcohol"
			}
		)
	end
	
	AddSIcon({"weapon_durgz"});
	
	r(
		{
			"highs/shader3.vtf",
			"highs/shader3.vmt",
			"highs/shader3_dudv.vtf",
			"highs/shader3_dudv.vmt",
			"highs/shader3_normal.vtf",
			"highs/shader3_normal.vmt",
			//"highs/ecstasy_smile.vtf",
			//"highs/ecstasy_smile.vmt",
		}
	)
	
	
		local drugs = {
			"weed",
			"cocaine",
			"cigarette",
			"alcohol",
			"mushroom",
			"pcp",
			"lsd"
		}
		
	
end

if( DURGZ_ADD_FILES )then
	AddFiles()
end
AddFilesNoExceptions()
game.ConsoleCommand("sv_tags LiquorDrugs \n")  