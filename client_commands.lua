role = "Civi"
showTimer = true
addBlipsAllowed = true

RegisterCommand("cop",function(source)
    if role == "Civi" then
        role = "Cop"
        addBlipsAllowed = true
        TriggerServerEvent("PING:registerCop_server")
        printToPlayer("Registered as Cop")
    else
        printToPlayer("Can't be a Cop if you are a Thief")
    end
end,false)

RegisterCommand("thief",function(source)
    if role == "Civi" then
        role = "Thief"
        TriggerServerEvent("PING:registerThief_server")
        printToPlayer("Registered as Thief")
    else
        printToPlayer("Can't be a Thief if you are a Cop")
    end
end,false)

RegisterCommand("civi",function(source)
    TriggerServerEvent("PING:registerCivilian_server",role)
    role = "Civi"
    addBlipsAllowed = false
    for index,blip in ipairs(blips) do
        RemoveBlip(blip)
    end
    for index,blip in ipairs(copblips) do
        RemoveBlip(blip)
    end
end,false)

RegisterCommand("setUpdateTime",function(source,args)
    if #args >= 1 then
        TriggerServerEvent("PING:Update_Updatetime",args[1])
    end
end,false)


RegisterCommand("startChase",function(source)
    -- TriggerServerEvent("PING:startChase")
    TriggerServerEvent("PING:startChase")
    if role == "Thief" then
        if checkPlayerIsInVehicle() then
            createSoppwatchThread()
        end
    end
end,false)

RegisterCommand("endChase",function(source)
    showTimer = false
end,false)

function createSoppwatchThread()
    Citizen.CreateThread(function()
        startTime = GetGameTimer()
        showTimer = true
        while (showTimer and checkPlayerIsInVehicle()) do
            seconds = math.ceil((GetGameTimer()-startTime)/1000)
            seconds_text = disp_time(seconds)
            drawTxt(seconds_text, 4,{255,255,255},0.7,0.85,0.01)
            Citizen.Wait(0)
        end
        local message = ("The Thief escaped for: %s"):format(seconds_text)
        -- printToPlayer(mesage)
        TriggerServerEvent("PING:deliverMessage",message)
    end)
end