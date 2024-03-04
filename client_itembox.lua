itemboxes = {}

function selectAction()

    local Actions = {
        Slowdown,
        add_speedboster,
        InvertVehicleControls,
        PlayerWantedLevel,
        SpawnRamp,
        fixcar,
        slowCops,
        slowThiefs
    }
    local function_to_call = choose_element(Actions, probabilities_Actions)
    function_to_call()


end


function choose_element(elements, probabilities)
    -- Überprüfen, ob die Länge der Liste und die der Wahrscheinlichkeiten übereinstimmen
    if #elements ~= #probabilities then
        error(string.format("Die Längen der Liste und der Wahrscheinlichkeiten müssen übereinstimmen. Elements: %d, Probabilities: %d", #elements, #probabilities))
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

Citizen.CreateThread(function()
    while true do
        local pos = getPosinHeading(PlayerPedId())
        -- selectAction()
        TriggerServerEvent("PING:createItemBox",pos)
        Citizen.Wait(RANDOM_ITEMBOX_SPAWN_TIMER*1000)
    end
end)

-- Main Thread checks if Users is in reach of marker
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        if not IsPedInAnyVehicle(PlayerPedId(), false) then
            goto continue
        end
        for index, box in ipairs(itemboxes) do
            MarkerisinReach(box,index)
        end
        ::continue::
    end
end)


-- Itmebox Handling



function createNewItemBox(pos)
    local boxtype = choose_element({NORMAL_BOX_MARKER
,REPAIR_BOX_MARKER},probabilities_itemboxtype)
    local box = {
        x = pos.x,
        y = pos.y,
        z = pos.z,
        type = boxtype
    }
    table.insert(itemboxes,box)
end

function action_button_pressed()
    if IsControlJustReleased(0, ACTION_BTN_NUMBER) then
        local pos = getPosinHeading(PlayerPedId())
        -- selectAction()
        TriggerServerEvent("PING:createItemBox",pos)

    end
end

function drawExistingItemBox()
    for index, box in ipairs(itemboxes) do
        local red = 0
        local green = 255
        local blue = 0
        if box.type == REPAIR_BOX_MARKER then
            red = 50
            green = 255
            blue = 255
        end
        DrawMarker(box.type,box.x,box.y,box.z,0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, red, green, blue, 255, true, true, 2, nil, nil, false)
    end
end

function MarkerisinReach(box,index)
    local distance = GetDistanceBetweenCoords(box.x,box.y,box.z,GetEntityCoords(PlayerPedId()))
    if distance < MARKERRANGE then
        TriggerServerEvent("PING:removeItemBox",index)
        if box.type == REPAIR_BOX_MARKER then
            fixcar()
        else
            selectAction()
        end
    elseif distance >= ITEMBOX_MAX_DISTANCE then
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




function show_number_of_speedboosts()
    while true do
        if number_of_speedboosts >= 1 then
            local text = string.format("Speedboosts: %d", number_of_speedboosts)
            drawTxt(text,4,{0,255,0},0.4,screenPosX+0.02,screenPosY)
        end
        Citizen.Wait(0)
    end
end



function activate_speedboost()
    while true do
        DisableControlAction(0,80,true)
        if IsControlJustReleased(2, 45) and number_of_speedboosts >= 1 then
            Speedup()
            number_of_speedboosts = number_of_speedboosts - 1
        end
        Citizen.Wait(0)
    end
end


Citizen.CreateThread(function()
    show_number_of_speedboosts()
end)
Citizen.CreateThread(activate_speedboost())