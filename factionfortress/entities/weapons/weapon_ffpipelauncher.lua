AddCSLuaFile()

SWEP.Author					=	"seattlevidya"
SWEP.Base					=	"weapon_base"
SWEP.PrintName				=	"Pipe Launcher"
SWEP.Instructions			=	""
SWEP.ViewModel				=	"models/weapons/v_physcannon.mdl"
SWEP.ViewModelFlip			=	false
SWEP.UseHands				=	true
SWEP.WorldModel				=	"models/weapons/w_physics.mdl"
SWEP.SetHoldType			=	"physgun"
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
SWEP.Primary.Delay			=	0.75

SWEP.ShouldDropOnDie		=	false

local ShootSound	=	Sound("Weapon_Mortar.Single")

function SWEP:Initialize()

	self.SetHoldType			=	"physgun"

end

function SWEP:PrimaryAttack()

	if( not self:CanPrimaryAttack() ) then
		return
	end
	
	local ply = self:GetOwner()
	
	ply:LagCompensation( true )

	self:ShootPipe()
	self:EmitSound( ShootSound )
	self.BaseClass.ShootEffects( self )
	self:TakePrimaryAmmo( 1 )
	self:SetNextPrimaryFire(  CurTime() + self.Primary.Delay )
	
	ply:LagCompensation( false )
	
end

function SWEP:CanSecondaryAttack()
	return false
end

function SWEP:ShootPipe()
	local ply = self:GetOwner()
	if (not ply:IsValid() ) then return end
	local ent = ents.Create("npc_grenade_frag")
	
	if ( not ent:IsValid() ) then return end

	local aimvec = ply:GetAimVector()
	local pos = aimvec * 16
	pos:Add( ply:EyePos() )
	
	ent:SetPos( pos )
	ent:SetAngles( ply:EyeAngles() )
	ent:Spawn()
	local phys = ent:GetPhysicsObject()
	if (not phys:IsValid() ) then ent:Remove() return end
	aimvec:Mul( 900 )
	phys:ApplyForceCenter( aimvec )
end 