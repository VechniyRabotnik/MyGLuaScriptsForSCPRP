AddCSLuaFile()

-- SWEP INFO
SWEP.Author 				= 	"Вечный Работник/Vechniy Rabotnik"
SWEP.Base 				= 	"weapon_base"
SWEP.PrintName 				= 	"Устройство невидимости"
SWEP.Instructions 			= 	""
SWEP.Category 				=	"OrionRP SWEPS"


SWEP.ViewModel 				=	"models/weapons/c_arms.mdl"
SWEP.WorldModel 			= 	""
SWEP.ViewModelFlip			=	false
SWEP.UseHands				= 	true
SWEP.SetHoldType 			=	"melee"

SWEP.Weight 				=	5
SWEP.AutoSwitchTo 			= 	true
SWEP.AutoSwitchFrom 		        = 	false

SWEP.Slot 				=	1
SWEP.SlotPos 				=	0

SWEP.DrawAmmo				=	false
SWEP.DrawCrosshair 			=	true

SWEP.Spawnable 				=	true
SWEP.AdminSpawnable 		        = 	true


SWEP.Primary.ClipSize 		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Ammo 		= "none"
SWEP.Primary.Automatic 		= false


SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Ammo 		= "none"
SWEP.Secondary.Automatic 	= false

SWEP.ShouldDropOnDie 		= false

--font
if CLIENT then
surface.CreateFont( "alfa", {
    font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
    extended = false,
    size = 35,
    weight = 500,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = true,
})
end


local SwingSound = Sound("Weapon_Crowbar.Single")
local HitSound = Sound("Weapon_Crowbar.Melee_Hit")

function SWEP:Initialize()
	self:SetWeaponHoldType("normal")
end

function SWEP:PrimaryAttack()
end

--Invisibility
function SWEP:SecondaryAttack()

    local ply = self:GetOwner()
    
    	if ply:GetNoDraw() == false then
    		ply:SetNoDraw(true)
        	ply:DrawShadow(false)
	    	else
			ply:SetNoDraw(false)
	        ply:DrawShadow(true)
    	end
end
--Notification
hook.Add("HUDPaint", "invisswep.paint", function()
if not IsValid(LocalPlayer():GetActiveWeapon()) then return end
if LocalPlayer():GetActiveWeapon():GetClass() ~= "weapon_specalfa" or not LocalPlayer():GetNoDraw() then return end
    draw.SimpleText( "Сейчас ты невидимый", "alfa", ScrW()/2, ScrH()/1.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end)

function SWEP:OnRemove()
    if SERVER && IsValid(self.Owner) then
        self.Owner:SetNoDraw(false)
        self.Owner:DrawShadow(true)
    end
end

function SWEP:OnDrop()
    if SERVER && IsValid(self.Owner) then
        self.Owner:SetNoDraw(false)
        self.Owner:DrawShadow(true)
    end
end

function SWEP:DrawWorldModel()
	self:DestroyShadow(true)
end
--DrawHud
function SWEP:DrawHUD()
	
	local Keys = {
		['ПКМ'] = {Title = 'Невидимость', text = 'Нажмите для активации' },
	}

	SCPInfo(Keys)

end
