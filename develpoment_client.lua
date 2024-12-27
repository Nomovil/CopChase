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


function Draw3DText(x,y,z,textInput,colour,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    local colourr,colourg,colourb,coloura = table.unpack(colour)
    SetTextColour(colourr,colourg,colourb, coloura)
    SetTextDropshadow(2, 1, 1, 1, 255)
    SetTextEdge(3, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

RegisterCommand("pauseGame",function()
    print("Pausing Game")
    PauseClock(false)
end,false)

RegisterCommand("unpauseGame",function()
    print("Unpausing Game")
    PauseClock(true)
end,false)