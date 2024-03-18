local function GetRaidersList()
    local raiders = {}
    if IsInRaid() then
        local numRaidMembers = GetNumGroupMembers()
        if numRaidMembers > 0 then
            for i = 1, numRaidMembers do
                local name, _, subgroup, _, class, _, _, _, _, _, classFileName = GetRaidRosterInfo(i)
                print(name)
                table.insert( raiders, {["name"] = name, ["group"] = subgroup, ["class"] = class, ["cashPercent"] = 100})
            end
        end
    else
        print("U r not in raid")
    end
    return raiders
end

--[[
local frame = CreateFrame("FRAME"); -- Need a frame to respond to events
frame:RegisterEvent("ADDON_LOADED"); -- Fired when saved variables are loaded
frame:RegisterEvent("PLAYER_LOGOUT"); -- Fired when about to log out


function frame:OnEvent(event, arg1)
    if event == "ADDON_LOADED" and arg1 == "HaveWeMet" then
    -- Our saved variables are ready at this point. If there are none, both variables will set to nil.
        if HaveWeMetCount == nil then
            HaveWeMetCount = 0; -- This is the first time this addon is loaded; initialize the count to 0.
        end
        if HaveWeMetBool then
            print("Hello again, " .. UnitName("player") .. "!");
        else
            HaveWeMetCount = HaveWeMetCount + 1; -- It's a new character.
            print("Hi; what is your name?");
        end
    elseif event == "PLAYER_LOGOUT" then
        HaveWeMetBool = true; -- We've met; commit it to memory.
    end
end
frame:SetScript("OnEvent", frame.OnEvent);
]]
local membersList

local frame = CreateFrame("FRAME"); -- Need a frame to respond to events
frame:RegisterEvent("ADDON_LOADED"); -- Fired when saved variables are loaded
function frame:OnEvent(event, arg1)
    if event == "ADDON_LOADED" then
        membersList = RaidMembersDB
        print("Data was loaded")
    end
end
frame:SetScript("OnEvent", frame.OnEvent);



local function SaveRaidersList(raiders)
    if raiders then
        RaidMembersDB = raiders
        print("Some stuff was saved")
    else
        print("There is no value in 'reiders list'")
    end
end

SLASH_GRAID1 = "/graid"
SlashCmdList["GRAID"] = function(cmd)
    if cmd == "get" then
        members = GetRaidersList()
        for _, value in pairs(gottenRaidersList) do
            print(value["name"])
        end
    elseif cmd == "save" then
        if members then
            SaveRaidersList(members)
        elseif IsInRaid() then
            members = GetRaidersList()
            SaveRaidersList(members)
        else
            print("Can't save coz u r not in raid group")
        end
    elseif cmd == "load" then
        for index, value in pairs(membersList) do
            print(index .. " " .. value["name"] .. " " .. value["class"])
        end
    else
        print("Доступные команды: /graid show - показать аддон")
    end
end