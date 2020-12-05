local ply = FindMetaTable("Player")

local teams = {} 


teams[0] = {
	name = "Mingers",
	color = Vector(1.0, 0.5, 0),
	weapons = {"weapon_crowbar", "weapon_shotgun"} }
	
teams[1] = {
	name = "Builders",
	color = Vector(0, 0.5, 1.0),
	weapons = {"weapon_crowbar", "weapon_shotgun"} }
	
function ply:SetupTeam( n )
	if (not teams[n]) then return end

	self:SetTeam( n )
	self:SetPlayerColor( teams[n].color )
	self:SetModel( "models/player/group01/male_05.mdl" )
	self:SetWalkSpeed( 300 )
	self:SetRunSpeed( 300 )
	
	self:GiveWeapons ( n )
end

function ply:GiveWeapons ( n )
	for k, weapon in pairs( teams[n].weapons ) do
		self:Give( weapon )
	end
end 