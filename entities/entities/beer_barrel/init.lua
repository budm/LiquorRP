-- ========================
-- =          Crate SENT by Mahalis
-- ========================

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/props_c17/woodbarrel001.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetUseType(SIMPLE_USE)
	local phys = self.Entity:GetPhysicsObject()
	if phys and phys:IsValid() then phys:Wake() end
	self.sparking = false
	self.damage = 100
   self.Once = false
	self.Entity.dt.price = 30
end

function ENT:OnTakeDamage(dmg)
	self.damage = self.damage - dmg:GetDamage()
	if (self.damage <= 0) then
		self.Entity:Destruct()
		self.Entity:Remove()
	end
end

function ENT:Destruct()
	local vPoint = self.Entity:GetPos()
	local effectdata = EffectData()
	effectdata:SetStart(vPoint)
	effectdata:SetOrigin(vPoint)
	effectdata:SetScale(1)
	util.Effect("Explosion", effectdata)
end

function ENT:SalePrice(activator)
   return 30
end

ENT.Once = false
function ENT:Use(activator,caller)
   if self.Once == true then
      --Do nothing
   elseif self.Once == false then
      local owner = self.Entity.dt.owning_ent
      self.user = activator
      if not activator:CanAfford(self:SalePrice(activator)) then
         Notify(activator, 1, 3, "You cannot afford to get any beer from the barrel!")
         return ""
      end
      if activator:CanAfford(self:SalePrice(activator)) and self.Once == false then
         activator:AddMoney(-30)
         self.sparking = true
         self.Once = true
         timer.Create( "my_timer", 3, 1, function()
            self:createFood()
         end )

         Notify(activator, 1, 2, "You recieve a beer for 30$!")
      end
   end
end

function ENT:createFood()
	activator = self.user
	self.Once = false
	local foodPos = self.Entity:GetPos()
	food = ents.Create("durgz_alcohol")
	food:SetPos(Vector(foodPos.x,foodPos.y,foodPos.z + 23))
	food.ShareGravgun = true
	food.nodupe = false
	food:Spawn()
	self.sparking = false
end

function ENT:Think()
	if self.sparking then
		local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos())
		effectdata:SetMagnitude(1)
		effectdata:SetScale(1)
		effectdata:SetRadius(2)
		util.Effect("Sparks", effectdata)
	end
end

function ENT:OnRemove()
	timer.Destroy(self.Entity:EntIndex())
	local ply = self.Entity.dt.owning_ent
	if not ValidEntity(ply) then return end
end