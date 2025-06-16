Config = {}
Config.Commands = {}

-- Role commands
Config.Commands.Cop = {
    name = "cop",
    enabled = true
}
Config.Commands.Thief = {
    name = "thief",
    enabled = true
}
Config.Commands.Normal = {
    name = "reset",
    enabled = true
}

-- Game control commands
Config.Commands.StartChase = {
    name = "startChase",
    enabled = true
}
Config.Commands.EndChase = {
    name = "endChase",
    enabled = true
}
Config.Commands.PauseGame = {
    name = "pauseGame",
    enabled = false
}
Config.Commands.UnpauseGame = {
    name = "unpauseGame",
    enabled = false
}

Config.Commands.TogglePause = {
    name = "pause",
    enabled = true
}

-- Setting commands
Config.Commands.NewPingTime = {
    name = "newPingTime",
    enabled = true
}
Config.Commands.NewStartTime = {
    name = "newStartTime", 
    enabled = true
}
Config.Commands.ClearItems = {
    name = "clearitems",
    enabled = true
}

-- Uncomment and set enabled to true if needed
Config.Commands.NumberOfHides = {
    name = "number_of_hides",
    enabled = false
}
