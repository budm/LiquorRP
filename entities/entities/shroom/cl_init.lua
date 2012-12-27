
include('shared.lua')

/*---------------------------------------------------------
   Name: DrawTranslucent
   Desc: Draw translucent
---------------------------------------------------------*/

local FullGrowthTime = 360
local MakeBrown = 720;
local StartFade = 780;
local FullDeath = 840;

function ENT:Draw()
	local SinceSpawn = CurTime() - self.SpawnTime;
	local BrownPerc = (SinceSpawn - MakeBrown) / (StartFade - MakeBrown);
	local FullGrowthPerc = SinceSpawn / FullGrowthTime;

	if (LocalPlayer():GetEyeTrace().Entity == self.Entity and LocalPlayer():GetShootPos():Distance(self.Entity:GetPos()) < 512) and BrownPerc < 0 and FullGrowthPerc > 1 then
		self:DrawEntityOutline( 1.05 )
	end
	
	if self.Go then
		self:DrawModel();
	end
end

function ENT:Think ( )	
	local SinceSpawn = CurTime() - self.SpawnTime;
	local FullGrowthPerc = SinceSpawn / FullGrowthTime;
	local BrownPerc = (SinceSpawn - MakeBrown) / (StartFade - MakeBrown);
	local FadePerc = (SinceSpawn - StartFade) / (FullDeath - StartFade);
	
	if FullGrowthPerc > 0 and FullGrowthPerc < 1 then		
		self:SetPos(self.Position - Vector(0, 0, (1 - FullGrowthPerc) * self.Height));
	elseif BrownPerc > 0 and BrownPerc < 1 then	
		self:SetColor(255 - (BrownPerc * (255 - 139)), 255 - (BrownPerc * (255 - 69)), 255 - (BrownPerc * (255 - 19)), 255);
	elseif FadePerc > 0 and FadePerc < 1 then	
		self:SetColor(139, 69, 19, (1 - FadePerc) * 255);		
	end
	
	self.Go = true;
end

function ENT:Initialize ( )	
	self.SpawnTime = CurTime();
	self.Position = self:GetPos();
	self.Brownified = false;
	
	self.Height = (self:OBBMaxs() - self:OBBMins()).z;
end

local matOutlineWhite 	= Material( "white_outline" )
local ScaleNormal		= Vector()
local ScaleOutline1		= Vector() * 1
local ScaleOutline2		= Vector() * 1.1
local matOutlineBlack 	= Material( "black_outline" )

function ENT:DrawEntityOutline( size )
	
	size = size or 1.0
	render.SuppressEngineLighting( true )
	render.SetAmbientLight( 1, 1, 1 )
	render.SetColorModulation( 1, 1, 1 )
	
		// First Outline	
		self:SetModelScale( ScaleOutline2 * size )
		SetMaterialOverride( matOutlineBlack )
		self:DrawModel()
		
		
		// Second Outline
		self:SetModelScale( ScaleOutline1 * size )
		SetMaterialOverride( matOutlineWhite )
		self:DrawModel()
		
		// Revert everything back to how it should be
		SetMaterialOverride( nil )
		self:SetModelScale( ScaleNormal )
		
	render.SuppressEngineLighting( false )
	
	local r, g, b = self:GetColor()
	render.SetColorModulation( r/255, g/255, b/255 )

end
