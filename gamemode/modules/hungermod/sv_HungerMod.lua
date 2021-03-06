AddCSLuaFile(GM.FolderName.."/gamemode/modules/hungermod/cl_init.lua")

include(GM.FolderName.."/gamemode/modules/hungermod/sv_player.lua")

local HM = { }
local FoodItems = { }

GM.Config.hungermod = true
GM.Config.foodspawn = true
GM.Config.foodpay = true
GM.Config.foodcost = 15
GM.Config.hungerspeed = 0.75
GM.Config.starverate = 3

local function AddFoodItem(name, mdl, amount)
	FoodItems[name] = { model = mdl, amount = amount }
end

function HM.PlayerSpawn(ply)
	ply:SetSelfDarkRPVar("Energy", 100)
end
hook.Add("PlayerSpawn", "HM.PlayerSpawn", HM.PlayerSpawn)

function HM.Think()
	if not GAMEMODE.Config.hungermod then return end

	if not GAMEMODE.Config.hungerspeed then return end

	for k, v in pairs(player.GetAll()) do
		if v:Alive() and CurTime() - v:GetTable().LastHungerUpdate > 1 then
			v:HungerUpdate()
		end
	end
end
hook.Add("Think", "HM.Think", HM.Think)

function HM.PlayerInitialSpawn(ply)
	ply:NewHungerData()
end
hook.Add("PlayerInitialSpawn", "HM.PlayerInitialSpawn", HM.PlayerInitialSpawn)

for k, v in pairs(player.GetAll()) do
	v:NewHungerData()
end

AddFoodItem("banana", "models/props/cs_italy/bananna.mdl", 10)
AddFoodItem("bananabunch", "models/props/cs_italy/bananna_bunch.mdl", 20)
AddFoodItem("melon", "models/props_junk/watermelon01.mdl", 20)
AddFoodItem("popcan", "models/props_junk/PopCan01a.mdl", 5)
AddFoodItem("plasticbottle", "models/props_junk/garbage_plasticbottle003a.mdl", 15)
AddFoodItem("milk", "models/props_junk/garbage_milkcarton002a.mdl", 20)
AddFoodItem("orange", "models/props/cs_italy/orange.mdl", 20)

local function BuyFood(ply, args)
	if args == "" then return "" end

	local trace = {}
	trace.start = ply:EyePos()
	trace.endpos = trace.start + ply:GetAimVector() * 85
	trace.filter = ply

	local tr = util.TraceLine(trace)

	for k,v in pairs(FoodItems) do
		if string.lower(args) == k then
			local cost = GAMEMODE.Config.foodcost
			if ply:CanAfford(cost) then
				ply:AddMoney(-cost)
			else
				GAMEMODE:Notify(ply, 1, 4, string.format(LANGUAGE.cant_afford, ""))
				return ""
			end
			GAMEMODE:Notify(ply, 0, 4, string.format(LANGUAGE.you_bought_x, k, tostring(cost)))
			local SpawnedFood = ents.Create("spawned_food")
			SpawnedFood.dt.owning_ent = ply
			SpawnedFood.ShareGravgun = true
			SpawnedFood:SetPos(tr.HitPos)
			SpawnedFood.onlyremover = true
			SpawnedFood.SID = ply.SID
			SpawnedFood:SetModel(v.model)
			SpawnedFood.FoodEnergy = v.amount
			SpawnedFood:Spawn()
			return ""
		end
	end
	return ""
end
AddChatCommand("/buyfood", BuyFood)