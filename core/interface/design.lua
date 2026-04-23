local RLU = _G["RLU"]

local Design = {}
RLU:RegisterModule(Design, "design")
RLU.Design = Design

Design.Colors = {
    Primary = RLU.Brand.colors.primary,
    Accent = RLU.Brand.colors.accent,
    Text = RLU.Brand.colors.text,
    Muted = RLU.Brand.colors.muted,
}

Design.Layout = {
    Padding = 12,
    Spacing = 10,
}

Design.Backdrops = {
    Dark = {
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 1, right = 1, top = 1, bottom = 1 }
    }
}
