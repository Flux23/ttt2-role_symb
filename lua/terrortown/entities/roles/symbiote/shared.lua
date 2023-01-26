if SERVER then
	AddCSLuaFile()
end

roles.InitCustomTeam(ROLE.name, {
	icon = "vgui/ttt/dynamic/roles/icon_symb",
	color = Color(255, 0, 255, 255),
})

function ROLE:PreInitialize()
	--Color here is same as the Symbiote's team.
	self.color = Color(255, 0, 255, 255)
	self.abbr = "symb"
	
	self.score.teamKillsMultiplier = -16
	self.score.killsMultiplier = 5
	
	--Whether the role can pick up credits off of bodies.
	self.preventFindCredits = true
	
	self.fallbackTable = {}
	
	--disables team voice chat.
	self.unknownTeam = false
	
	self.defaultTeam = TEAM_SYMBIOTE
	self.defaultEquipment = SPECIAL_EQUIPMENT
	
	--The player's role is not broadcasted to all other players.
	self.isPublicRole = false
	
	--The Symbiote will be treated same as Innocent in terms of being able to inspect and confirm bodies.
	self.isPolicingRole = false
	
	--Traitor like behavior: Able to see missing in action players as well as the haste mode timer.
	self.isOmniscientRole = true
	
	-- ULX ConVars
	self.conVarData = {
		--Proportion of the # of players who will be considered for role selection
		pct = 0.13,
		--Max number of players who can be selected for this role during role selection.
		maximum = 1,
		--Min number of players needed for this role to appear in role selection pool
		minPlayers = 8,
		--Chance that this role is given to a player (sort of kind of)
		random = 30,
		--Whether the role can use traitor buttons or not.
		traitorButton = 0,
		
		--Starting credits
		credits = 0,
		--Role gets 1 credit every time a certain percentage of non-teammates die.
		creditsAwardDeadEnable = 0,
		--Role gets 1 credit for every kill their team makes.
		creditsAwardKillEnable = 0,
		shopFallback = SHOP_DISABLED,
		
		--If enabled, can be avoided by the client during role selection
		togglable = true
	}
end

local function IsInSpecDM(ply)
    if SpecDM and (ply.IsGhost and ply:IsGhost()) then
        return true
    end
    
    return false
end

local function _SymbCanBond(ply)
	return true
end

if SERVER then
	local function ResetSymbioteForServer()
		for _, ply in ipairs(player.GetAll()) do
			SYMB_BOND_DATA.InitSymbBondDataForPly(ply)
		end
	end
	
	function ROLE:GiveRoleLoadout(ply, isRoleChange)
		SYMB_BOND_DATA.InitSymbBondDataForPly(ply)
		print("Giving weapons to symbiote")
		if not ply:HasWeapon("weapon_ttt2_symbstick") then
			ply:GiveEquipmentWeapon("weapon_ttt2_symbstick")
			print("symbiote got a symbstick")
		else
			print("symbiote already has	a symbstick")
		end

	end

	function ROLE:RemoveRoleLoadout(ply, isRoleChange)
		print("Removing weapons from symbiote")
		if ply:HasWeapon("weapon_ttt2_symbstick") then
			ply:StripWeapon("weapon_ttt2_symbstick")
			print("symbiote lost a symbstick")
		else
			print("symbiote already lost a symbstick")
		end
		
	end


	hook.Add("EntityTakeDamage", "EntityTakeDamageSymb", 
		function(target, dmg_info)
			local attacker = dmg_info:GetAttacker()
			
			if IsValid(attacker) and attacker:IsPlayer() and attacker:GetSubRole() == ROLE_SYMBIOTE	and not IsInSpecDM(attacker) then 
				if not _SymbCanBond(attacker) then
					dmg_info:SetDamage(dmg_info:GetDamage() * GetConVar("ttt2_symbiote_spite_multi"):GetFloat())
				else 
					dmg_info:SetDamage(0)
				end
			end
		end)
	hook.Add("TTTPrepareRound", "TTTPrepareRoundSymbioteForServer", ResetSymbioteForServer)
	hook.Add("TTTBeginRound", "TTTBeginRoundSymbioteForServer", ResetSymbioteForServer)
	hook.Add("TTTEndRound", "TTTEndRoundSymbioteForServer", ResetSymbioteForServer)

end
if CLIENT then
	local function ResetSymbioteForClient()
		--TODO
		--for _, ply in ipairs(player.GetAll()) do
		--	ply.was_copycat = nil
		--end
	end
	hook.Add("TTTPrepareRound", "TTTPrepareRoundSymbioteForClient", ResetSymbioteForClient)
	hook.Add("TTTBeginRound", "TTTBeginRoundSymbioteForClient", ResetSymbioteForClient)
	hook.Add("TTTEndRound", "TTTEndRoundSymbioteForClient", ResetSymbioteForClient)
end
