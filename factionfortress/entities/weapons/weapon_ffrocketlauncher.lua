AddCSLuaFile()

SWEP.Author					=	"seattlevidya"
SWEP.Base					=	"weapon_base"
SWEP.PrintName				=	"Rocket Launcher"
SWEP.Instructions			=	""
SWEP.ViewModel				=	"models/weapons/c_rpg.mdl"
SWEP.ViewModelFlip			=	false
SWEP.UseHands				=	true
SWEP.WorldModel				=	"models/weapons/w_357.mdl"
SWEP.SetHoldType			=	"rpg"
SWEP.Weight					=	5

SWEP.AutoSwitchTo			=	true
SWEP.AutoSwitchFrom			=	false

SWEP.Slot					=	1
SWEP.SlotPos				=	0

SWEP.DrawAmmo				=	true
SWEP.DrawCrosshair			=	true

SWEP.Spawnable				=	false
SWEP.AdminSpawnable			=	false

SWEP.Primary.ClipSize		=	4
SWEP.Primary.DefaultClip	=	4
SWEP.Primary.Ammo			=	"RPG_Round"
SWEP.Primary.Automatic		=	true
SWEP.Primary.Recoil			=	0
SWEP.Primary.Damage			=	100
SWEP.Primary.Numshots		=	1
SWEP.Primary.Spread			=	0
SWEP.Primary.Cone			=	0
SWEP.Primary.Delay			=	0.8

SWEP.ShouldDropOnDie		=	false

local ShootSound	=	Sound("Weapon_Mortar.Single")

function SWEP:Initialize()

	self.SetHoldType			=	"rpg"

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
		Bullet.Tracer	=	0
		Bullet.Damage	=	self.Primary.Damage
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