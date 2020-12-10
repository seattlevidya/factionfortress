AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("teamsetup.lua")
AddCSLuaFile("class_config.lua")

include("shared.lua")
include("teamsetup.lua")
include("class_config.lua")


function GM:PlayerInitialSpawn( ply )

	ply:SetupTeam( 0 )
	ply:SetNWInt("playerClass", 1)
	ply:SetNWBool("isSpectator", true)
	net.Start( "ply_hasSpawned" )
	net.Send( ply )
	
end

function GM:PlayerLoadout(ply) 
	local plyClass = PLAYER_CLASSES[ply:GetNWInt("playerClass")]
	
	ply:SetWalkSpeed(plyClass.speed)
	ply:SetRunSpeed(plyClass.speed)
	ply:SetHealth( plyClass.health )
	ply:GiveAmmo( 15, "Buckshot", true )
	ply:GiveAmmo( 15, "RPG_Round", true )
	ply:SetJumpPower( 200 )
	
	for k, v in pairs(plyClass.weapons) do
		ply:Give(v) 
		
	end
	return true
end

function GM:PlayerSetModel(ply)
	local plyClass = PLAYER_CLASSES[ply:GetNWInt("playerClass")]
	
	ply:SetModel(plyClass.model)
end

util.AddNetworkString ( "classmenu" )
util.AddNetworkString ( "ply_changetoScout" )
util.AddNetworkString ( "ply_changetoSoldier" )
util.AddNetworkString ( "ply_changetoDemolitions" )
util.AddNetworkString ( "ply_changetoHeavy" )
util.AddNetworkString ( "teammenu" )
util.AddNetworkString ( "ply_changetoSniper" )
util.AddNetworkString ( "ply_joinBuilders" )
util.AddNetworkString ( "ply_joinMingers" )
util.AddNetworkString ( "ply_hasSpawned" )

function GM:ShowSpare2( ply )
	if (ply:GetNWBool("isSpectator") == false) then
		net.Start( "classmenu" )
		net.Send ( ply )
	end
end

function GM:ShowSpare1( ply )

	net.Start( "teammenu" )
	net.Send ( ply )
	
end

net.Receive( "ply_changetoScout", function(len, ply)
	ply:Kill()
	ply:SetNWInt("playerClass", 2)
	print(ply:Nick() .. " switched to Scout.")

end)

net.Receive( "ply_changetoSoldier", function(len, ply)
	ply:Kill()
	ply:SetNWInt("playerClass", 3)
	print(ply:Nick() .. " switched to Soldier.")

end)

net.Receive( "ply_changetoDemolitions", function(len, ply)
	ply:Kill()
	ply:SetNWInt("playerClass", 4)
	print(ply:Nick() .. " switched to Demolitions.")

end)

net.Receive( "ply_changetoHeavy", function(len, ply)
	ply:Kill()
	ply:SetNWInt("playerClass", 5)
	print(ply:Nick() .. " switched to Heavy Weapons.")

end)

net.Receive( "ply_changetoSniper", function(len, ply)
	ply:Kill()
	ply:SetNWInt("playerClass", 6)
	print(ply:Nick() .. " switched to Sniper.")

end)

net.Receive( "ply_joinMingers", function(len, ply)
	ply:Kill()
	ply:SetupTeam( 1 )
	ply:SetNWBool("isSpectator", false)
	ply:Spawn()
	print(ply:Nick() .. " switched to MINGERS team.")

end)

net.Receive( "ply_joinBuilders", function(len, ply)
	ply:Kill()
	ply:SetupTeam( 2 )
	ply:SetNWBool("isSpectator", false) 
	ply:Spawn()
	print(ply:Nick() .. " switched to Construct.Inc team.")

end)


