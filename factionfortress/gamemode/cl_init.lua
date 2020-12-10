include("shared.lua")

surface.CreateFont("MinorHUDFont", {
	font = "Arial",
	size = 22,
	weight = 500,
	
})

surface.CreateFont("HealthFont", {
	font = "Arial",
	size = 80,
	weight = 600,
	
})

local hudCivilian = Material("vgui/civilian.png")
local hudScout = Material("vgui/scout.png")
local hudSoldier = Material("vgui/soldier.png")
local hudDemo = Material("vgui/demo.png")
local hudHeavy = Material("vgui/heavy.png")
local hudSniper = Material("vgui/sniper.png")

local ply = LocalPlayer() 

net.Receive( "ply_hasSpawned", function(len, ply)
	hook.Add( "HUDPaint", "HUDPaint_DrawABox", function()
		local client = LocalPlayer()
		local clswep = client:GetActiveWeapon()
		--Borders--
		surface.SetDrawColor(0, 0, 0, 150)
		surface.DrawRect(30, ScrH() - 110, 200, 100)
		surface.DrawRect(ScrW() - 230, ScrH() - 110, 200, 100)
		--Health--
		draw.DrawText( 'HEALTH', "MinorHUDFont", 165, ScrH() - 105, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
		draw.DrawText( client:Health(), "HealthFont", 160, ScrH() - 90, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
		--Ammo--
		if (clswep:IsValid()) then
			draw.DrawText( 'AMMO', "MinorHUDFont", ScrW() - 135, ScrH() - 105, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
			draw.DrawText( clswep:Clip1(), "HealthFont", ScrW() - 135, ScrH() - 90, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
			if (!clswep == 'weapon_crowbar') then 
					draw.DrawText( clswep:Ammo1(), "MinorHUDFont", ScrW() - 80, ScrH() - 90, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
			return end
		end
		-- Class Portrait
		if (client:GetNWInt("playerClass") == 1 ) then
			surface.SetMaterial(hudCivilian)
		elseif (client:GetNWInt("playerClass") == 2 ) then
			surface.SetMaterial(hudScout)
		elseif (client:GetNWInt("playerClass") == 3 ) then
			surface.SetMaterial(hudSoldier)
		elseif (client:GetNWInt("playerClass") == 4 ) then
			surface.SetMaterial(hudDemo)
		elseif (client:GetNWInt("playerClass") == 5 ) then
			surface.SetMaterial(hudHeavy)
		elseif (client:GetNWInt("playerClass") == 6 ) then
			surface.SetMaterial(hudSniper)
		end
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(25, ScrH() - 135, 79, 128)
	end)
end)

function GM:HUDShouldDraw( name )
	local hud = {"CHudHealth", "CHudAmmo", "CHudBattery", "CHudSecondaryAmmo"}
	for k, element in pairs( hud ) do
		if name == element then return false end
	end
	return true
end 

net.Receive( "classmenu", function()
	if (!frame) then
		local frame = vgui.Create( "DFrame" )
		frame:SetSize( 680, 360 )
		frame:SetPos (200, 200 )
		frame:SetVisible ( true )
		frame:MakePopup()
		local x,y = frame:GetSize()
		frame:SetTitle("Choose your class!")
		frame: SetDeleteOnClose( true )
		
		-- scout
		local scoutButton = vgui.Create ("DButton", frame )
		local scoutPortrait  = vgui.Create ("DImage", frame )
		
		scoutPortrait:SetImage("vgui/scout.png")
		scoutPortrait:SetPos(x-670, 75)
		scoutPortrait:SetSize(135, 212)
		
		scoutButton:SetText("Scout")
		scoutButton:SetPos(x-640, 300)
		scoutButton:SetSize( 70, 30 )
		scoutButton.DoClick = function ()
			net.Start( "ply_changetoScout")
			net.SendToServer()
			frame:Close()
		end
		
		-- soldier
		local soldierButton = vgui.Create ("DButton", frame )
		local soldierPortrait  = vgui.Create ("DImage", frame )
		
		soldierPortrait:SetImage("vgui/soldier.png")
		soldierPortrait:SetPos(x-535, 75)
		soldierPortrait:SetSize(135, 212)
		
		soldierButton:SetText("Soldier")
		soldierButton:SetPos(x-500, 300)
		soldierButton:SetSize( 70, 30 )
		soldierButton.DoClick = function ()
			net.Start( "ply_changetoSoldier")
			net.SendToServer()
			frame:Close()
		end
		
		-- demoman
		local demoButton = vgui.Create ("DButton", frame )
		local demoPortrait  = vgui.Create ("DImage", frame )
		
		demoPortrait:SetImage("vgui/demo.png")
		demoPortrait:SetPos(x-385, 75)
		demoPortrait:SetSize(135, 212)
		
		demoButton:SetText("Demolitions")
		demoButton:SetPos(x-350, 300)
		demoButton:SetSize( 70, 30 )
		demoButton.DoClick = function ()
			net.Start( "ply_changetoDemolitions")
			net.SendToServer()
			frame:Close()
		end
		
		-- heavy
		local heavyButton = vgui.Create ("DButton", frame )
		local heavyPortrait  = vgui.Create ("DImage", frame )
		
		heavyPortrait:SetImage("vgui/heavy.png")
		heavyPortrait:SetPos(x-255, 75)
		heavyPortrait:SetSize(135, 212)
		
		heavyButton:SetText("Heavy")
		heavyButton:SetPos(x-220, 300)
		heavyButton:SetSize( 70, 30 )
		heavyButton.DoClick = function ()
			net.Start( "ply_changetoHeavy")
			net.SendToServer()
			frame:Close()
		end
		
		-- heavy
		local sniperButton = vgui.Create ("DButton", frame )
		local sniperPortrait  = vgui.Create ("DImage", frame )
		
		sniperPortrait:SetImage("vgui/sniper.png")
		sniperPortrait:SetPos(x-130, 75)
		sniperPortrait:SetSize(135, 212)
		
		sniperButton:SetText("Sniper")
		sniperButton:SetPos(x-100, 300)
		sniperButton:SetSize( 70, 30 )
		sniperButton.DoClick = function ()
			net.Start( "ply_changetoSniper")
			net.SendToServer()
			frame:Close()
		end
	end
end)



net.Receive( "teammenu", function()



	if (!frame) then
		local frame = vgui.Create( "DFrame" )
		frame:SetSize( 640, 360 )
		frame:SetPos (200, 200 )
		frame:SetVisible ( true )
		frame:MakePopup()
		local x,y = frame:GetSize()
		frame:SetTitle("Choose your team!")
		frame: SetDeleteOnClose( true )
		
		-- MINGERS --
		local redteamButton = vgui.Create ("DButton", frame )
		local redteamLogo  = vgui.Create ("DImage", frame )
		
		redteamLogo:SetImage("vgui/redteam.png")
		redteamLogo:SetPos(x-575, 65)
		redteamLogo:SetSize(264, 228)
		
		redteamButton:SetText("Join MINGERS")
		redteamButton:SetPos(x-490, 300)
		redteamButton:SetSize( 90, 30 )
		redteamButton.DoClick = function ()
			net.Start( "ply_joinMingers")
			net.SendToServer()
			frame:Close()
		end
		
		-- construct.inc --
		local blueteamButton = vgui.Create ("DButton", frame )
		local blueteamLogo  = vgui.Create ("DImage", frame )
		
		blueteamLogo:SetImage("vgui/blueteam.png")
		blueteamLogo:SetPos(x-311, 65)
		blueteamLogo:SetSize(264, 228)
		
		blueteamButton:SetText("Join construct.inc")
		blueteamButton:SetPos(x-230, 300)
		blueteamButton:SetSize( 90, 30 )
		blueteamButton.DoClick = function ()
			net.Start( "ply_joinBuilders")
			net.SendToServer()
			frame:Close()
		end
	end
end)

