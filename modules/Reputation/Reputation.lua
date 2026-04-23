local RLU = _G["RLU"]

local Reputation = {}
local REPUTATION_EVENT_ID_UPDATE = "reputation_update"
local REPUTATION_EVENT_ID_ENTERING_WORLD = "reputation_entering_world"
local REPUTATION_SCAN_DELAY = 0.15

RLU:RegisterModule(Reputation, "reputation")

local function GetFactionIdentifier(factionData)
    if factionData and factionData.factionID then
        return tostring(factionData.factionID)
    end

    return factionData and factionData.name or nil
end

local function GetStandingValue(factionData)
    if not factionData then
        return 0
    end

    return factionData.reaction or factionData.currentStanding or 0
end

function Reputation:Init()
    self.cache = {}
    self.pendingScan = false

    RLU:RegisterEvent("UPDATE_FACTION", function(...)
        self:OnUpdateFaction(...)
    end, REPUTATION_EVENT_ID_UPDATE)

    RLU:RegisterEvent("PLAYER_ENTERING_WORLD", function(...)
        self:OnPlayerEnteringWorld(...)
    end, REPUTATION_EVENT_ID_ENTERING_WORLD)

    self:ScanReputation()
    RLU:PrintDebug("Reputation module initialized")
end

function Reputation:OnPlayerEnteringWorld()
    self:ScanReputation()
end

function Reputation:OnUpdateFaction()
    if not (RLU.db and RLU.db.profile and RLU.db.profile.enabled) then
        return
    end

    if self.pendingScan then
        return
    end

    self.pendingScan = true
    C_Timer.After(REPUTATION_SCAN_DELAY, function()
        self.pendingScan = false
        self:CheckReputationChanges()
    end)
end

function Reputation:ScanReputation()
    if not C_Reputation or not C_Reputation.GetNumFactions or not C_Reputation.GetFactionDataByIndex then
        return
    end

    wipe(self.cache)

    for index = 1, C_Reputation.GetNumFactions() do
        local factionData = C_Reputation.GetFactionDataByIndex(index)
        if factionData and not factionData.isHeader and factionData.name then
            local key = GetFactionIdentifier(factionData)
            if key then
                self.cache[key] = {
                    factionID = factionData.factionID,
                    name = factionData.name,
                    standing = GetStandingValue(factionData),
                }
            end
        end
    end
end

function Reputation:CheckReputationChanges()
    if not C_Reputation or not C_Reputation.GetNumFactions or not C_Reputation.GetFactionDataByIndex then
        return
    end

    for index = 1, C_Reputation.GetNumFactions() do
        local factionData = C_Reputation.GetFactionDataByIndex(index)
        if factionData and not factionData.isHeader and factionData.name then
            local key = GetFactionIdentifier(factionData)
            local newStanding = GetStandingValue(factionData)
            local previous = key and self.cache[key]

            if key then
                if previous and newStanding > previous.standing then
                    local assignment = RLU:GetEffectiveAssignment(factionData.factionID or key)
                    self:PlayAssignedSound(factionData, assignment)
                    RLU:PrintDebug("Reputation rank increased for " .. factionData.name)
                end

                self.cache[key] = {
                    factionID = factionData.factionID,
                    name = factionData.name,
                    standing = newStanding,
                }
            end
        end
    end
end

function Reputation:PlayAssignedSound(factionData, assignment)
    assignment = assignment or RLU:GetEffectiveAssignment(factionData and factionData.factionID or 0)
    if assignment.enabled == false then
        return
    end

    local soundFile = RLU:GetSoundFile(assignment.soundId, assignment.quality)
    local channel = RLU:GetSetting("soundChannel") or "Master"
    if soundFile then
        PlaySoundFile(soundFile, channel)
    end
end
