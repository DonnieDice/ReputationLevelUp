local RLU = _G["RLU"]

local INIT_EVENT_ID_ADDON = "core_addon_loaded"
local INIT_EVENT_ID_LOGIN = "core_player_login"

function RLU:Initialize()
    if self.isInitialized then
        return
    end

    self:InitializeDatabase()

    for key, module in pairs(self.Modules) do
        if type(module.Init) == "function" and not self.initialized[key] then
            local ok, err = pcall(function()
                module:Init()
            end)

            if ok then
                self.initialized[key] = true
                self.LoadedModules[key] = module
            else
                self:PrintError("Module init failed: " .. tostring(key) .. " - " .. tostring(err))
            end
        end
    end

    self:CreateOptionsPanel()
    self.isInitialized = true
end

RLU:RegisterEvent("ADDON_LOADED", function(_, addon)
    if addon ~= RLU.name then
        return
    end

    RLU:Initialize()
    RLU:UnregisterEvent("ADDON_LOADED", INIT_EVENT_ID_ADDON)
end, INIT_EVENT_ID_ADDON)

RLU:RegisterEvent("PLAYER_LOGIN", function()
    if not RLU.isInitialized then
        RLU:Initialize()
    end
    RLU:ShowWelcomeMessage()
end, INIT_EVENT_ID_LOGIN)
