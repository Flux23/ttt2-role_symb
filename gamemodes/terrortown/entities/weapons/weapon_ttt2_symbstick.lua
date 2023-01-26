--GeneralSettings
SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable = false
SWEP.AutoSpawnable = false
SWEP.HoldType = "pistol"
SWEP.AdminSpawnable = true
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Kind = WEAPON_EXTRA


--Serverside
if SERVER then
   AddCSLuaFile()
end

--Clientside
if CLIENT then

   SWEP.PrintName    = "Symbiote Stick"
   --SWEP.Slot         = 7

   SWEP.ViewModelFOV  = 70
   SWEP.ViewModelFlip = false

      SWEP.Icon = "VGUI/ttt/icon_symb"
      SWEP.EquipMenuData = {
      type = "weapon",
      desc = "Connect with people, Make a friend, have some bonding time."
   };
end

--Damage
SWEP.Primary.Delay       = 2
SWEP.Primary.Recoil      = 0
SWEP.Primary.Automatic   = false
SWEP.Primary.NumShots 	 = 0
SWEP.Primary.Damage      = 0
SWEP.Primary.Cone        = 0.0001
SWEP.Primary.Ammo        = "none"
SWEP.Primary.ClipSize    = -1
--SWEP.Primary.ClipMax     = -1
SWEP.Primary.DefaultClip = -1
SWEP.AmmoEnt = ""

SWEP.Secondary.Ammo        = "none"
SWEP.Secondary.ClipSize    = -1
--SWEP.Primary.ClipMax     = -1
SWEP.Secondary.DefaultClip = -1

SWEP.DrawAmmo = false
SWEP.InLoadoutFor = nil
SWEP.IsSilent = false
SWEP.UseHands = true
SWEP.HeadshotMultiplier = 9001
--CanBuy is a table of ROLE_* entries like ROLE_TRAITOR and ROLE_DETECTIVE. If
--a role is in this table, those players can buy this.
--nil means no one can buy this.
SWEP.CanBuy = nil
SWEP.notBuyable = true
-- If LimitedStock is true, you can only buy one per round.
SWEP.LimitedStock = true

-- If AllowDrop is false, players can't manually drop the gun with Q
SWEP.AllowDrop = false

-- If NoSights is true, the weapon won't have ironsights
SWEP.NoSights = true

--Sounds/Models
SWEP.ViewModel          = Model("models/weapons/v_stunbaton.mdl")
SWEP.WorldModel         = Model("models/weapons/w_stunbaton.mdl")
SWEP.Weight = 5

function SWEP:OnRemove()
	if CLIENT and IsValid(self:GetOwner()) and self:GetOwner() == LocalPlayer() and self:GetOwner():Alive() then
		RunConsoleCommand("lastinv")
	end
end


function SWEP:PrimaryAttack()
	if self:GetNextPrimaryFire() <= CurTime() then
		print("primary attack")
        self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
        self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)

		if SERVER then 
			print("doin' server stuff")
			if not SYMB_BOND_DATA.InSymbBondingMode(self:GetOwner()) then
				print("entering bonding mode")
				SYMB_BOND_DATA.EnterSymbBondingMode(self:GetOwner())
			end
		end
	end

end

function SWEP:SecondaryAttack()
	if CLIENT then 
		return
	end

end

if SERVER then
    hook.Add("PlayerSwitchWeapon", "SymbBondingPlayerSwitchWeapon", function(ply, old, new)
        if not IsValid(ply) or not ply:IsPlayer() or not SYMB_BOND_DATA.InSymbBondingMode(ply) then
            return
        end

        --Always force Impostor to use holstered. No attacking from the vents!
        if new:GetClass() ~= "weapon_ttt2_symbstick" then
	        print("In bonding mode, switching back to symbstick")
            --The player will switch to the new weapon at the end of the function regardless.
            --The timer here is a hack to force the player to holstered after the end of this function.
            timer.Simple(0.2, function()
                --Verify the player's existence, in case they are dropped from the Server.
                if IsValid(ply) and ply:IsPlayer() and SYMB_BOND_DATA.InSymbBondingMode(ply) then
                    ply:SelectWeapon("weapon_ttt2_symbstick")
                end
            end)
        end
    end)
end