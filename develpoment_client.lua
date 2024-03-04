if TESTING then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            dev_button_pressed()
        end
    end)

    function dev_button_pressed()
        if IsControlJustReleased(0, 132) then
            local pos = getPosinHeading(PlayerPedId())
            -- selectAction()
            dev_function()

        end
    end


    function dev_function()
        print("Calling dev function")
        
    end
end
--- New Content

