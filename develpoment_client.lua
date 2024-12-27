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
            TriggerServerEvent("PING:createItemBox",pos, boxtype)
        end
        -- changeVehicle()
    end
end
--- New Content

RegisterCommand("listItems",function(source)
    for index, box in ipairs(itemboxes) do
        print("Itembox: "..index)
        print("Type: "..box.type)
        print("Position: "..box.x..", "..box.y..", "..box.z)
    end
end,false)



RegisterCommand("pauseGame",function()
    -- ! Dosen't work
    print("Pausing Game")
    PauseClock(false)
end,false)

RegisterCommand("unpauseGame",function()
    -- ! Dosen't work
    print("Unpausing Game")
    PauseClock(true)
end,false)