local ply = FindMetaTable("Player")

local teams = {} 


teams[0] = {
	name = "Spectator",
	color = Vector(0.5, 0.5, 0.5)}
	
teams[1] = {
	name = "Mingers",
	color = Vector(1.0, 0.5, 0)}

teams[2] = {
	name = "Builders",
	color = Vector(0, 0.5, 1.0)}
	
function ply:SetupTeam( n )
	if (not teams[n]) then return end

	self:SetTeam( n )
	self:SetPlayerColor( teams[n].color )
	
end