local ITEM = {};

ITEM.ID = 'drug_cig';
ITEM.Weight = 5;
ITEM.Cost = 50;
ITEM.Name = 'Shibboro Cigarettes';
ITEM.Description = "These make you cool.";

ITEM.Model = "models/boxopencigshib.mdl";

ITEM.ModelCamPos = Vector(6, 0, 0);
ITEM.ModelLookAt = Vector(0, 0, 0);
ITEM.ModelFOV = 70;

ITEM.StopDropSounds = true;

if SERVER then
	function ITEM.OnUse ( Player )		
		timer.Simple(2.35, function ( )
							local Effect = EffectData();
							Effect:SetOrigin(Player:GetShootPos() + Player:GetAimVector() * 5);
							util.Effect('cig_smoke', Effect);
							
							Player:TakeDamage(5, Player, Player);
						end
					);
					
		//Player:AddProgress(29, 1);
		
		umsg.Start('perp_i_smoke', Player); umsg.End();
	
		return true;
	end
	
	function ITEM.OnDrop ( Player )
		umsg.Start('perp_drop', Player); umsg.End();
	
		return true;
	end
else
	function ITEM.DoSmoke ( )
		surface.PlaySound('perp/smoke.mp3');
	end
	usermessage.Hook('perp_i_smoke', ITEM.DoSmoke)
end

GM:RegisterItem(ITEM);