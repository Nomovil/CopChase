itemboxes = {}
MARKERRANGE = 5
MARKERSYMBOL = 32
actionActive = true
ACTIONTIMES = 2



function selectAction()
    -- Speedup()

    local elements = {
        function()
            TriggerServerEvent("PING:slowdownCops")
        end,
        function()
            TriggerServerEvent("PING:slowdownThief")
        end,
    }
    local probabilities = {0.5, 0.5,}

    local function_to_call = choose_element(elements, probabilities)
    function_to_call()

end


function choose_element(elements, probabilities)
    -- Überprüfen, ob die Länge der Liste und die der Wahrscheinlichkeiten übereinstimmen
    if #elements ~= #probabilities then
        error("Die Längen der Liste und der Wahrscheinlichkeiten müssen übereinstimmen.")
    end
    
    -- Kumulative Summe der Wahrscheinlichkeiten berechnen
    local cumulative_probabilities = {}
    local cumulative_sum = 0
    for i, prob in ipairs(probabilities) do
        cumulative_sum = cumulative_sum + prob
        cumulative_probabilities[i] = cumulative_sum
    end
    -- Zufallszahl zwischen 0 und 1 generieren
    local random_value = math.random()
    -- Element auswählen basierend auf der Zufallszahl und den kumulativen Wahrscheinlichkeiten
    for i, cumulative_prob in ipairs(cumulative_probabilities) do
        if random_value <= cumulative_prob then
            return elements[i]
        end
    end
end


-- Main Thread
-- Checks Button Presses and Draws Itemboxes
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if not IsPedInAnyVehicle(PlayerPedId(), false) then
            goto continue
        end
        drawExistingItemBox()
        action_button_pressed()
        ::continue::
    end
end)


-- Main Thread checks if Users is in reach of marker
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        if not IsPedInAnyVehicle(PlayerPedId(), false) then
            goto continue
        end
        for index, pos in ipairs(itemboxes) do
            MarkerisinReach(pos,index)
        end
        ::continue::
    end
end)


-- Itmebox Handling

function createNewItemBox(pos)
    table.insert(itemboxes,pos)
end

function action_button_pressed()
    if IsControlJustReleased(0, 19) then
        local pos = getPosinHeading(PlayerPedId())
        -- selectAction()
        TriggerServerEvent("PING:createItemBox",pos)
    end
end

function drawExistingItemBox()
    for index, pos in ipairs(itemboxes) do
        DrawMarker(MARKERSYMBOL,pos.x,pos.y,pos.z,0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 0, 255, 0, 255, true, true, 2, nil, nil, false)
    end
end

function MarkerisinReach(pos,index)
    local distance = GetDistanceBetweenCoords(pos,GetEntityCoords(PlayerPedId()))
    if distance < MARKERRANGE then
        TriggerServerEvent("PING:removeItemBox",index)
        selectAction()
    elseif distance >= 1000 then
        table.remove(itemboxes,index)
    end
end


function getPosinHeading(playerid)
    fwd,_,_,pos = GetEntityMatrix(playerid)
    local multiplyer = math.random(10,100)
    local newx = pos.x + fwd.x*multiplyer
    local newy = pos.y + fwd.y*multiplyer
    local newPosHeading = vec(newx,newy,pos.z)
    retval, newz = GetSafeCoordForPed(newPosHeading.x,newPosHeading.y,newPosHeading.z,false,newz,0)
    return newz
end


RegisterNetEvent("PING:createItemBox",function(pos)
    createNewItemBox(pos)
end)

RegisterNetEvent("PING:removeItemBox", function(index)
    table.remove(itemboxes,index)
    Citizen.Wait(100)
end)



-- Action Definitions



function Slowdown()
    Citizen.CreateThread(function()
        helpMessage("You are being Slowed")
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        local currspeed = GetEntitySpeed(vehicle)
        local maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
        disablePlayerEjection = true
        local countdowntime = GetGameTimer() + 10*1000
        while math.floor((countdowntime - GetGameTimer())/1000) >= 0 do
            SetEntityMaxSpeed(vehicle, 10.0)
            Citizen.Wait(0)
        end
        disablePlayerEjection = false
        SetEntityMaxSpeed(vehicle,maxSpeed)
    end)
end

function Speedup()
    Citizen.CreateThread(function()
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        local currspeed = GetEntitySpeed(vehicle)
        local maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
        Citizen.InvokeNative(0xC8E9B6B71B8E660D, vehicle, true, 2.5, 1.0, 4.0, false)
        -- SetVehicleNitroEnabled(vehicle,true)
        -- SetVehicleMod(vehicle,17,17,false)
        local countdowntime = GetGameTimer() + 10*1000
        while math.floor((countdowntime - GetGameTimer())/1000) >= 0 do
            Citizen.Wait(100)
        end
        -- SetVehicleNitroEnabled(vehicle,false)
        Citizen.InvokeNative(0xC8E9B6B71B8E660D, vehicle, false, 0, 0, 0, false)
    end)
end


RegisterNetEvent("PING:slowDown",function()
    Slowdown()
end)

