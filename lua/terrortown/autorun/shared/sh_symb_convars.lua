--ConVar syncing
CreateConVar("ttt2_symbiote_spite_multi", "2.0", {FCVAR_ARCHIVE, FCVAR_NOTFIY})
--CreateConVar("ttt2_symbiote_role_change_cooldown", "30", {FCVAR_ARCHIVE, FCVAR_NOTFIY})
--CreateConVar("ttt2_symbiote_on_dop_team", "1", {FCVAR_ARCHIVE, FCVAR_NOTFIY})
--
hook.Add("TTTUlxDynamicRCVars", "TTTUlxDynamicSymbioteCVars", function(tbl)
	tbl[ROLE_SYMBIOTE] = tbl[ROLE_SYMBIOTE] or {}
	
    --# How much damage should the symbiote be able to do if everyone REJECTS THEM?
    --  ttt2_symbiote_spite_multi [1.0..5.0] (default: 2.0)
	table.insert(tbl[ROLE_SYMBIOTE], {
		cvar = "ttt2_symbiote_spite_multi",
        slider = true,
		min = 1.0,
		max = 5.0,
		decimal = 1,
		desc = "ttt2_symbiote_spite_multi (Def: 2.0)"
	})

	
end)
--
hook.Add("TTT2SyncGlobals", "AddSymbioteGlobals", function()
	SetGlobalFloat("ttt2_symbiote_spite_multi", GetConVar("ttt2_symbiote_spite_multi"):GetFloat())
end)
--
cvars.AddChangeCallback("ttt2_symbiote_spite_multi", function(name, old, new)
	SetGlobalFloat("ttt2_symbiote_spite_multi", tonumber(new))
end)
