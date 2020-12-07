AddCSLuaFile()

SWEP.Author					=	"seattlevidya"
SWEP.Base					=	"weapon_base"
SWEP.PrintName				=	"Minigun"
SWEP.Instructions			=	""
SWEP.ViewModel				=	"models/weapons/c_irifle.mdl"
SWEP.ViewModelFlip			=	false
SWEP.UseHands				=	true
SWEP.WorldModel				=	"models/weapons/w_irifle.mdl"
SWEP.SetHoldType			=	"ar2"
SWEP.Weight					=	2

SWEP.AutoSwitchTo			=	true
SWEP.AutoSwitchFrom			=	false

SWEP.Slot					=	1
SWEP.SlotPos				=	0

SWEP.DrawAmmo				=	true
SWEP.DrawCrosshair			=	true

SWEP.Spawnable				=	false
SWEP.AdminSpawnable			=	false

SWEP.Primary.ClipSize		=	200
SWEP.Primary.DefaultClip	=	200
SWEP.Primary.Ammo			=	"AR2"
SWEP.Primary.Automatic		=	true
SWEP.Primary.Recoil			=	5
SWEP.Primary.Damage			=	5
SWEP.Primary.NumShots		=	1
SWEP.Primary.Spread			=	0.1
SWEP.Primary.Cone			=	0
SWEP.Primary.Delay			=	0.1

SWEP.ShouldDropOnDie		=	false

local ShootSound	=	Sound("Weapon_AR2.Single")

function SWEP:Initialize()

	self.SetHoldType			=	"ar2"

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
		Bullet.Damage	=	self.Primary.Damage + math.random(1, 10) 
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
	local ply = self:GetOwner()
	
end