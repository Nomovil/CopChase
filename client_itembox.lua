itemboxes = {}
MARKERRANGE = 5
MARKERSYMBOL = 32
actionActive = true
ACTIONTIMES = 2



function selectAction()
    local index = math.random(0,100)
    print("Action Choice", index);
    if index < 50 then
        print("Slowing down Thiefs")
        -- Slowdown()
        TriggerServerEvent("PING:slowdownThief")
    elseif index > 50 then
        -- Speedup()
        print("Slowing down Cops")
        TriggerServerEvent("PING:slowdownCops")
    end
end




-- Main Thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if not IsPedInAnyVehicle(PlayerPedId(), false) then
            goto continue
        end
        drawExistingItemBox()
        e_pressed()
        ::continue::
    end
end)

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


function createNewItemBox(pos)
    table.insert(itemboxes,pos)
end

function e_pressed()
    if IsControlJustReleased(0, 86) then
        local pos = getPosinHeading(PlayerPedId())
        TriggerServerEvent("PING:createItemBox",pos)
        -- createNewItemBox(pos)
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


function Slowdown()
    Citizen.CreateThread(function()
        helpMessage("You are being Slowed")
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        local currspeed = GetEntitySpeed(vehicle)
        local maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
        disablePlayerEjection = true
        local countdowntime = setCountdownTime(10)
        while getRemainingCountdownTime(countdowntime)<= 0 do
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
        SetVehicleNitroEnabled(vehicle,true)
        while actionActive do
            
            Citizen.Wait(0)
        end
        SetVehicleNitroEnabled(vehicle,false)
    end)
end
ModifyVehicleTopSpeed(vehicle,5)

function ActionTimer()
    Citizen.CreateThread(function()
        actionActive = true
        Citizen.Wait(ACTIONTIMES*1000)
        actionActive = false
    end)
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


function drawTxt(content, font, colour, scale, x, y)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(colour[1],colour[2],colour[3], 255)
    SetTextEntry("STRING")
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    AddTextComponentString(content)
    DrawText(x, y)
end


function printToPlayer(msg)
    TriggerEvent('chat:addMessage', {
        color = { 255, 0, 0},
        multiline = true,
        args = {"[Ping]", msg}
        }
    )
end

RegisterNetEvent("PING:slowDown",function()
    ActionTimer()
    Slowdown()
end)

RegisterNetEvent("PING:createItemBox",function(pos)
    createNewItemBox(pos)
end)

RegisterNetEvent("PING:removeItemBox", function(index)
    table.remove(itemboxes,index)
    Citizen.Wait(100)
end)

function helpMessage(text, duration)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, true, duration or 5000)
end