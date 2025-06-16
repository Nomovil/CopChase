role = "Civi"
showTimer = true
addBlipsAllowed = true
showRole = false
showHides = false

-- Register commands only if they are enabled in the config
if Config.Commands.Cop.enabled then
    RegisterCommand(Config.Commands.Cop.name, function(source)
        if role == "Civi" then
            role = "Cop"
            addBlipsAllowed = true
            TriggerServerEvent("PING:registerCop_server")
            showRole = true
            showRoleTxt()
            -- printToPlayer("Registered as Cop")
            giveTaser()
        else
            printToPlayer("Can't be a Cop if you are a Thief")
        end
    end, false)
end

if Config.Commands.Thief.enabled then
    RegisterCommand(Config.Commands.Thief.name, function(source)
        if role == "Civi" then
            role = "Thief"
            TriggerServerEvent("PING:registerThief_server")
            showRole = true
            showRoleTxt()
            -- printToPlayer("You are now Mister X")
        else
            printToPlayer("Can't be a Thief if you are a Cop")
        end
    end, false)
end

if Config.Commands.Normal.enabled then
    RegisterCommand(Config.Commands.Normal.name, function(source)
        TriggerServerEvent("PING:registerCivilian_server", role)
        role = "Civi"
        addBlipsAllowed = false
        showRole = false
        removeTaser()
        for index, blip in ipairs(blips) do
            RemoveBlip(blip)
        end
        for index, blip in ipairs(copblips) do
            RemoveBlip(blip)
        end
    end, false)
end

if Config.Commands.NewPingTime.enabled then
    RegisterCommand(Config.Commands.NewPingTime.name, function(source, args)
        if #args >= 1 then
            TriggerServerEvent("PING:Update_Pingtime", args[1])
            local message = ("Updated Ping Time to  %ss"):format(args[1])
            TriggerServerEvent("PING:deliverMessage", message)
        end
    end, false)
end

if Config.Commands.NewStartTime.enabled then
    RegisterCommand(Config.Commands.NewStartTime.name, function(source, args)
        if #args >= 1 then
            TriggerServerEvent("PING:Update_startTime", args[1])
            local message = ("Updated Start Time to  %ss"):format(args[1])
            TriggerServerEvent("PING:deliverMessage", message)
        end
    end, false)
end

-- NumberOfHides command will only register if enabled in config
if Config.Commands.NumberOfHides and Config.Commands.NumberOfHides.enabled then
    RegisterCommand(Config.Commands.NumberOfHides.name, function(source, args)
        if #args >= 1 then
            TriggerServerEvent("PING:Update_NumberOfHides", args[1])
            local message = ("Updated Number of hides to  %ss"):format(args[1])
            TriggerServerEvent("PING:deliverMessage", message)
        end
    end, false)
end

if Config.Commands.StartChase.enabled then
    RegisterCommand(Config.Commands.StartChase.name, function(source)
        if role == "Cop" or role == "Thief" then
            TriggerServerEvent("PING:startChase")
        else
            printToPlayer("You need to be a Cop or Thief to start a chase")
        end
        -- TriggerServerEvent("PING:startChase")
    end, false)
end

if Config.Commands.EndChase.enabled then
    RegisterCommand(Config.Commands.EndChase.name, function(source)
        -- showTimer = false
        TriggerServerEvent("PING:deliverMessage", "Stopped Chase Manually")
        TriggerServerEvent("PING:ThiefLost")
    end, false)
end

if Config.Commands.ClearItems.enabled then
    RegisterCommand(Config.Commands.ClearItems.name, function()
        itemboxes = {}
    end, false)
end

function giveTaser()
    GiveWeaponToPed(GetPlayerPed(-1), "stun_range", 50, false, true)
end

function removeTaser()
    RemoveWeaponFromPed(GetPlayerPed(-1), "stun_range")
end

function pauseGame()
    print("Pausing Game")
    printToPlayer("Pausing Game")
    TriggerServerEvent("PING:pauseGame")
end

function unpauseGame()
    print("Unpausing Game")
    printToPlayer("Unpausing Game")
    TriggerServerEvent("PING:resumeGame")
end
if Config.Commands.PauseGame.enabled then
    RegisterCommand(Config.Commands.PauseGame.name, pauseGame, false)
end

if Config.Commands.UnpauseGame.enabled then
    RegisterCommand(Config.Commands.UnpauseGame.name, unpauseGame, false)
end

if Config.Commands.TogglePause.enabled then
    RegisterCommand(Config.Commands.TogglePause.name, function()
        print("Timer paused: " .. tostring(Timer.timerPaused))
        if Timer.timerPaused then
            unpauseGame()
        else
            pauseGame()
        end
    end, false)
end