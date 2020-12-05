AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("teamsetup.lua")

include("shared.lua")
include("teamsetup.lua")


function Spawn( ply )

	ply:SetupTeam( math.random(0,1) )
	
end

hook.Add( "PlayerSpawn", "playerspawnHook", Spawn )