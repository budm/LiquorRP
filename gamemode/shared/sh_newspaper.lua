local Newest = 0;

for i = 1, 100 do
	local IsThere = file.Exists('../materials/perp/newspaper/' .. i .. '_1.vmt');
	
	if !IsThere then break; else
		local ITEM = {};
		
		local ITEM = {};

		ITEM.ID = 'item_newspaper_' .. i;
		ITEM.Weight = 5;
		ITEM.Cost = 10;
		ITEM.Name = 'Newspaper';
		ITEM.Description = "Edition " .. i .. '\n\nLeft click to read.';

		ITEM.Model = "models/props_junk/garbage_newspaper001a.mdl";
		ITEM.ModelCamPos = Vector(1, -1, 24);
		ITEM.ModelLookAt = Vector(-1, -1, -38);

		
		ITEM.ModelCamPos = Vector(12, 1, 26);
		ITEM.ModelLookAt = Vector(0, -2, 0);
		
		
		ITEM.ModelFOV = 70;


		if SERVER then
			function ITEM.OnUse ( Player )	
				umsg.Start('perp_newspaper', Player)
					umsg.Short(i);
				umsg.End();
				
				return false;
			end
		end

		GM:RegisterItem(ITEM);
		
		Newest = i;
	end
end

if CLIENT then
	function GM.GetNewspaperOpen ( UMsg )
		if GAMEMODE.InventoryPanel then
			GAMEMODE.InventoryPanel:Remove();
		end
		
		GAMEMODE.OpenNewspaper(UMsg:ReadShort() or 0);
	end
	usermessage.Hook('perp_newspaper', GM.GetNewspaperOpen);
end

