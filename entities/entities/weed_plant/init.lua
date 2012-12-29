AddCSLuaFile("cl_init.lua")

AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:SpawnFunction(ply, tr) -- Spawn function needed to make it appear on the spawn menu
	if (!tr.HitWorld) then return end
 
	local ent = ents.Create("weed_plant") -- Create the entity
	ent:SetPos(tr.HitPos + Vector(0, 0, 50)) -- Set it to spawn 50 units over the spot you aim at when spawning it
	ent:Spawn() -- Spawn it
 
	return ent -- You need to return the entity to make it work
end

function ENT:Initialize()
 
self.Entity:SetModel("models/nater/weedplant_pot_dirt.mdl")
self.Entity:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
self.Entity:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
self.Entity:SetSolid( SOLID_VPHYSICS )         -- Toolbox

self.Entity:PhysicsInit(SOLID_VPHYSICS)

local phys = self.Entity:GetPhysicsObject()

local phys = self.Entity:GetPhysicsObject()
if (phys:IsValid()) then
		phys:Wake()
	end
 
self.Entity:SetNetworkedBool("Usable", false)

self.Entity:SetNetworkedBool("Plantable", true)

self.damage = 10

local ply = self.Entity:GetNetworkedEntity("owning_ent")

end

function ENT:OnTakeDamage(dmg)

self.damage = self.damage - dmg:GetDamage()

if (self.damage <= 0) then

local effectdata = EffectData()

effectdata:SetOrigin(self.Entity:GetPos())

effectdata:SetMagnitude(2)

effectdata:SetScale(2)

effectdata:SetRadius(3)

util.Effect("Sparks", effectdata)

self.Entity:Remove()

end

end

function ENT:Use()
	if !activator:IsPlayer() then return false; end
	if self.Entity:GetTable().Tapped then return false; end

	if activator:Team() == TEAM_POLICE then
		self.Entity:GetTable().Tapped = true;
		
		activator:AddCash(GAMEMODE.CopReward_Shrooms);
		activator:PrintMessage(HUD_PRINTTALK, "You have been rewarded $" .. GAMEMODE.CopReward_Shrooms .. " for destroying a cannabis plant");
		self:Remove();
		return false;

if self.Entity:GetNetworkedBool("Usable") == true then

self.Entity:SetNetworkedBool("Usable", false)

self.Entity:SetNetworkedBool("Plantable", true)

self.Entity:SetModel("models/nater/weedplant_pot_dirt.mdl")

local SpawnPos = self.Entity:GetPos()

local WeedBag = ents.Create("durgz_weed")
local SeedBag = ents.Create("seed_weed")

WeedBag:SetPos(SpawnPos)
SeedBag:SetPos(SpawnPos)

WeedBag:Spawn()
SeedBag:Spawn() --Temporarily Just creates one bag of weed and one seed. Later It will create Random amounts (0-4) Weed, (1-3)seed 

end

end

function ENT:Touch(hitEnt)

if hitEnt:GetClass() == "seed_weed" then

if self.Entity:GetNetworkedBool("Plantable") == true then

self.Entity:SetNetworkedBool("Plantable", false)

hitEnt:Remove()

self.Entity:SetModel("models/nater/weedplant_pot_planted.mdl")

timer.Create("Stage2_"..self:EntIndex(), 10, 1, function()

self.Entity:SetModel("models/nater/weedplant_pot_growing1.mdl")

end)

timer.Create("Stage3_"..self:EntIndex(), 15, 1, function()

self.Entity:SetModel("models/nater/weedplant_pot_growing2.mdl")

end)

timer.Create("Stage4_"..self:EntIndex(), 20, 1, function()

self.Entity:SetModel("models/nater/weedplant_pot_growing3.mdl")

end)

timer.Create("Stage5_"..self:EntIndex(), 25, 1, function()

self.Entity:SetModel("models/nater/weedplant_pot_growing4.mdl")

end)

timer.Create("Stage6_"..self:EntIndex(), 30, 1, function()

self.Entity:SetModel("models/nater/weedplant_pot_growing5.mdl")

end)

timer.Create("Stage7_"..self:EntIndex(), 35, 1, function()

self.Entity:SetModel("models/nater/weedplant_pot_growing6.mdl")

end)

timer.Create("Stage8_"..self:EntIndex(), 40, 1, function()

self.Entity:SetModel("models/nater/weedplant_pot_growing7.mdl")

self.Entity:SetNetworkedBool("Usable", true)

end)

end

end

end

function ENT:OnRemove()

if self.Entity:GetNetworkedBool("Plantable") == false then

timer.Destroy("Stage2")

timer.Destroy("Stage3")

timer.Destroy("Stage4")

timer.Destroy("Stage5")

timer.Destroy("Stage6")

timer.Destroy("Stage7")

timer.Destroy("Stage8")

end

end 