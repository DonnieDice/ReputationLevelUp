local RLU = _G["RLU"]

RLU.OptionsTabs = {
    { text = "General", create = function(panel) RLU.CreateGeneralPanel(panel) end },
    { text = "Reputations", create = function(panel) RLU.CreateReputationsPanel(panel) end },
    { text = "About", create = function(panel) RLU.CreateAboutPanel(panel) end },
}
