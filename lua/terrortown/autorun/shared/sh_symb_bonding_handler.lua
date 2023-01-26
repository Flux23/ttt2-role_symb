if SERVER then
	AddCSLuaFile()
	util.AddNetworkString("TTT2SymbioteEnterBondingUpdate")
end

SYMB_BOND_DATA = {}

if SERVER then
    IN_BOND_MODE = 0
    FAILED_BONDS = 1
    SYMB_BOND_VARS = {}

    function SYMB_BOND_DATA.InitSymbBondDataForPly(ply)
        if not SYMB_BOND_VARS[ply:SteamID64()] then
            print("init " .. tostring(ply:SteamID64()))
            SYMB_BOND_VARS[ply:SteamID64()] = {}
        end
        SYMB_BOND_VARS[ply:SteamID64()][IN_BOND_MODE] = false
        SYMB_BOND_VARS[ply:SteamID64()][FAILED_BONDS] = {}
    end

    function SYMB_BOND_DATA.InSymbBondingMode(ply)
        if not ply or not IsValid(ply) or not ply:IsPlayer() then
            print("not a valid player: " .. tostring(ply:SteamID64()))
            return false
        end
        if not SYMB_BOND_VARS[ply:SteamID64()] then 
            print("player not in table: " .. tostring(ply:SteamID64()))
            return false
        end
        return SYMB_BOND_VARS[ply:SteamID64()][IN_BOND_MODE]
    end
end

function SYMB_BOND_DATA.EnterSymbBondingMode(ply)
    if SERVER then
        if not ply or not IsValid(ply) or not ply:IsPlayer() then
            print("not a valid player: " .. tostring(ply:SteamID64()))
            return false
        end
        if not SYMB_BOND_VARS[ply:SteamID64()] then 
            print("player not in table: " .. tostring(ply:SteamID64()))
            return false
        end
        if SYMB_BOND_DATA.InSymbBondingMode(ply) then 
            print("player already in bonding mode: " .. tostring(ply:SteamID64()))
            return
        end
        
        SYMB_BOND_VARS[ply:SteamID64()][IN_BOND_MODE] = true
        print("player entered bonding mode: " .. tostring(ply:SteamID64()))

        net.Start("TTT2SymbioteEnterBondingUpdate")
        net.Send(ply)
    end
    --Remove their collision box.
    ply:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
    --Invisiblity
    ply:SetNoDraw(true)
    for _, wep in ipairs(ply:GetWeapons()) do
        wep:SetNoDraw(true)
    end
    --Untargetable by AI
    ply:AddFlags(bit.bor(FL_NOTARGET))
end


if CLIENT then

    net.Receive("TTT2SymbioteEnterBondingUpdate", function()
        local client = LocalPlayer()
        
        SYMB_BOND_DATA.EnterSymbBondingMode(client)
    end)
end