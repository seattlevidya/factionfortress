GM.Name = "Faction Fortress"

team.SetUp(0, "Spectator", Color(128, 128, 128) )
team.SetUp(1, "Mingers", Color(255, 106, 0) )
team.SetUp(2, "Builders", Color(0, 148, 255) )

function GM:Initialize()

	self.BaseClass.Initialize(self)

end