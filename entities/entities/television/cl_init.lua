include("shared.lua")  
require("chrome");

EnableTV = CreateClientConVar("perp_enable_tv", "1", true, false);

local FrameDelay = 1 / 60;

local BrowserMaterial = Material("perp/television")
local BrowserTexture = BrowserMaterial:GetMaterialTexture("$basetexture");
local TextureID = surface.GetTextureID("perp/television")
local TexWidth = BrowserTexture:GetActualWidth()
local TexHeight = BrowserTexture:GetActualHeight()
   
function ENT:Initialize( )	
    self:SetRenderBounds(Vector( -3000, -3000, -3000 ), Vector( 3000, 3000, 3000 ));
end  
   
function ENT:OnRemove( ) 
	if self.HTMLControl and self.HTMLControl:IsValid() then
		self.HTMLControl:Remove( )
		self.HTMLControl = nil
	end
end  

local Scale = 0.0555;
local BrowserNextUpdate = CurTime() + FrameDelay;
   
function ENT:Draw( ) 
	local Dist = LocalPlayer():GetPos():Distance(self:GetPos());
	
	if Dist <= 500 then
		LastSawTele = CurTime();
	elseif Dist <= 1500 then
		local Tr = {};
		Tr.start = LocalPlayer():EyePos();
		Tr.endpos = self:GetPos();
		Tr.filter = {LocalPlayer(), self};
		Tr.mask = MASK_OPAQUE;
		
		if LocalPlayer():InVehicle() then
			table.insert(Tr.filter, LocalPlayer():GetVehicle());
		end
		
		local TRes = util.TraceLine(Tr);
		
		if !TRes.Hit then
			LastSawTele = CurTime();
		end
	end
	
	self.Entity:DrawModel() 
   
	local obbmid = self:OBBCenter()
	local obbmin = self:OBBMins()
	local obbmax = self:OBBMaxs()
	
	local w, h = math.Round((math.abs(obbmax.y - obbmin.y) - 2) / Scale), math.Round((math.abs(obbmax.z - obbmin.z) - 2) / Scale); 
	
	if self:GetNetworkedBool('largetv', false) then
		w, h = math.Round((math.abs(obbmax.y - obbmin.y) - 2) / Scale) * 10, math.Round((math.abs(obbmax.z - obbmin.z) - 2) / Scale) * 10; 
		obbmid.x = obbmid.x + 5
	else
		obbmid.x = obbmid.x + 2.8
	end
	
	obbmid.y = obbmid.y - (w * Scale * .5)
	obbmid.z = obbmid.z + (h * Scale * .5) 
	
	obbmin.z = obbmax.z - 1
	obbmin.y = obbmin.y + 1
	obbmin.x = obbmid.x;
	
	local pos2 = self:LocalToWorld(obbmin)
	local pos = self:LocalToWorld(obbmid)
	local ang = self:GetAngles()  
	
    ang:RotateAroundAxis(ang:Right(), -90); 
    ang:RotateAroundAxis(ang:Up(), 90);
	
	if !chrome then
		cam.Start3D2D(pos, ang, Scale);
			surface.SetDrawColor(0, 0, 0, 255)
			surface.DrawRect(0, 0, w, h)
			draw.SimpleText('Please download the chrome module.', 'ScoreboardHeader', w * .5, h * .45, Color(255, 255, 255, 255), 1, 1);
			draw.SimpleText('Sorry...', 'ScoreboardHeader', w * .5, h * .55, Color(255, 255, 255, 255), 1, 1);
		cam.End3D2D();
	
		return;
	end
	
	if !EnableTV:GetBool() then
		cam.Start3D2D(pos2, ang, Scale);
			surface.SetDrawColor(0, 0, 0, 255)
			surface.DrawRect(0, 0, w, h)
			draw.SimpleText('Televisions disabled.', 'ScoreboardHeader', w * .5, h * .5, Color(255, 255, 255, 255), 1, 1);
		cam.End3D2D();
	
		return;
	end
	
	if !Browser then
		Browser = chrome.NewBrowser(w, h, BrowserTexture, self:GetTable())
	end
	
	if !ShowingTele then return; end
	
	if BrowserNextUpdate <= CurTime() then
		Browser:Update();
		BrowserNextUpdate = CurTime() + FrameDelay;
	end
		
	cam.Start3D2D(pos2, ang, Scale);
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetTexture(TextureID)
		surface.DrawTexturedRect(0, 0, w, h)
	cam.End3D2D();
end

   
function ENT:IsTranslucent( ) 
	return true;
end

function ENT:onBeginNavigation(url)

end

function ENT:onBeginLoading ( url, status )
	BrowserLoading = true;
end

function ENT:onFinishLoading ( )
	BrowserLoading = nil;
	
	if !GoAhead_LoadBuckets or !ShowingTele then return; end
	
	GoAhead_LoadBuckets = nil;
	
	local Protocol = GetGlobalInt('tv_protocol', 1);
	
	if Protocol == 1 then
		timer.Simple(1, TossBuckets);
	end
end

function ENT:onChangeFocus(focus)

end

function TossBuckets ( )
	if !ShowingTele then return; end
	
	Browser:LoadURL("javascript:function postwith (to,p){var myForm = document.createElement('form');myForm.method='post';myForm.action = to;for (var k in p) {var myInput = document.createElement('input');myInput.setAttribute('name', k);myInput.setAttribute('value', p[k]);myForm.appendChild(myInput);}document.body.appendChild(myForm);myForm.submit();document.body.removeChild(myForm);}; postwith('/" .. ShowingTele .. "/popout', {over18:'true',commit:'true'})");
end

LastSawTele = 0; 

function MonitorTele ( )
	if !chrome then
		LocalPlayer():PrintMessage(HUD_PRINTTALK, "You need to download the Chrome module for PERP to watch television.");
		hook.Remove('Think', 'MonitorTele');
		
		return;
	end
	
	if !EnableTV:GetBool() then
		if ShowingTele then
			Browser:LoadURL("http://www.google.com/")
			ShowingTele = nil;
		end
		
		return;
	end
	
	if !Browser then return; end
	
	if LastSawTele + .25 > CurTime() then
		local CurTune = GetGlobalString('tv_link', "master_xx");
		local Protocol = VideoProtocols[GetGlobalInt('tv_protocol', 1)];
		local CurShowing = string.gsub(Protocol, "STREAM", CurTune);
		
		if !ShowingTele or ShowingTele != CurTune then
			Browser:LoadURL(CurShowing)
			ShowingTele = CurTune;
			GoAhead_LoadBuckets = true;
		end
	else
		if ShowingTele then
			Browser:LoadURL("http://www.google.com/")
			ShowingTele = nil;
		end
	end
end
hook.Add('Think', 'MonitorTele', MonitorTele);
