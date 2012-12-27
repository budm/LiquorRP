if (SERVER) then
	AddCSLuaFile("shared.lua")
	
	resource.AddSingleFile("models/weapons/v_fists_t.dx80.vtx")
	resource.AddSingleFile("models/weapons/v_fists_t.dx90.vtx")
	resource.AddSingleFile("models/weapons/v_fists_t.mdl")
	resource.AddSingleFile("models/weapons/v_fists_t.sw.vtx")
	resource.AddSingleFile("models/weapons/v_fists_t.vvd")
	resource.AddSingleFile("models/weapons/v_fists_tt.dx90.vtx")

	
end

if (CLIENT) then
	SWEP.PrintName = "Fists"
	SWEP.Slot = 3
	SWEP.SlotPos = 2
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

-- Variables that are used on both client and server
SWEP.Base = "weapon_cs_base2"

SWEP.ViewModel			= "models/weapons/v_fists_t.mdl"
SWEP.Author = "Budm"
SWEP.Instructions = "Left click to Punch!"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.WorldModel = Model("")

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false

SWEP.Spawnable = false
SWEP.AdminSpawnable = true

SWEP.Sound = Sound("npc/vort/foot_hit.wav","npc/zombie/zombie_hit.wav")

SWEP.Primary.ClipSize = -1      -- Size of a clip
SWEP.Primary.DefaultClip = 0        -- Default number of bullets in a clip
SWEP.Primary.Automatic = false      -- Automatic/Semi Auto
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1        -- Size of a clip
SWEP.Secondary.DefaultClip = 0     -- Default number of bullets in a clip
SWEP.Secondary.Automatic = false     -- Automatic/Semi Auto
SWEP.Secondary.Ammo = ""

/*---------------------------------------------------------
Name: SWEP:Initialize()
Desc: Called when the weapon is first loaded
---------------------------------------------------------*/
function SWEP:Initialize()
	self.LastIron = CurTime()
	self:SetWeaponHoldType("normal")
	self.Ready = false
end

/*---------------------------------------------------------------------------
Name: SWEP:Deploy()
Desc: called when the weapon is deployed
---------------------------------------------------------------------------*/
function SWEP:Deploy()
	if SERVER then
		self.Owner:DrawViewModel(true)
		self.Owner:DrawWorldModel(false)
	end
end

function SWEP:Holster()
	if not self.Ready or not SERVER then return true end

	GAMEMODE:SetPlayerSpeed(self.Owner, GAMEMODE.Config.walkspeed, GAMEMODE.Config.runspeed)
	self.Owner:SetJumpPower(200)

	return true
end

/*---------------------------------------------------------
Name: SWEP:PrimaryAttack()
Desc: +attack1 has been pressed
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
	local ply = self.Owner
	
	if CLIENT then
		self.Weapon:EmitSound("npc/zombie/claw_miss" .. math.random( 1, 2 ) .. ".wav");
	end
	
	ply:DoAnimationEvent(ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST)
	ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST)
	
	self.Weapon:SetNextPrimaryFire(CurTime() + 1)

	self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
	
	local EyeTrace = ply:GetEyeTrace();
	
	if ply:EyePos():Distance(EyeTrace.HitPos) > 75 then return false; end

    local final = HitSounds[math.random(1,#HitSounds)]

	if EyeTrace.MatType == MAT_GLASS then
		if CLIENT then
			self.Weapon:EmitSound("physics/glass/glass_cup_break" .. math.random(1, 2) .. ".wav");
		end
		return false
	end
	
	if EyeTrace.HitWorld then
		if CLIENT then
			self.Weapon:EmitSound( final );
		end
		return false;
	end

	if CLIENT and EyeTrace.Entity and EyeTrace.Entity:IsValid() then self.Weapon:EmitSound( final ) end

	if EyeTrace.MatType == MAT_FLESH then
		if CLIENT then
			// probably another person or NPC
			self.Weapon:EmitSound( final )
			
			local OurEffect = EffectData();
			OurEffect:SetOrigin(EyeTrace.HitPos);
			util.Effect("BloodImpact", OurEffect);
		end
		
		if SERVER then
			if EyeTrace.Entity and EyeTrace.Entity:IsValid() and EyeTrace.Entity:IsPlayer() then
				EyeTrace.Entity:TakeDamage(ply.Character.Skills["Stamina"].lvl*3, ply, self.Weapon)
			end
		end
		
		return false;
	else
		// something else?
		if CLIENT then
			self.Weapon:EmitSound( final )
		end
	end
end

function SWEP:SecondaryAttack()
	return false
end
