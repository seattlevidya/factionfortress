include("shared.lua")

net.Receive( "classmenu", function()
	if (!frame) then
		local frame = vgui.Create( "DFrame" )
		frame:SetSize( 640, 360 )
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
		scoutPortrait:SetPos(x-615, 75)
		scoutPortrait:SetSize(135, 212)
		
		scoutButton:SetText("Scout")
		scoutButton:SetPos(x-580, 300)
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
		soldierPortrait:SetPos(x-470, 75)
		soldierPortrait:SetSize(135, 212)
		
		soldierButton:SetText("Soldier")
		soldierButton:SetPos(x-440, 300)
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
		demoPortrait:SetPos(x-325, 75)
		demoPortrait:SetSize(135, 212)
		
		demoButton:SetText("Demolitions")
		demoButton:SetPos(x-290, 300)
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
		heavyPortrait:SetPos(x-180, 75)
		heavyPortrait:SetSize(135, 212)
		
		heavyButton:SetText("Heavy")
		heavyButton:SetPos(x-150, 300)
		heavyButton:SetSize( 70, 30 )
		heavyButton.DoClick = function ()
			net.Start( "ply_changetoHeavy")
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