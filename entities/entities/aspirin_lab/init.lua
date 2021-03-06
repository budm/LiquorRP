AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.SeizeReward = 350

function ENT:Initialize()
	self:SetModel("models/props/de_nuke/PowerPlantTank.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	phys:Wake()
	self.sparking = false
	self.damage = 100
	local ply = self.dt.owning_ent
	self.SID = ply.SID
	self.SID = ply.SID
	self.dt.price = math.Clamp((GAMEMODE.Config.pricemin ~= 0 and GAMEMODE.Config.pricemin) or 100, (GAMEMODE.Config.pricecap ~= 0 and GAMEMODE.Config.pricecap) or 100)
	self.CanUse = true
	self.ShareGravgun = true
end

function ENT:OnTakeDamage(dmg)
	self.damage = self.damage - dmg:GetDamage()
	if (self.damage <= 0) then
		self:Remove()
	end
end

function ENT:Destruct()
	local vPoint = self:GetPos()
	local effectdata = EffectData()
	effectdata:SetStart(vPoint)
	effectdata:SetOrigin(vPoint)
	effectdata:SetScale(1)
	util.Effect("Explosion", effectdata)
end

function ENT:Use(activator,caller)
	if not self.CanUse then return false end
	self.CanUse = false
	self.drug_user = activator
	if activator.maxDrugs and activator.maxDrugs >= GAMEMODE.Config.maxdrugs then
		GAMEMODE:Notify(activator, 1, 3, "You can't make anymore Aspirin as the limit is reached.")
		timer.Simple(0.5, function() self.CanUse = true end)
	else

		local productioncost = math.random(self.dt.price / 8, self.dt.price / 4)
		if not activator:CanAfford(productioncost) then
			GAMEMODE:Notify(activator, 1, 4, "You do not have enough money to produce Aspirin.")
			return false
		end
		activator:AddMoney(-productioncost)
		GAMEMODE:Notify(activator, 0, 4, "You have made Aspirin! production cost: " .. CUR .. tostring(productioncost).."!")
		self.sparking = true
		timer.Create(self:EntIndex() .. "drug", 1, 1, function() self:createDrug() end)
	end
end

function ENT:createDrug()
	self.CanUse = true
	local userb = self.drug_user
	local drugPos = self:GetPos()
	drug = ents.Create("durgz_aspirin")
	drug:SetPos(Vector(drugPos.x,drugPos.y,drugPos.z + 35))
	drug.ShareGravgun = true
	drug.nodupe = true
	drug.dt.price = self.dt.price or 100
	drug:Spawn()
	self.sparking = false
end

function ENT:Think()
	if not self.SID then
		self.SID = self.dt.price
	end
	if self.sparking then
		
	end
end

function ENT:OnRemove()
	if not IsValid(self) then return end
	timer.Destroy(self:EntIndex() .. "durgz_aspirin")
	self:Destruct()
end