AddCSLuaFile("shared.lua")
include("shared.lua")


ENT.MODEL = "models/props_junk/garbage_glassbottle003a.mdl"

ENT.LASTINGEFFECT = 45; --how long the high lasts in seconds


/*

    pl:ConCommand("pp_motionblur 0.15")  
    pl:ConCommand("pp_motionblur_addalpha 0.05")  
    pl:ConCommand("pp_motionblur_delay 0.035")  
    pl:ConCommand("pp_motionblur_drawalpha 1.00")  
    pl:ConCommand("pp_dof 1")  
    pl:ConCommand("pp_dof_initlength 9")  
    pl:ConCommand("pp_dof_spacing 8") 
    pl:ConCommand("say waitt, wait. guysss. i need to tells u abuot micrsfoft excel!11!") 
	

    local IDSteam = string.gsub(pl:SteamID(), ":", "")

    timer.Create(IDSteam, 30, 1, UnDrugPlayer, pl)

*/



function ENT:High(activator,caller)
	self:Say(activator,"waitt, wait. guysss. i need to tells u abuot micrsfoft excel!11!")
	
	--does random stuff while higH!
	local commands = {"left", "right", "moveleft", "moveright", "attack"}
	local thing = math.random(1,3)
	
	local TRANSITION_TIME = self.TRANSITION_TIME;
	
	for i = 1,thing do
		timer.Simple(math.Rand(5,10), function()
			if( activator && activator:GetNetworkedFloat("durgz_alcohol_high_end") - TRANSITION_TIME > CurTime() )then
				local cmd = commands[math.random(1, #commands)]
				activator:ConCommand("+"..cmd)
				timer.Simple(1, function()
					activator:ConCommand("-"..cmd)
				end)
			end
		end)
	end
end


function ENT:SpawnFunction( ply, tr ) 
   
 	if ( !tr.Hit ) then return end 
 	 
 	local SpawnPos = tr.HitPos + tr.HitNormal * 16 
 	 
 	local ent = ents.Create( self.Classname ) 
 		ent:SetPos( SpawnPos ) 
 	ent:Spawn() 
 	ent:Activate() 
 	 
 	return ent 
 	 
 end 
