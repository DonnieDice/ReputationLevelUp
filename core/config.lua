local RLU = _G["RLU"]

RLU.defaults = {
    profile = {
        enabled = true,
        showWelcomeMessage = true,
        debugMode = false,
        selectedExpansion = "current",
        soundChannel = "Master",
        defaultSoundId = "rep_default",
        defaultSoundQuality = "med",
        usePerReputationOverrides = true,
        playOnlyOnRankUp = true,
        reputationAssignments = {},
    }
}

RLU.Brand = {
    colors = {
        primary = { 0.23, 0.74, 0.00 },
        accent = { 0.30, 0.85, 0.15 },
        text = { 1.00, 1.00, 1.00 },
        muted = { 0.70, 0.70, 0.70 },
        bg = { 0.06, 0.08, 0.06, 0.96 },
        panel = { 0.09, 0.13, 0.09, 0.96 },
    }
}
