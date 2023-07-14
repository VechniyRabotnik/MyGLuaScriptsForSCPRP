--SWEP Info
SWEP.Author = "Вечный Работник"
SWEP.Purpose = ""
SWEP.Instructions = "ЛКМ - Пискнуть"
SWEP.Category       = "Eternal | SWEPS"
SWEP.Base = "weapon_base"
SWEP.PrintName = "SCP 131"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.HoldType = "normal"
SWEP.ViewModelFlip = false
SWEP.ViewModel = ""
SWEP.WorldModel = ""
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBoneMods = {}
SWEP.Primary.ClipSize   = 0
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Ammo = "none"
SWEP.Secondary = false
SWEP.Primary.Delay = 0
SWEP.lastPrimaryUse = 0
SWEP.ReloadCooldown = 20

local a = "weapons/scp/131/pisk.wav" -- Локальная переменная для звука / local sound

local cooldownDuration = 5 -- Длительность cooldown в секундах / CD in sec
local cooldownEndTime = 0 -- Время окончания cooldown / CD end
local drawCooldown = false -- Флаг для отображения cooldown / flag for hud CD

--Initialize
function SWEP:Initialize()
    self:SetHoldType(self.HoldType)
    self:SetWeaponHoldType(self.HoldType)
    
    if CLIENT then
        self:CallOnClient("HideViewModel")
    end
end
-- Deploy
function SWEP:Deploy()
    if CLIENT then
        self:CallOnClient("HideViewModel")
    end
end

function SWEP:HideViewModel()
    if not self:IsValid() then return end
    self.Owner:GetViewModel():SetRenderMode(RENDERMODE_NONE)
end

--Sound
function SWEP:PrimaryAttack()
    if CurTime() < cooldownEndTime then return end
    
    self:EmitSound(a)
    cooldownEndTime = CurTime() + cooldownDuration
    drawCooldown = true
end
--Icons
if CLIENT then
    local pickIcon = Material("materials/scp/131/131.png")
    function drawSCP131HUD()
        local ply = LocalPlayer()
        if not IsValid(ply) or not ply:Alive() then return end

        local wep = ply:GetActiveWeapon()
        if not IsValid(wep) or wep:GetClass() ~= "weapon_131" then return end

        local x = ScrW() / 2 - 30 
        local y = ScrH() - 140
       -- local text = "Писк" -- text here
    
        -- Отрисовка первой иконки / Draw Icon
        surface.SetMaterial(pickIcon)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawTexturedRect(x, y, 55, 55)
        if drawCooldown and CurTime() < cooldownEndTime then
         local cooldownPerc = (cooldownEndTime - CurTime()) / cooldownDuration
         surface.SetDrawColor(20, 20, 20, 230)
         surface.DrawRect(x, y, 55, 55)
         surface.SetDrawColor(255, 255, 255, 130)
         surface.DrawRect(x, y, 55, 55 * cooldownPerc)
        else 
           drawCooldown = false
        end
    end
    hook.Add("HUDPaint", "SCP131HUD", drawSCP131HUD)
end
