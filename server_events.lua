updateTime = 10
keepTimeThreadRunning = true
cops = {}
thiefs = {}
hiddenThiefs = {}

RegisterNetEvent("PING:startChase")
AddEventHandler("PING:startChase",function()
    -- startingChase()
    TriggerClientEvent("PING:startChase_cl",-1)
end)

RegisterNetEvent("PING:registerCop_server")
AddEventHandler("PING:registerCop_server",function()
    local added_cop = false
    if #cops > 0 then
        for _,thief in pairs(cops) do
            if thief == source then

            else
                added_cop = true
            end
        end
    else
        added_cop = true
    end
    if added_cop then
        table.insert(cops,source)
        TriggerClientEvent("PING:StartDisplayingTime",source)
    end
end)

RegisterNetEvent("PING:registerThief_server")
AddEventHandler("PING:registerThief_server",function()
    local added_cop = false
    if #thiefs > 0 then
        for _,thief in pairs(thiefs) do
            if thief == source then

            else
                added_cop = true
            end
        end
    else
        added_cop = true
    end
    if added_cop then
        local thiefprop = {
            source = source,
            hdden = false
        }
        table.insert(thiefs,thiefprop)
        TriggerClientEvent("PING:StartDisplayingTime",source)
        -- TriggerClientEvent("PING:StartDisplayingVisibility",source)
    end
end)

RegisterNetEvent("PING:registerCivilian_server")
AddEventHandler("PING:registerCivilian_server",function(oldrole)
    if oldrole == "Thief" then
        for index,thief in ipairs(thiefs) do
            if thief.source == source then
                table.remove(thiefs,index)
            end
        end
    end
    if oldrole == "Cop" then
        for index, cop  in ipairs(cops) do
            if cop == source then
                table.remove(cops,index)
            end
        end
        -- table.remove(cops,source)
    end
    TriggerClientEvent("PING:StopDisplayingTime",source)
    -- TriggerClientEvent("PING:StopDisplayingVisibility",source)
end)

RegisterNetEvent("PING:Update_Updatetime")
AddEventHandler("PING:Update_Updatetime",function(newtime)
    updateTime = newtime
end)

RegisterNetEvent("PING:UpdateOFF_sv")
AddEventHandler("PING:UpdateOFF_sv",function()
    for index,thief in ipairs(thiefs) do
        if thief.source == source then
            thief.hidden = true
            thiefs[index] = thief
        end
    end
    -- print("Turning Off")
    -- set = utils_Set(hiddenThiefs)
    -- local thiefstate = set[source]
    -- print("source", source);
    -- print("thiefstate", thiefstate);
    -- print("in Hidden",hiddenThiefs[source])
    -- print("in Hidden 1",hiddenThiefs[1])
    -- if thiefstate == nil then
    --     print("numberhidden", #hiddenThiefs);
    --     -- table.insert(hiddenThiefs,source)
    --     set[source] = true
    --     print("numberhidden", #hiddenThiefs);
    --     print("in Hidden",hiddenThiefs[source])
    -- end
end)

RegisterNetEvent("PING:UpdateON_sv")
AddEventHandler("PING:UpdateON_sv",function()
    for index,thief in ipairs(thiefs) do
        if thief.source == source then
            thief.hidden = false
            thiefs[index] = thief
        end
    end
    -- print("Turning ON")
    -- print("source", source);
    -- set = utils_Set(hiddenThiefs)
    -- local thiefstate = set[source]
    -- print("thiefstate", thiefstate);
    -- print("in Hidden",hiddenThiefs[source])
    -- print("in Hidden 1",hiddenThiefs[1])
    -- numberhidden = #hiddenThiefs
    -- print("numberhidden", #hiddenThiefs);
    -- -- table.remove(hiddenThiefs,source)
    -- -- set[source] = nil
    -- hiddenThiefs[source] = nil
    -- print("numberhidden", #hiddenThiefs);
end)


RegisterNetEvent("PING:deliverMessage")
AddEventHandler("PING:deliverMessage",function(message)
    TriggerClientEvent("PING:chatMessage",-1,message)
end)


RegisterNetEvent("PING:slowdownCops",function()
    print("Slowing down Cops")
    for _,cop in ipairs(cops) do
        TriggerClientEvent("PING:slowDown",cop)
    end
end)

RegisterNetEvent("PING:slowdownThief",function()
    print("Slowing down Thiefs")
    for _,thief in ipairs(thiefs) do
        TriggerClientEvent("PING:slowDown",thief.source)
    end
end)

RegisterNetEvent("PING:createItemBox",function(pos)
    TriggerClientEvent("PING:createItemBox",-1,pos)
end)

RegisterNetEvent("PING:removeItemBox",function(index)
    TriggerClientEvent("PING:removeItemBox",-1,index)
end)