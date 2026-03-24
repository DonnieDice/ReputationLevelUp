local RLU = _G["RLU"]

function RLU:GetSetting(key)
    if not self.db or not self.db.profile then
        return nil
    end
    return self.db.profile[key]
end

function RLU:SetSetting(key, value)
    if not self.db or not self.db.profile then
        return
    end
    self.db.profile[key] = value
end

function RLU:ToggleSetting(key)
    local current = self:GetSetting(key)
    self:SetSetting(key, not current)
    return not current
end

function RLU:GetBrandColorHex()
    return "3bbc00"
end

function RLU:FormatQualityLabel(quality)
    local catalog = self:GetSoundCatalog()
    return (catalog and catalog.qualityLabels and catalog.qualityLabels[quality]) or quality or "Medium"
end

function RLU:GetSoundLabel(soundId)
    local sound = self:GetSoundInfo(soundId)
    return sound and sound.label or "Unknown"
end

function RLU:GetFactionDisplayText(faction)
    if not faction then
        return "Unknown Faction"
    end

    return faction.name or ("Faction " .. tostring(faction.id))
end
