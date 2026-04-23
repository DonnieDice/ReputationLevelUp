local RLU = _G["RLU"]

function RLU.CreateAboutPanel(panel)
    local section = RLU.CreateSection(panel, "About")
    section:SetPoint("TOPLEFT", 12, -12)
    section:SetPoint("TOPRIGHT", -12, -12)
    section:SetHeight(220)

    local title = section.content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 0, 0)
    title:SetText("|cff3bbc00Reputation Level Up!|r")

    local subtitle = section.content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
    subtitle:SetWidth(620)
    subtitle:SetJustifyH("LEFT")
    subtitle:SetText(RLU.L and RLU.L.ABOUT_TAGLINE or "Granular reputation rank-up sounds for every faction in World of Warcraft.")

    local version = section.content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    version:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", 0, -12)
    version:SetText("Version: " .. (RLU.version or "v4.0.0"))

    local author = section.content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    author:SetPoint("TOPLEFT", version, "BOTTOMLEFT", 0, -8)
    author:SetText("Author: DonnieDice")

    local note = section.content:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    note:SetPoint("TOPLEFT", author, "BOTTOMLEFT", 0, -12)
    note:SetWidth(620)
    note:SetJustifyH("LEFT")
    note:SetText("This v4 rewrite mirrors BLU's self-contained structure, but the feature focus here is granular per-faction reputation audio with expansion-based organization and a bundled sound pack library.")
end
