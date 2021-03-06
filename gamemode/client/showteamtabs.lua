CreateClientConVar("rp_playermodel", "", true, true)

local DefaultWeapons = {
{name = "GravGun",class = "weapon_physcannon"},
{name = "Physgun",class = "weapon_physgun"},
{name = "Crowbar",class = "weapon_crowbar"},
{name = "Stunstick",class = "weapon_stunstick"},
{name = "BugBait",	class = "weapon_bugbait"},
}

local function MayorOptns()
	local MayCat = vgui.Create("DCollapsibleCategory")
	function MayCat:Paint()
		self:SetBGColor(team.GetColor(LocalPlayer():Team()))
	end
	MayCat:SetLabel("Mayor options")
		local maypanel = vgui.Create("DListLayout")
		maypanel:SetSize(740,170)
			local SearchWarrant = maypanel:Add("DButton")
			SearchWarrant:SetText(LANGUAGE.give_money)
			SearchWarrant.DoClick = function()
				local menu = DermaMenu()
				for _,ply in pairs(player.GetAll()) do
					if not ply.DarkRPVars.warrant and ply ~= LocalPlayer() then
						menu:AddOption(ply:Nick(), function()
							Derma_StringRequest("Warrant", "Why warrant "..ply:Nick().."?", nil,
								function(a)
								LocalPlayer():ConCommand("say /warrant ".. tostring(ply:UserID()).." ".. a)
								end, function() end ) end)
					end
				end
				menu:Open()
			end

			local Warrant = maypanel:Add("DButton")
			Warrant:SetText(LANGUAGE.make_wanted)
			Warrant.DoClick = function()
				local menu = DermaMenu()
				for _,ply in pairs(player.GetAll()) do
					if not ply.DarkRPVars.wanted and ply ~= LocalPlayer() then
						menu:AddOption(ply:Nick(), function() Derma_StringRequest("wanted", "Why make "..ply:Nick().." wanted?", nil,
								function(a)
								LocalPlayer():ConCommand("say /wanted ".. tostring(ply:UserID()).." ".. a)
								end, function() end ) end)
					end
				end
				menu:Open()
			end

			local UnWarrant = maypanel:Add("DButton")
			UnWarrant:SetText(LANGUAGE.make_unwanted)
			UnWarrant.DoClick = function()
				local menu = DermaMenu()
				for _,ply in pairs(player.GetAll()) do
					if ply.DarkRPVars.wanted and ply ~= LocalPlayer() then
						menu:AddOption(ply:Nick(), function() LocalPlayer():ConCommand("say /unwanted " .. tostring(ply:UserID())) end)
					end
				end
				menu:Open()
			end

			local Lockdown = maypanel:Add("DButton")
			Lockdown:SetText(LANGUAGE.initiate_lockdown)
			Lockdown.DoClick = function()
				LocalPlayer():ConCommand("say /lockdown")
			end


			local UnLockdown = maypanel:Add("DButton")
			UnLockdown:SetText(LANGUAGE.stop_lockdown)
			UnLockdown.DoClick = function()
				LocalPlayer():ConCommand("say /unlockdown")
			end

			local Lottery = maypanel:Add("DButton")
			Lottery:SetText(LANGUAGE.start_lottery)
			Lottery.DoClick = function()
				LocalPlayer():ConCommand("say /lottery")
			end

			local GiveLicense = maypanel:Add("DButton")
			GiveLicense:SetText(LANGUAGE.give_license_lookingat)
			GiveLicense.DoClick = function()
				LocalPlayer():ConCommand("say /givelicense")
			end

			local PlaceLaws = maypanel:Add("DButton")
			PlaceLaws:SetText("Place a screen containing the laws.")
			PlaceLaws.DoClick = function()
				LocalPlayer():ConCommand("say /placelaws")
			end

			local AddLaws = maypanel:Add("DButton")
			AddLaws:SetText("Add a law.")
			AddLaws.DoClick = function()
				Derma_StringRequest("Add a law", "Type the law you would like to add here.", "", function(law)
					LocalPlayer():ConCommand("say /addlaw " .. law)
				end)
			end

			local RemLaws = maypanel:Add("DButton")
			RemLaws:SetText("Remove a law.")
			RemLaws.DoClick = function()
				Derma_StringRequest("Remove a law", "Enter the number of the law you would like to remove here.", "", function(num)
					LocalPlayer():ConCommand("say /removelaw " .. num)
				end)
			end
	MayCat:SetContents(maypanel)
	MayCat:SetSkin("DarkRP")
	return MayCat
end

local function CPOptns()
	local CPCat = vgui.Create("DCollapsibleCategory")
	function CPCat:Paint()
		self:SetBGColor(team.GetColor(LocalPlayer():Team()))
	end
	CPCat:SetLabel("Police options")
		local CPpanel = vgui.Create("DListLayout")
		CPpanel:SetSize(740,170)
			local SearchWarrant = CPpanel:Add("DButton")
			SearchWarrant:SetText(LANGUAGE.request_warrant)
			SearchWarrant.DoClick = function()
				local menu = DermaMenu()
				for _,ply in pairs(player.GetAll()) do
					if not ply.DarkRPVars.warrant and ply ~= LocalPlayer() then
						menu:AddOption(ply:Nick(), function()
							Derma_StringRequest("Warrant", "Why warrant "..ply:Nick().."?", nil,
								function(a)
								LocalPlayer():ConCommand("say /warrant ".. tostring(ply:UserID()).." ".. a)
								end, function() end ) end)
					end
				end
				menu:Open()
			end

			local Warrant = CPpanel:Add("DButton")
			Warrant:SetText(LANGUAGE.searchwarrantbutton)
			Warrant.DoClick = function()
				local menu = DermaMenu()
				for _,ply in pairs(player.GetAll()) do
					if not ply.DarkRPVars.wanted and ply ~= LocalPlayer() then
						menu:AddOption(ply:Nick(), function() Derma_StringRequest("wanted", "Why make "..ply:Nick().." wanted?", nil,
								function(a)
									if not IsValid(ply) then return end
									LocalPlayer():ConCommand("say /wanted ".. tostring(ply:UserID()).." ".. a)
								end, function() end ) end)
					end
				end
				menu:Open()
			end

			local UnWarrant = CPpanel:Add("DButton")
			UnWarrant:SetText(LANGUAGE.unwarrantbutton)
			UnWarrant.DoClick = function()
				local menu = DermaMenu()
				for _,ply in pairs(player.GetAll()) do
					if ply.DarkRPVars.wanted and ply ~= LocalPlayer() then
						menu:AddOption(ply:Nick(), function() LocalPlayer():ConCommand("say /unwanted " .. tostring(ply:UserID())) end)
					end
				end
				menu:Open()
			end

			if LocalPlayer():Team() == TEAM_CHIEF or LocalPlayer():IsAdmin() then
				local SetJailPos = CPpanel:Add("DButton")
				SetJailPos:SetText(LANGUAGE.set_jailpos)
				SetJailPos.DoClick = function() LocalPlayer():ConCommand("say /jailpos") end

				local AddJailPos = CPpanel:Add("DButton")
				AddJailPos:SetText(LANGUAGE.add_jailpos)
				AddJailPos.DoClick = function() LocalPlayer():ConCommand("say /addjailpos") end
			end

			local ismayor -- Firstly look if there's a mayor
			local ischief -- Then if there's a chief
			for k,v in pairs(player.GetAll()) do
				if v:Team() == TEAM_MAYOR then
					ismayor = true
					break
				end
			end

			if not ismayor then
				for k,v in pairs(player.GetAll()) do
					if v:Team() == TEAM_CHIEF then
						ischief = true
						break
					end
				end
			end

			local Team = LocalPlayer():Team()
			if not ismayor and (Team == TEAM_CHIEF or (not ischief and Team == TEAM_POLICE)) then
				local GiveLicense = CPpanel:Add("DButton")
				GiveLicense:SetText(LANGUAGE.give_license_lookingat)
				GiveLicense.DoClick = function()
					LocalPlayer():ConCommand("say /givelicense")
				end
			end
	CPCat:SetContents(CPpanel)
	CPCat:SetSkin("DarkRP")
	return CPCat
end


local function CitOptns()
	local CitCat = vgui.Create("DCollapsibleCategory")
	function CitCat:Paint()
		self:SetBGColor(team.GetColor(LocalPlayer():Team()))
	end
	CitCat:SetLabel("Citizen options")
		local Citpanel = vgui.Create("DListLayout")
		Citpanel:SetSize(740,110)

		local joblabel = Citpanel:Add("DLabel")
		joblabel:SetText(LANGUAGE.set_custom_job)

		local jobentry = Citpanel:Add("DTextEntry")
		jobentry:SetValue(LocalPlayer().DarkRPVars.job or "")
		jobentry.OnEnter = function()
			LocalPlayer():ConCommand("say /job " .. tostring(jobentry:GetValue()))
		end
		jobentry.OnLoseFocus = jobentry.OnEnter

	CitCat:SetContents(Citpanel)
	CitCat:SetSkin("DarkRP")
	return CitCat
end


local function MobOptns()
	local MobCat = vgui.Create("DCollapsibleCategory")
	function MobCat:Paint()
		self:SetBGColor(team.GetColor(LocalPlayer():Team()))
	end
	MobCat:SetLabel("Mobboss options")
		local Mobpanel = vgui.Create("DListLayout")
		Mobpanel:SetSize(740,110)

		local agendalabel = Mobpanel:Add("DLabel")
		agendalabel:SetText(LANGUAGE.set_agenda)

		local agendaentry = Mobpanel:Add("DTextEntry")
		agendaentry:SetValue(LocalPlayer().DarkRPVars.agenda or "")
		agendaentry.OnEnter = function()
			LocalPlayer():ConCommand("say /agenda " .. tostring(agendaentry:GetValue()))
		end
		agendaentry.OnLoseFocus = agendaentry.OnEnter

	MobCat:SetContents(Mobpanel)
	MobCat:SetSkin("DarkRP")
	return MobCat
end

function GM:MoneyTab()
	local FirstTabPanel = vgui.Create("DPanelList")
	FirstTabPanel:EnableVerticalScrollbar( true )
		function FirstTabPanel:Update()
			self:Clear(true)
			local MoneyCat = vgui.Create("DCollapsibleCategory")
			MoneyCat:SetLabel("Money")
				local MoneyPanel = vgui.Create("DListLayout")
				MoneyPanel:SetSize(740,60)

				local GiveMoneyButton = MoneyPanel:Add("DButton")
				GiveMoneyButton:SetText(LANGUAGE.give_money)
				GiveMoneyButton.DoClick = function()
					Derma_StringRequest("Amount of money", "How much money do you want to give?", "", function(a) LocalPlayer():ConCommand("say /give " .. tostring(a)) end)
				end

				local SpawnMoneyButton = MoneyPanel:Add("DButton")
				SpawnMoneyButton:SetText(LANGUAGE.drop_money)
				SpawnMoneyButton.DoClick = function()
					Derma_StringRequest("Amount of money", "How much money do you want to drop?", "", function(a) LocalPlayer():ConCommand("say /dropmoney " .. tostring(a)) end)
				end

			MoneyCat:SetContents(MoneyPanel)
			MoneyCat:SetSkin("DarkRP")


			local Commands = vgui.Create("DCollapsibleCategory")
			Commands:SetLabel("Actions")
				local ActionsPanel = vgui.Create("DListLayout")
				ActionsPanel:SetSize(740,210)
					local rpnamelabel = ActionsPanel:Add("DLabel")
					rpnamelabel:SetText(LANGUAGE.change_name)

					local rpnameTextbox = ActionsPanel:Add("DTextEntry")
					rpnameTextbox:SetText(LocalPlayer():Nick())
					rpnameTextbox.OnEnter = function() LocalPlayer():ConCommand("say /rpname " .. tostring(rpnameTextbox:GetValue())) end
					rpnameTextbox.OnLoseFocus = function() LocalPlayer():ConCommand("say /rpname " .. tostring(rpnameTextbox:GetValue())) end

					local sleep = ActionsPanel:Add("DButton")
					sleep:SetText(LANGUAGE.go_to_sleep)
					sleep.DoClick = function()
						LocalPlayer():ConCommand("say /sleep")
					end
					local Drop = ActionsPanel:Add("DButton")
					Drop:SetText(LANGUAGE.drop_weapon)
					Drop.DoClick = function() LocalPlayer():ConCommand("say /drop") end
					local health = MoneyPanel:Add("DButton")
					health:SetText(string.format(LANGUAGE.buy_health, tostring(GAMEMODE.Config.healthcost)))
					health.DoClick = function() LocalPlayer():ConCommand("say /Buyhealth") end

				if LocalPlayer():Team() ~= TEAM_MAYOR then
					local RequestLicense = ActionsPanel:Add("DButton")
						RequestLicense:SetText(LANGUAGE.request_gunlicense)
						RequestLicense.DoClick = function() LocalPlayer():ConCommand("say /requestlicense") end
				end

				local Demote = ActionsPanel:Add("DButton")
				Demote:SetText(LANGUAGE.demote_player_menu)
				Demote.DoClick = function()
					local menu = DermaMenu()
					for _,ply in pairs(player.GetAll()) do
						if ply ~= LocalPlayer() then
							menu:AddOption(ply:Nick(), function()
								Derma_StringRequest("Demote reason", "Why would you demote "..ply:Nick().."?", nil,
									function(a)
									LocalPlayer():ConCommand("say /demote ".. tostring(ply:UserID()).." ".. a)
									end, function() end )
							end)
						end
					end
					menu:Open()
				end

				local UnOwnAllDoors = ActionsPanel:Add("DButton")
						UnOwnAllDoors:SetText("Sell all of your doors")
						UnOwnAllDoors.DoClick = function() LocalPlayer():ConCommand("say /unownalldoors") end
			Commands:SetContents(ActionsPanel)
		FirstTabPanel:AddItem(MoneyCat)
		Commands:SetSkin("DarkRP")
		FirstTabPanel:AddItem(Commands)

		if LocalPlayer():Team() == TEAM_MAYOR then
			FirstTabPanel:AddItem(MayorOptns())
		elseif LocalPlayer():Team() == TEAM_CITIZEN then
			FirstTabPanel:AddItem(CitOptns())
		elseif LocalPlayer():Team() == TEAM_POLICE or LocalPlayer():Team() == TEAM_CHIEF then
			FirstTabPanel:AddItem(CPOptns())
		elseif LocalPlayer():Team() == TEAM_MOB then
			FirstTabPanel:AddItem(MobOptns())
		end
	end
	FirstTabPanel:Update()
	return FirstTabPanel
end

function GM:JobsTab()
	local hordiv = vgui.Create("DHorizontalDivider")
	hordiv:SetLeftWidth(390)
	function hordiv.m_DragBar:OnMousePressed() end
	hordiv.m_DragBar:SetCursor("none")
	local Panel
	local Information
	function hordiv:Update()
		if Panel and Panel:IsValid() then
			Panel:Remove()
		end
		Panel = vgui.Create("DPanelList")
		Panel:SetSize(390, 540)
		Panel:EnableHorizontal( true )
		Panel:EnableVerticalScrollbar( true )
		Panel:SetSkin("DarkRP")


		local Info = {}
		local model
		local modelpanel
		local function UpdateInfo(a)
			if Information and Information:IsValid() then
				Information:Remove()
			end
			Information = vgui.Create("DPanelList")
			Information:SetPos(378,0)
			Information:SetSize(370, 540)
			Information:SetSpacing(10)
			Information:EnableHorizontal( false )
			Information:EnableVerticalScrollbar( true )
			Information:SetSkin("DarkRP")
			function Information:Rebuild() -- YES IM OVERRIDING IT AND CHANGING ONLY ONE LINE BUT I HAVE A FUCKING GOOD REASON TO DO IT!
				local Offset = 0
				if ( self.Horizontal ) then
					local x, y = self.Padding, self.Padding;
					for k, panel in pairs( self.Items ) do
						local w = panel:GetWide()
						local h = panel:GetTall()
						if ( x + w  > self:GetWide() ) then
							x = self.Padding
							y = y + h + self.Spacing
						end
						panel:SetPos( x, y )
						x = x + w + self.Spacing
						Offset = y + h + self.Spacing
					end
				else
					for k, panel in pairs( self.Items ) do
						if not panel:IsValid() then return end
						panel:SetSize( self:GetCanvas():GetWide() - self.Padding * 2, panel:GetTall() )
						panel:SetPos( self.Padding, self.Padding + Offset )
						panel:InvalidateLayout( true )
						Offset = Offset + panel:GetTall() + self.Spacing
					end
					Offset = Offset + self.Padding
				end
				self:GetCanvas():SetTall( Offset + (self.Padding) - self.Spacing )
			end

			if type(Info) == "table" and #Info > 0 then
				for k,v in ipairs(Info) do
					local label = vgui.Create("DLabel")
					label:SetText(v)
					label:SizeToContents()
					if label:IsValid() then
						Information:AddItem(label)
					end
				end
			end

			if model and type(model) == "string" and a ~= false then
				modelpanel = vgui.Create("DModelPanel")
				modelpanel:SetModel(model)
				modelpanel:SetSize(90,230)
				modelpanel:SetAnimated(true)
				modelpanel:SetFOV(90)
				modelpanel:SetAnimSpeed(1)
				if modelpanel:IsValid() then
					Information:AddItem(modelpanel)
				end
			end
			hordiv:SetLeft(Panel)
			hordiv:SetRight(Information)
		end
		UpdateInfo()

		local function AddIcon(Model, name, description, Weapons, command, special, specialcommand)
			local icon = vgui.Create("SpawnIcon")
			local IconModel = Model
			if type(Model) == "table" then
				IconModel = Model[math.random(#Model)]
			end
			icon:SetModel(IconModel)

			icon:SetSize(128, 128)
			icon:SetToolTip()
			icon.OnCursorEntered = function()
				icon.PaintOverOld = icon.PaintOver
				icon.PaintOver = icon.PaintOverHovered
				Info[1] = LANGUAGE.job_name .. name
				Info[2] = LANGUAGE.job_description .. description
				Info[3] = LANGUAGE.job_weapons .. Weapons
				model = IconModel
				UpdateInfo()
			end
			icon.OnCursorExited = function()
				if ( icon.PaintOver == icon.PaintOverHovered ) then
					icon.PaintOver = icon.PaintOverOld
				end
				Info = {}
				if modelpanel and modelpanel:IsValid() and icon:IsValid() then
					modelpanel:Remove()
					UpdateInfo(false)
				end
			end

			icon.DoClick = function()
				local function DoChatCommand(frame)
					if special then
						local menu = DermaMenu()
						menu:AddOption("Vote", function() LocalPlayer():ConCommand("say "..command) frame:Close() end)
						menu:AddOption("Do not vote", function() LocalPlayer():ConCommand("say " .. specialcommand) frame:Close() end)
						menu:Open()
					else
						LocalPlayer():ConCommand("say " .. command)
						frame:Close()
					end
				end

				if type(Model) == "table" and #Model > 0 then
					hordiv:GetParent():GetParent():Close()
					local frame = vgui.Create("DFrame")
					frame:SetTitle("Choose model")
					frame:SetVisible(true)
					frame:MakePopup()

					local levels = 1
					local IconsPerLevel = math.floor(ScrW()/64)

					while #Model * (64/levels) > ScrW() do
						levels = levels + 1
					end
					frame:SetSize(math.Min(#Model * 64, IconsPerLevel*64), math.Min(90+(64*(levels-1)), ScrH()))
					frame:Center()

					local CurLevel = 1
					for k,v in pairs(Model) do
						local icon = vgui.Create("SpawnIcon", frame)
						if (k-IconsPerLevel*(CurLevel-1)) > IconsPerLevel then
							CurLevel = CurLevel + 1
						end
						icon:SetPos((k-1-(CurLevel-1)*IconsPerLevel) * 64, 25+(64*(CurLevel-1)))
						icon:SetModel(v)
						icon:SetSize(64, 64)
						icon:SetToolTip()
						icon.DoClick = function()
							RunConsoleCommand("rp_playermodel", v)
							RunConsoleCommand("_rp_ChosenModel", v)
							DoChatCommand(frame)
						end
					end
				else
					DoChatCommand(hordiv:GetParent():GetParent())
				end
			end

			if icon:IsValid() then
				Panel:AddItem(icon)
			end
		end

		for k,v in ipairs(RPExtraTeams) do
			if LocalPlayer():Team() ~= k then
				local nodude = true
				if v.admin == 1 and not LocalPlayer():IsAdmin() then
					nodude = false
				end
				if v.admin > 1 and not LocalPlayer():IsSuperAdmin() then
					nodude = false
				end
				if v.customCheck and not v.customCheck(LocalPlayer()) then
					nodude = false
				end

				if (type(v.NeedToChangeFrom) == "number" and LocalPlayer():Team() ~= v.NeedToChangeFrom) or (type(v.NeedToChangeFrom) == "table" and not table.HasValue(v.NeedToChangeFrom, LocalPlayer():Team())) then
					nodude = false
				end

				if nodude then
					local weps = "no extra weapons"
					if #v.weapons > 0 then
						weps = table.concat(v.weapons, "\n")
					end
					if v.vote then
						local condition = ((v.admin == 0 and LocalPlayer():IsAdmin()) or (v.admin == 1 and LocalPlayer():IsSuperAdmin()) or LocalPlayer().DarkRPVars["Priv"..v.command])
						if not v.model or not v.name or not v.description or not v.command then chat.AddText(Color(255,0,0,255), "Incorrect team! Fix your shared.lua!") return end
						AddIcon(v.model, v.name, v.description, weps, "/vote"..v.command, condition, "/"..v.command)
					else
						if not v.model or not v.name or not v.description or not v.command then chat.AddText(Color(255,0,0,255), "Incorrect team! Fix your shared.lua!") return end
						AddIcon(v.model, v.name, v.description, weps, "/"..v.command)
					end
				end
			end
		end
	end
	hordiv:Update()
	return hordiv
end

function GM:EntitiesTab()
	local EntitiesPanel = vgui.Create("DPanelList")
	EntitiesPanel:EnableVerticalScrollbar( true )
		function EntitiesPanel:Update()
			self:Clear(true)				
			local EntCat = vgui.Create("DCollapsibleCategory")
			EntCat:SetLabel("Entities")
				local EntPanel = vgui.Create("DPanelList")
				EntPanel:SetSize(470, 200)
				EntPanel:SetAutoSize(true)
				EntPanel:SetSpacing(1)
				EntPanel:EnableHorizontal(true)
				EntPanel:EnableVerticalScrollbar(true)
					local function AddEntIcon(Model, description, command)
						local icon = vgui.Create("SpawnIcon")
						icon:InvalidateLayout( true )
						icon:SetModel(Model)
						icon:SetSize(64, 64)
						icon:SetToolTip(description)
						icon.DoClick = function() LocalPlayer():ConCommand("say "..command) end
						EntPanel:AddItem(icon)
					end

					for k,v in pairs(DarkRPEntities) do
						if not v.allowed or (type(v.allowed) == "table" and table.HasValue(v.allowed, LocalPlayer():Team()))
							and (not v.customCheck or (v.customCheck and v.customCheck(LocalPlayer()))) then
							local cmdname = string.gsub(v.ent, " ", "_")

							AddEntIcon(v.model, "Buy a " .. v.name .." " .. CUR .. v.price, v.cmd)
						end
					end

					if FoodItems and (GAMEMODE.Config.foodspawn or LocalPlayer():Team() == TEAM_COOK) and (GAMEMODE.Config.hungermod or LocalPlayer():Team() == TEAM_COOK) then
						for k,v in pairs(FoodItems) do
							AddEntIcon(v.model, string.format(LANGUAGE.buy_a, "a "..k, "a few bucks"), "/buyfood "..k)
						end
					end
					for k,v in pairs(CustomShipments) do
						if not v.noship and table.HasValue(v.allowed, LocalPlayer():Team())
							and (not v.customCheck or (v.customCheck and v.customCheck(LocalPlayer()))) then
							AddEntIcon(v.model, string.format(LANGUAGE.buy_a, "a "..v.name .." shipment", CUR .. tostring(v.price)), "/buyshipment "..v.name)
						end
					end
			EntCat:SetContents(EntPanel)
			EntCat:SetSkin("DarkRP")
			self:AddItem(EntCat)
			----------------------------------------------------
			--  --Prop Store Menu--   --Under Construction--  --
			----------------------------------------------------
			local PropCat = vgui.Create("DCollapsibleCategory")
			PropCat:SetLabel("Props:")
				local EntPanel = vgui.Create("DPanelList")
				EntPanel:SetSize(470, 200)
				EntPanel:SetAutoSize(true)
				EntPanel:SetSpacing(1)
				EntPanel:EnableHorizontal(true)
				EntPanel:EnableVerticalScrollbar(true)
					local function AddEntIcon(Model, description, command)
						local icon = vgui.Create("SpawnIcon")
						icon:InvalidateLayout( true )
						icon:SetModel(Model)
						icon:SetSize(64, 64)
						icon:SetToolTip(description)
						icon.DoClick = function() LocalPlayer():ConCommand("say "..command) end
						EntPanel:AddItem(icon)
					end
			PropCat:SetContents(EntPanel)
			PropCat:SetSkin("DarkRP")
			self:AddItem(PropCat)

			if #CustomVehicles <= 0 then return end
			local VehicleCat = vgui.Create("DCollapsibleCategory")
			VehicleCat:SetLabel("Vehicles")
				local VehiclePanel = vgui.Create("DPanelList")
				VehiclePanel:SetSize(470, 200)
				VehiclePanel:SetAutoSize(true)
				VehiclePanel:SetSpacing(1)
				VehiclePanel:EnableHorizontal(true)
				VehiclePanel:EnableVerticalScrollbar(true)
				local function AddVehicleIcon(Model, skin, description, command)
					local icon = vgui.Create("SpawnIcon")
					icon:InvalidateLayout( true )
					icon:SetModel(Model)
					icon:SetSkin(skin)
					icon:SetSize(64, 64)
					icon:SetToolTip(description)
					icon.DoClick = function() LocalPlayer():ConCommand("say "..command) end
					VehiclePanel:AddItem(icon)
				end

				local founds = 0
				for k,v in pairs(CustomVehicles) do
					if not v.allowed or table.HasValue(v.allowed, LocalPlayer():Team()) then
						local Skin = (list.Get("Vehicles")[v.name] and list.Get("Vehicles")[v.name].KeyValues and list.Get("Vehicles")[v.name].KeyValues.Skin) or "0"
						AddVehicleIcon(v.model or "models/buggy.mdl", Skin, "Buy a "..v.name.." for "..CUR..v.price, "/buyvehicle "..v.name)
						founds = founds + 1
					end
				end
			if founds ~= 0 then
				VehicleCat:SetContents(VehiclePanel)
				VehicleCat:SetSkin("DarkRP")
				self:AddItem(VehicleCat)
			else
				VehiclePanel:Remove()
				VehicleCat:Remove()
			end
		end
	EntitiesPanel:SetSkin("DarkRP")
	EntitiesPanel:Update()
	return EntitiesPanel
end

function GM:RPINVTab()
	local RPINVTABpanel = vgui.Create("DIconLayout")
	RPINVTABpanel:SetSize(750, 550)
	function RPINVTABpanel:Update()
		self:Clear(true)

		backgrndcat = RPINVTABpanel:Add("DCollapsibleCategory")
		backgrndcat:SetSize(230, 230)
		if not self.Owner:GetTable().Pocket or #self.Owner:GetTable().Pocket <= 0 then
			backgrndcat.Label1 = vgui.Create("Label", backgrndcat)
			backgrndcat.Label1:SetPos(50,50)
			backgrndcat.Label1:SetText("Your Inventory is Empty....")
			backgrndcat.Label1:SizeToContents()
		end
		
	for k,v in pairs(self.Owner:GetTable().Pocket) do
		if not IsValid(v) then
			self.Owner:GetTable().Pocket[k] = nil
			self.Owner:GetTable().Pocket = table.ClearKeys(self.Owner:GetTable().Pocket)
			if #self.Owner:GetTable().Pocket <= 0 then -- Recheck after the entities have been validated.
				backgrndcat.Label1:SetText("Your Inventory is Empty....")
				return
			end
		end
	end
	
	if CLIENT then
	local function StorePocketItem(um)
		LocalPlayer():GetTable().Pocket = LocalPlayer():GetTable().Pocket or {}

		local ent = Entity(um:ReadShort())
		if IsValid(ent) and not table.HasValue(LocalPlayer():GetTable().Pocket, ent) then
			table.insert(LocalPlayer():GetTable().Pocket, ent)
		end
	end
	usermessage.Hook("Pocket_AddItem", StorePocketItem)

	local function RemovePocketItem(um)
		LocalPlayer():GetTable().Pocket = LocalPlayer():GetTable().Pocket or {}

		local ent = Entity(um:ReadShort())
		for k,v in pairs(LocalPlayer():GetTable().Pocket) do
			if v == ent then LocalPlayer():GetTable().Pocket[k] = nil end
		end
	end
	usermessage.Hook("Pocket_RemoveItem", RemovePocketItem)

	local frame
	local function PocketMenu()
		if frame and frame:IsValid() and frame:IsVisible() then return end
		if LocalPlayer():GetActiveWeapon():GetClass() ~= "pocket" then return end
		if not LocalPlayer():GetTable().Pocket then LocalPlayer():GetTable().Pocket = {} return end
		for k,v in pairs(LocalPlayer():GetTable().Pocket) do if not IsValid(v) then table.remove(LocalPlayer():GetTable().Pocket, k) end end
		if #LocalPlayer():GetTable().Pocket <= 0 then return end
		LocalPlayer():GetTable().Pocket = table.ClearKeys(LocalPlayer():GetTable().Pocket)
		frame = vgui.Create("DFrame")
		frame:SetTitle("Drop item")
		frame:SetVisible( true )
		frame:MakePopup( )

		local items = LocalPlayer():GetTable().Pocket
		local function Reload()
			frame:SetSize( #items * 64, 90 )
			frame:Center()
			for k,v in pairs(items) do
				if not IsValid(v) then
					items[k] = nil
					for a,b in pairs(LocalPlayer().Pocket) do
						if b == v or not IsValid(b) then
							LocalPlayer():GetTable().Pocket[a] = nil
						end
					end
					items = table.ClearKeys(items)
					frame:Close()
					PocketMenu()
					break
				end
				local icon = vgui.Create("SpawnIcon", frame)
				icon:SetPos((k-1) * 64, 25)
				icon:SetModel(v:GetModel())
				icon:SetSize(64, 64)
				icon:SetToolTip()
				icon.DoClick = function()
					icon:SetToolTip()
					RunConsoleCommand("_RPSpawnPocketItem", v:EntIndex())
					items[k] = nil
					for a,b in pairs(LocalPlayer().Pocket) do
						if b == v then
							LocalPlayer():GetTable().Pocket[a] = nil
						end
					end
					if #items == 0 then
						frame:Close()
						return
					end
					items = table.ClearKeys(items)
					Reload()
					LocalPlayer():GetActiveWeapon():SetWeaponHoldType("pistol")
					timer.Simple(0.2, function() if LocalPlayer():GetActiveWeapon():IsValid() then LocalPlayer():GetActiveWeapon():SetWeaponHoldType("normal") end end)
				end
			end
		end
		Reload()
		frame:SetSkin("DarkRP")
	end
	usermessage.Hook("StartPocketMenu", PocketMenu)
elseif SERVER then
	local function Spawn(ply, cmd, args)
		if ply:GetActiveWeapon():GetClass() ~= "pocket" then
			return
		end
		if ply:GetTable().Pocket and IsValid(Entity(tonumber(args[1]))) then
			local ent = Entity(tonumber(args[1]))
			if not table.HasValue(ply.Pocket, ent) then return end

			for k,v in pairs(ply:GetTable().Pocket) do
				if v == ent then
					ply:GetTable().Pocket[k] = nil
				end
			end
			ply:GetTable().Pocket = table.ClearKeys(ply:GetTable().Pocket)

			ply:GetActiveWeapon():SetWeaponHoldType("pistol")
			timer.Simple(0.2, function() if ply:GetActiveWeapon():IsValid() then ply:GetActiveWeapon():SetWeaponHoldType("normal") end end)

			local trace = {}
			trace.start = ply:EyePos()
			trace.endpos = trace.start + ply:GetAimVector() * 85
			trace.filter = ply
			local tr = util.TraceLine(trace)
			ent:SetMoveType(MOVETYPE_VPHYSICS)
			ent:SetNoDraw(false)
			ent:SetCollisionGroup(4)
			ent:SetPos(tr.HitPos)
			ent:SetSolid(SOLID_VPHYSICS)
			ent.PhysgunPickup = nil
			local phys = ent:GetPhysicsObject()
			if phys:IsValid() then
				phys:EnableCollisions(true)
				phys:EnableMotion(true)
				phys:Wake()
			end
			ent.PlayerUse = false
		end

	end
end
end	
	RPINVTABpanel:SetSkin("DarkRP")
	return RPINVTABpanel
end

function GM:HELPTab()
	local HELPTabpanel = vgui.Create("DIconLayout")
	HELPTabpanel:SetSize(750, 550)
	function HELPTabpanel:Update()
		self:Clear(true)

		backgrndcat = HELPTabpanel:Add("DCollapsibleCategory")
		backgrndcat:SetSize(230, 330)
		
		backgrndcat.Label1 = vgui.Create("Label", backgrndcat)
		backgrndcat.Label1:SetPos(50,50)
		backgrndcat.Label1:SetText("Lua is alive!")
		backgrndcat.Label1:SizeToContents()
	end
	HELPTabpanel:SetSkin("DarkRP")
	return HELPTabpanel
end
