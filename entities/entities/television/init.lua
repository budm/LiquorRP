AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

require( "datastream" )

function ENT:Initialize()
	self.Entity:SetModel( "models/props/cs_office/TV_plasma.mdl" )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:DrawShadow( false )
end


function ENT:Use( activator, caller )
	if !activator:IsPlayer() then return false; end
	if !self:GetTable().ItemID then return false; end
	if activator != self:GetTable().ItemSpawner then return false; end
	if self.Entity:GetTable().Tapped then return false; end
	
	self.Entity:GetTable().Tapped = true;
	self.Entity.ItemSpawner:GetTable().NumProps = self.Entity.ItemSpawner:GetTable().NumProps - 1;
	
	activator:GiveItem(self:GetTable().ItemID, 1);
	
	self:Remove();
end


function ENT:SetContents ( ItemID )
	self:GetTable().ItemID = ItemID;
end


