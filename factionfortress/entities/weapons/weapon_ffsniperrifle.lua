AddCSLuaFile()

SWEP.Author					=	"seattlevidya"
SWEP.Base					=	"weapon_base"
SWEP.PrintName				=	"Sniper Rifle"
SWEP.Instructions			=	""
SWEP.ViewModel				=	"models/weapons/cstrike/c_snip_scout.mdl"
SWEP.ViewModelFlip			=	false
SWEP.UseHands				=	true
SWEP.WorldModel				=	"models/weapons/w_snip_scout.mdl"
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

SWEP.Primary.ClipSize		=	24
SWEP.Primary.DefaultClip	=	24
SWEP.Primary.Ammo			=	"SniperRound"
SWEP.Primary.Automatic		=	false
SWEP.Primary.Recoil			=	6
SWEP.Primary.Damage			=	50
SWEP.Primary.NumShots		=	1
SWEP.Primary.Spread			=	0
SWEP.Primary.Cone			=	0
SWEP.Primary.Delay			=	1.5
SWEP.Secondary.Delay		=	1

SWEP.ShouldDropOnDie		=	false

local ShootSound	=	Sound("Weapon_FlareGun.Single")
local ScopeSound	=	Sound("Weapon_SniperRifle.Special2")


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

function SWEP:SecondaryAttack()
	local ply = self:GetOwner()
	self:EmitSound( ScopeSound )
	
	if(ply:GetNWBool("isScope") == false) then
		ply:SetNWBool("isScope", true)
		ply:SetFOV(15)
		ply:SetWalkSpeed(80)
		ply:SetRunSpeed(80)
		return
	end
	
	if(ply:GetNWBool("isScope") == true) then
		ply:SetNWBool("isScope", false)
		ply:SetFOV(100)
		ply:SetWalkSpeed(250)
		ply:SetRunSpeed(250)
		return
	end
end