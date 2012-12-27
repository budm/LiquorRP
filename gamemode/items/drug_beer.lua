local ITEM = {};

ITEM.ID = 'drug_beer';
ITEM.Weight = 5;
ITEM.Cost = 150;
ITEM.Name = 'Beer';
ITEM.Description = "Drink your worries away.";

ITEM.Model = "models/props_junk/garbage_glassbottle002a.mdl";
ITEM.ModelCamPos = Vector(20, 0, 0);
ITEM.ModelLookAt = Vector(0, 0, 0);
ITEM.ModelFOV = 70;

ITEM.StopDropSounds = true;

if SERVER then
	local function RemoveDrankBeer ( Player )
		if Player and Player:IsValid() and Player:IsPlayer() then
			Player:GetTable().NumBeersDrank = Player:GetTable().NumBeersDrank - 1;
		end
	end
	
	local function DrinkEffects ( )
		for k, v in pairs(player.GetAll()) do
			if v:Alive() and v:GetTable().NumBeersDrank and v:GetTable().NumBeersDrank >= 2 then
				v:GetTable().NextBarf = v:GetTable().NextBarf or CurTime() + math.random(5, 10);
				
				if v:GetTable().NextBarf < CurTime() then
					v:GetTable().NextBarf = CurTime() + math.random(20, 45);
					
					v:AddProgress(30, 1);
					v:Puke();
				end
			elseif v:GetTable().NextBarf then
				v:GetTable().NextBarf = nil;
			end
		end
	end
	hook.Add('Think', 'DrinkEffects', DrinkEffects);
	
	function GM:SetupMove ( Player, Move )
		if Player:Alive() and Player:GetTable().NumBeersDrank and Player:GetTable().NumBeersDrank > 0 then
			if Player:InVehicle() then
				if math.sin(CurTime() / 2) < -.8 and (!Player:GetTable().LastMod or Player:GetTable().LastMod != 1) then
					Player:GetTable().LastMod = 1
					Player:ConCommand("+moveright\n");
				elseif math.sin(CurTime() / 2) > .8 and (!Player:GetTable().LastMod or Player:GetTable().LastMod != 2) then
					Player:ConCommand("+moveleft\n");
					Player:GetTable().LastMod = 2
				elseif !Player:GetTable().LastMod or Player:GetTable().LastMod != 3 then
					Player:ConCommand("-moveright;-moveleft\n");
					Player:GetTable().LastMod = 3
				end
			else
				if Player:GetTable().LastMod then
					Player:ConCommand("-moveright;-moveleft\n");
					Player:GetTable().LastMod = nil;
				end
				
				Move:SetMoveAngles(Move:GetMoveAngles() + Angle(0, math.Clamp(math.sin(CurTime() * 2), -.75, .75) * math.Clamp((Player:GetTable().NumBeersDrank * 20), 0, 60), 0));
			end
		elseif Player:GetTable().LastMod then
			Player:ConCommand("-moveright;-moveleft\n");
			Player:GetTable().LastMod = nil;
		end
	end

	function ITEM.OnUse ( Player )		
		umsg.Start('perp_i_drink', Player); umsg.End();
		Player:GiveItem('weapon_rp_bottle', 1);
		
		Player:GetTable().NumBeersDrank = Player:GetTable().NumBeersDrank or 0;
		Player:GetTable().NumBeersDrank = Player:GetTable().NumBeersDrank + 1;
		timer.Simple(60, RemoveDrankBeer, Player);
		
		if Player:GetTable().NumBeersDrank > 6 and math.random(1, 3) == 1 then
			Player:Notify("You have been hit with alcohol poisoning! I hope you get help soon!");
			Player:Kill();
		end
		
		return true;
	end
else
	function ITEM.MakeEffects ( )
		if !GAMEMODE.NumDrunk or GAMEMODE.NumDrunk == 0 then return false; end
 		DrawMotionBlur(math.Clamp(.04 - .005 * (GAMEMODE.NumDrunk - 1), .01, .035), math.Clamp(GAMEMODE.NumDrunk * .2, .1, 1), 0);
	end
	hook.Add("RenderScreenspaceEffects", "ITEM.MakeEffects_BEER", ITEM.MakeEffects)
	
	function ITEM.DoDrinkInc ( UMsg )
		GAMEMODE.NumDrunk = GAMEMODE.NumDrunk or 0;
		GAMEMODE.NumDrunk = GAMEMODE.NumDrunk + 1;
		surface.PlaySound('perp/drinking.mp3');
		timer.Simple(60, function ( ) GAMEMODE.NumDrunk = GAMEMODE.NumDrunk - 1; end);
	end
	usermessage.Hook('perp_i_drink', ITEM.DoDrinkInc)
end

GM:RegisterItem(ITEM);