-- Events from Server to Client

RegisterNetEvent("PING:SetTime")
AddEventHandler("PING:SetTime",function(newtime)
    remainingseconds = newtime
end)

RegisterNetEvent("PING:StartDisplayingTime")
AddEventHandler("PING:StartDisplayingTime",function()
    keepTimeThreadRunning = true
    Citizen.CreateThread(function()
        while keepTimeThreadRunning do
            showTime()
            Wait(0)
        end
    end)
end)

RegisterNetEvent("PING:StopDisplayingTime")
AddEventHandler("PING:StopDisplayingTime", function()
    keepTimeThreadRunning = false
end)


RegisterNetEvent("PING:StartDisplayingVisibility")
AddEventHandler("PING:StartDisplayingVisibility",function()
    if (role == "Thief") then
        keeptVisibilityThreadRunning = true
        Citizen.CreateThread(function()
            while keeptVisibilityThreadRunning do
                showVisibilityState()
                Wait(0)
            end
        end)
    end
end)

RegisterNetEvent("PING:StopDisplayingVisibility")
AddEventHandler("PING:StopDisplayingVisibility",function()
    keeptVisibilityThreadRunning = false
end)

RegisterNetEvent("PING:SetCoordsforPlayer")
AddEventHandler("PING:SetCoordsforPlayer",function(coords,playerid)
    RemoveBlip(blips[playerid])
    local x,y,z = table.unpack(coords)
    local new_blip = AddBlipForCoord(x,y,z)
    SetBlipColour(new_blip, 1)
    SetBlipCategory(new_blip, 0)
    SetBlipScale(new_blip, 0.85)
    blips[playerid] = new_blip
end)


RegisterNetEvent("PING:SetCoordsforCop")
AddEventHandler("PING:SetCoordsforCop",function(coords,playerid)
    RemoveBlip(copblips[playerid])
    if not addBlipsAllowed then
        return
    end
    local x,y,z = table.unpack(coords)
    local new_blip = AddBlipForCoord(x,y,z)
    SetBlipColour(new_blip, 3)
    SetBlipCategory(new_blip, 0)
    SetBlipScale(new_blip, 0.85)
    copblips[playerid] = new_blip
end)



RegisterNetEvent("PING:HidePlayer")
AddEventHandler("PING:HidePlayer",function(coords,player)
    RemoveBlip(blips[player])

    local x,y,z = table.unpack(coords)
    local radius = 50.0
    math.randomseed(GetGameTimer())
    x_add = math.random(0-radius, 0+radius)
    y_add = math.random(0-radius, 0+radius)
    x = x + x_add
    y = y + y_add
    local new_blip = AddBlipForRadius(x,y,z,radius+10)
    SetBlipColour(new_blip, 1)
    SetBlipAlpha(new_blip, 128)
    -- SetBlipCategory(new_blip, 0)
    -- SetBlipScale(new_blip, 0.85)
    blips[player] = new_blip
end)

RegisterNetEvent("PING:chatMessage")
AddEventHandler("PING:chatMessage",function(message)
    printToPlayer(message)
end)

RegisterNetEvent("PING:startChase_cl")
AddEventHandler("PING:startChase_cl",function(source)
    if role == "Civi" or role == "Thief" then
        return
    end

    startCountdown(COUNTDOWNTIME)
    while getremainingTime() > 0 do
        Citizen.Wait(1)
        DrawHudText(getremainingTime(), {255,191,0,255},0.5,0.4,4.0,4.0)
            
        -- Disable acceleration/reverse until race starts
        DisableControlAction(2, 71, true)
        DisableControlAction(2, 72, true)
    end
    EnableControlAction(2, 71, true)
    EnableControlAction(2, 72, true)
end)


-- variables
remainingseconds  = -1
keepTimeThreadRunning = true
keeptVisibilityThreadRunning = true
blips = {}
copblips = {}



Citizen.CreateThread(function()
    while true do
        Wait(10)
        if role == "Thief" then
            if IsControlJustPressed(0,73) then
                TriggerServerEvent("PING:UpdateOFF_sv")
            end
            if IsControlJustReleased(0,73) then
                TriggerServerEvent("PING:UpdateON_sv")
            end
        end
    end
end)
