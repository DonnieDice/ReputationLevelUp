local RLU = _G["RLU"]

function RLU:HandleSlashCommand(input)
    input = string.lower((input or ""):gsub("^%s+", ""):gsub("%s+$", ""))

    if input == "" then
        self:OpenOptions()
        return
    end

    if input == "help" then
        self:Print("Commands: |cffffffff/rlu|r, |cffffffff/rlu help|r, |cffffffff/rlu test|r, |cffffffff/rlu debug|r, |cffffffff/rlu welcome|r, |cffffffff/rlu status|r")
        return
    end

    if input == "debug" then
        local enabled = self:ToggleSetting("debugMode")
        self.debugMode = enabled
        if enabled then
            self:Print("Debug mode |cff00ff00enabled|r.")
        else
            self:Print("Debug mode |cffff0000disabled|r.")
        end
        return
    end

    if input == "welcome" then
        local enabled = self:ToggleSetting("showWelcomeMessage")
        if enabled then
            self:Print("Login message |cff00ff00enabled|r.")
        else
            self:Print("Login message |cffff0000disabled|r.")
        end
        return
    end

    if input == "status" then
        self:Print("Selected expansion: |cffffffff" .. (self:GetSelectedExpansion().label or "Unknown") .. "|r")
        self:Print("Default sound: |cffffffff" .. self:GetSoundLabel(self:GetSetting("defaultSoundId")) .. "|r (" .. self:FormatQualityLabel(self:GetSetting("defaultSoundQuality")) .. ")")
        return
    end

    if input == "test" then
        local module = self.Modules and self.Modules.reputation
        if module and module.PlayAssignedSound then
            module:PlayAssignedSound(nil, self:GetEffectiveAssignment(0))
        else
            self:PrintError("Reputation sound module is not available yet.")
        end
        return
    end

    self:OpenOptions()
end

RLU:RegisterSlashCommand({ "rlu", "rep" }, function(msg)
    RLU:HandleSlashCommand(msg)
end)
