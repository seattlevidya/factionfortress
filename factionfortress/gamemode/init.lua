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
	
end

function GM:PlayerLoadout(ply) 
	local plyClass = PLAYER_CLASSES[ply:GetNWInt("playerClass")]
	
	ply:SetWalkSpeed(plyClass.speed)
	ply:SetRunSpeed(plyClass.speed)
	ply:SetHealth( plyClass.health )
	
	for k, v in pairs(plyClass.weapons) do
		ply:Give(v) 
		
	end
	return true
end

function GM:PlayerSetModel(ply)
	local plyClass = PLAYER_CLASSES[ply:GetNWInt("playerClass")]
	
	ply:SetModel(plyClass.model)
end

function GM:PlayerSay ( ply, text )
	if (text == "!join") then
	
		ply:SetupTeam( math.random(1, 2) )
		
		return
	end
	
	if (text == "!scout") then
		ply:Kill()
		ply:SetNWInt("playerClass", 2)
		
	elseif (text == "!soldier") then
		ply:Kill()
		ply:SetNWInt("playerClass", 3)
		
	elseif (text == "!demo") then
		ply:Kill()
		ply:SetNWInt("playerClass", 4)
		
	end
end