local ITEM = {};

ITEM.ID = 'drug_shroom';
ITEM.Weight = 10;
ITEM.Cost = 200;
ITEM.Name = '"Magic" Mushrooms';
ITEM.Description = "I wouldn't eat these\nby themselves...\n\nUse to eat.\nDrop to plant.";

ITEM.Model = "models/fungi/sta_skyboxshroom1.mdl";
ITEM.ModelCamPos = Vector(16, 30, 20);
ITEM.ModelLookAt = Vector(0, 0, 14);
ITEM.ModelFOV = 70;

ITEM.StopDropSounds = true;
ITEM.RestrictSelling = true;

if SERVER then

	function ITEM.OnUse ( Player )		
		umsg.Start('perp_do_shrooms', Player);
		umsg.End();
		
		return true;
	end
	
	function ITEM.OnDrop ( Player, Trace )
		if Player:IsGovernmentOfficial() then
			Player:Notify('You cannot do this as a government official!');
			return false;
		end
		
		local NumShroomsAlready = 0;
		for k, v in pairs(ents.FindByClass('shroom')) do
			if v:GetTable().ItemSpawner and v:GetTable().ItemSpawner == Player then
				NumShroomsAlready = NumShroomsAlready + 1;
			end
		end
		
		if NumShroomsAlready >= 20 and Player:GetLevel() > 4 then
			Player:Notify("Your planting too many. Get VIP to plant up to 50 shrooms!.");
			return false;
            elseif NumShroomsAlready >= 50 and Player:GetLevel() < 5              then
            Player:Notify('VIP, Your planting more than your limit             is!.');
            return false;
		end
	
		if Trace.HitWorld and Trace.MatType == MAT_DIRT then
			local Shroom = ents.Create('shroom');
			Shroom:SetPos(Trace.HitPos);
			Shroom:Spawn();
			Shroom:GetTable().ItemSpawner = Player;
			
			return true;
		else
			Player:Notify("You must plant these in soil!");
			
			return false;
		end
	end
	
else

	local TransitionTime = 6;
	local TimeLasting = 60;

	function ITEM.MakeEffects ( )
		if !GAMEMODE.ShroomStart then return; end
		
		local End = GAMEMODE.ShroomStart + TimeLasting + TransitionTime * 2;
		
		if End < CurTime() then return false; end
	
		local shroom_tab = {}
		shroom_tab["$pp_colour_addr"] = 0
		shroom_tab["$pp_colour_addg"] = 0
		shroom_tab["$pp_colour_addb"] = 0
		shroom_tab["$pp_colour_mulr"] = 0
		shroom_tab["$pp_colour_mulg"] = 0
		shroom_tab["$pp_colour_mulb"] = 0
		
		local TimeGone = CurTime() - GAMEMODE.ShroomStart;
		
		if TimeGone < TransitionTime then
			local s = GAMEMODE.ShroomStart;
			local e = s + TransitionTime;
			local c = CurTime();
			local pf = (c-s) / (e-s);
				
			shroom_tab["$pp_colour_colour"] =   1 - pf * 0.37
			shroom_tab["$pp_colour_brightness"] = -pf * 0.15
			shroom_tab["$pp_colour_contrast"] = 1 + pf * 1.57

			DrawColorModify(shroom_tab) 
			DrawSharpen(8.32, 1.03 * pf)
		elseif TimeGone > TransitionTime + TimeLasting then
			local e = End;
			local s = e - TransitionTime;
			local c = CurTime();
			local pf = 1 - (c - s) / (e - s);
				
			shroom_tab["$pp_colour_colour"] = 1 - pf * 0.37
			shroom_tab["$pp_colour_brightness"] = -pf * 0.15
			shroom_tab["$pp_colour_contrast"] = 1 + pf * 1.57
			
			DrawColorModify(shroom_tab) 
			DrawSharpen(8.32, 1.03 * pf)
		else
			shroom_tab["$pp_colour_colour"] = 0.63
			shroom_tab["$pp_colour_brightness"] = -0.15
			shroom_tab["$pp_colour_contrast"] = 2.57

			DrawColorModify(shroom_tab) 
			DrawSharpen(8.32,1.03)
		end
	end
	hook.Add("RenderScreenspaceEffects", "ITEM.MakeEffects_SHROOMS", ITEM.MakeEffects)

	function ITEM.DoShrooms ( )
		surface.PlaySound('perp/eating.mp3');
		
		timer.Simple(math.random(3, 7), function ( ) GAMEMODE.ShroomStart = CurTime() end);
	end
	usermessage.Hook('perp_do_shrooms', ITEM.DoShrooms);
	
end

GM:RegisterItem(ITEM);