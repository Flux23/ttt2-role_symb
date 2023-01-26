local L = LANG.GetLanguageTableReference("en")

--GENERAL ROLE LANGUAGE STRINGS
L[SYMBIOTE.name] = "Symbiote"
L["info_popup_" .. SYMBIOTE.name] = [[You are a Symbiote. Bond with another player and assist them in murder.]]
L["body_found_" .. SYMBIOTE.abbr] = "They were a Symbiote."
L["search_role_" .. SYMBIOTE.abbr] = "This person was a Symbiote!"
L["target_" .. SYMBIOTE.name] = "Symbiote"
L["ttt2_desc_" .. SYMBIOTE.name] = [[You are a Symbiote. Bond with another player and assist them in murder.]]

--SYMBIOTE TEAM
L[TEAM_SYMBIOTE] = "Team Symbiotes"
L["hilite_win_" .. TEAM_SYMBIOTE] = "TEAM SYMBIOTE WON"
L["win_" .. TEAM_SYMBIOTE] = "The Symbiote has won!"
L["ev_win_" .. TEAM_SYMBIOTE] = "The Symbiote won the round!"

--SYMBIOTE ROLE STRINGS

--SYMBIOTE ITEMS


--EVENT STRINGS
-- Need to be very specifically worded, due to how the system translates them.
--TODO
--L["title_event_copy_transcribe"] = "A Copycat has transcribed a new role"
--L["desc_event_copy_transcribe"] = "{name1} transcribed {name2}'s role: '{role}'."
--L["tooltip_copy_transcribe_score"] = "Transcribed Roles: {score}"
--L["copy_transcribe_score"] = "Transcribed Roles:"
