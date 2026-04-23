local RLU = _G["RLU"]

local function CopyDefaults(target, defaults)
    for key, value in pairs(defaults) do
        if type(value) == "table" then
            target[key] = target[key] or {}
            CopyDefaults(target[key], value)
        elseif target[key] == nil then
            target[key] = value
        end
    end
end

function RLU:InitializeDatabase()
    _G["RLUDB"] = _G["RLUDB"] or {}
    CopyDefaults(_G["RLUDB"], self.defaults)
    self.db = _G["RLUDB"]
    self.debugMode = self.db.profile.debugMode == true
end
