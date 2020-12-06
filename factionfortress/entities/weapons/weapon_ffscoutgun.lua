AddCSLuaFile()

SWEP.Author					=	"seattlevidya"
SWEP.Base					=	"weapon_base"
SWEP.PrintName				=	"Shotgun"
SWEP.Instructions			=	""
SWEP.ViewModel				=	"models/weapons/c_shotgun.mdl"
SWEP.ViewModelFlip			=	false
SWEP.UseHands				=	true
SWEP.WorldModel				=	"models/weapons/w_357.mdl"
SWEP.SetHoldType			=	"shotgun"
SWEP.Weight					=	2

SWEP.AutoSwitchTo			=	true
SWEP.AutoSwitchFrom			=	false

SWEP.Slot					=	1
SWEP.SlotPos				=	0

SWEP.DrawAmmo				=	true
SWEP.DrawCrosshair			=	true

SWEP.Spawnable				=	false
SWEP.AdminSpawnable			=	false

SWEP.Primary.ClipSize		=	6
SWEP.Primary.DefaultClip	=	6
SWEP.Primary.Ammo			=	"Buckshot"
SWEP.Primary.Automatic		=	true
SWEP.Primary.Recoil			=	3
SWEP.Primary.Damage			=	15
SWEP.Primary.Numshots		=	9
SWEP.Primary.Spread			=	0.1
SWEP.Primary.Cone			=	0.085
SWEP.Primary.Delay			=	0.6

SWEP.ShouldDropOnDie		=	false

local ShootSound	=	Sound("Weapon_Shotgun.Double")

function SWEP:Initialize()

	self.SetHoldType			=	"shotgun"

end

function SWEP:PrimaryAttack()

	if( not self:CanPrimaryAttack() ) then
		return
	end
	
	local ply = self:GetOwner()
	
	ply:LagCompensation( true )
	
	local Bullet = {}
		Bullet.Num		=	self.Primary.NumShots
		Bullet.Src		=	ply:GetShootPos()
		Bullet.Dir		=	ply:GetAimVector()
		Bullet.Spread	=	Vector( self.Primary.Spread, self.Primary.Spread, 0 )
		Bullet.Tracer	=	1
		Bullet.Damage	=	self.Primary.Damage + math.random(0, 25)
		Bullet.AmmoType	=	self.Primary.Ammo
	
	self:FireBullets( Bullet )
	self:ShootEffects()
	
	self:EmitSound( ShootSound )
	self.BaseClass.ShootEffects( self )
	self:TakePrimaryAmmo( 1 )
	self:SetNextPrimaryFire(  CurTime() + self.Primary.Delay )
	
	ply:LagCompensation( false )
	
end

function SWEP:CanSecondaryAttack()
	return false
end