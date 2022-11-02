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

if SERVER then
	local function ResetSymbioteForServer()
		--TODO
		--COPYCAT_DATA.ResetCCFilesDataForServer()
		--
		--for _, ply in ipairs(player.GetAll()) do
		--	--Don't reset was_copycat at start of round if the player is a copycat, as that will overwrite the logic in GiveRoleLoadout.
		--	if GetRoundState() == ROUND_POST or ply:GetSubRole() ~= ROLE_COPYCAT then
		--		ply.was_copycat = nil
		--	end
		--end
	end
	hook.Add("TTTPrepareRound", "TTTPrepareRoundSymbioteForServer", ResetSymbioteForServer)
	hook.Add("TTTBeginRound", "TTTBeginRoundSymbioteForServer", ResetSymbioteForServer)
	hook.Add("TTTEndRound", "TTTEndRoundSymbioteForServer", ResetSymbioteForServer)
	
	function ROLE:GiveRoleLoadout(ply, isRoleChange)
		--TODO
		----The Copycat should hold onto their files for as long as possible, as they are used for role switches.
		----The Copycat will hold onto this item even if they switch roles, as its primary use is to switch roles at will.
		----  i.e. we do not strip this weapon on ROLE:RemoveRoleLoadout
		--if not ply:HasWeapon("weapon_ttt2_copycat_files") then
		--	ply:GiveEquipmentWeapon("weapon_ttt2_copycat_files")
		--end
		--
		----If the Copycat were to switch to a revival role, die, and then revive, they will lose their copycat files unless we remember them.
		----Upon becoming a Copycat, they will remain a Copycat. Unless their team changes. Or the game ends.
		----In addition, helps differentiate a player who spawned as a Copycat and a player who happens to be on the Copycat's team (ex. Thrall, Bodyguard)
		--ply.was_copycat = true
		--
		----Init Copycat Files here (function does nothing if they've already been initialized)
		----Needed in case someone becomes a Copycat in the middle of a round.
		--COPYCAT_DATA.InitCCFilesForPly(ply)
	end
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
