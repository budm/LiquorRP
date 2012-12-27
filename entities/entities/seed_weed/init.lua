-- ========================
-- =          Crate SENT by Mahalis
-- ========================

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:SpawnFunction(ply, tr) -- Spawn function needed to make it appear on the spawn menu
	if (!tr.HitWorld) then return end
 
	local ent = ents.Create("seed_weed") -- Create the entity
	ent:SetPos(tr.HitPos + Vector(0, 0, 50)) -- Set it to spawn 50 units over the spot you aim at when spawning it
	ent:Spawn() -- Spawn it 
		
		return ent -- You need to return the entity to make it work
end
function ENT:Initialize()
	self.Entity:SetModel("models/katharsmodels/contraband/zak_wiet/zak_seed.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetUseType(SIMPLE_USE)
	local phys = self.Entity:GetPhysicsObject()
	if phys and phys:IsValid() then phys:Wake() end
	self.sparking = false
	self.damage = 50
	local ply = self.Entity:GetNWEntity("owning_ent")
end

function ENT:OnTakeDamage(dmg)
	self.damage = self.damage - dmg:GetDamage()
	if (self.damage <= 0) then
		self.Entity:Remove()
	end
end

function ENT:Use()
end

function ENT:OnRemove()
	timer.Destroy(self.Entity:EntIndex())
	local ply = self.Entity:GetNWEntity("owning_ent")
	if not ValidEntity(ply) then return end
end