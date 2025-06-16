-- local Timer = require("client.helpers.timer")
-- local Timer = dofile("client/helpers/timer.lua")
-- local pause = exports.CopChase2:PauseTimer()
-- local resume = exports["CopChase2"]:Resume()

if TESTING then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            dev_button_pressed()
        end
    end)
    function dev_button_pressed()
        if IsControlJustReleased(0, DEV_BTN_NUMBER) then
            dev_function()
        end
    end

    toggle = false
    function dev_function()
        print("Calling dev function")
        for i = 1, 10 do
            local pos = getPosinHeading(PlayerPedId())
            -- selectAction()
            boxtype = getBoxType()
            TriggerServerEvent("PING:createItemBox", pos, boxtype)
        end
        -- changeVehicle()
    end
end
--- New Content

RegisterCommand("listItems", function(source)
    for index, box in ipairs(itemboxes) do
        print("Itembox: " .. index)
        print("Type: " .. box.type)
        print("Position: " .. box.x .. ", " .. box.y .. ", " .. box.z)
    end
end, false)


RegisterCommand("modifyCar", function(source)
    AdjustCopCarSettings()
end, false)

RegisterCommand("getCarInfo", function(source)
    getCarInfo()
end, false)

function getCarInfo()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local modkit = GetVehicleModKit(
		vehicle --[[ Vehicle ]]
	)
    print("Vehicle Mod Kit: " .. modkit)
    local modkittype = GetVehicleModKitType(
        vehicle --[[ Vehicle ]]
    )
    print("Vehicle Mod Kit Type: " .. modkittype)
    local engine = GetVehicleMod(
		vehicle --[[ Vehicle ]], 
		11 --[[ integer ]]
	)
    local brakes = GetVehicleMod(
        vehicle --[[ Vehicle ]],
        12 --[[ integer ]]
    )
    local transmission = GetVehicleMod(
        vehicle --[[ Vehicle ]],
        13 --[[ integer ]]
    )
    local suspenssion = GetVehicleMod(
        vehicle --[[ Vehicle ]],
        15 --[[ integer ]]
    )
    local nitro = GetVehicleMod(
        vehicle --[[ Vehicle ]],
        17 --[[ integer ]]
    )
    print("Vehicle Engine: " .. engine)
    print("Vehicle Brakes: " .. brakes)
    print("Vehicle Transmission: " .. transmission)
    print("Vehicle Suspension: " .. suspenssion)
    print("Vehicle Nitro: " .. nitro)

    local color1, color2 = GetVehicleColours(
        vehicle --[[ Vehicle ]]
    )

    print("Vehicle Color 1: " .. color1)
    print("Vehicle Color 2: " .. color2)
end
