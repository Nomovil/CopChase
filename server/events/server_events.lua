updateTime = 10
keepTimeThreadRunning = true
cops = {}
thiefs = {}
hiddenThiefs = {}
Queue = {}
function Queue:new()
    local object = {}
    
    object.list = {}
    object.offset = 1
    
    self.__index = self
    return setmetatable(object, self)
end

queue = Queue:new()
changeHiddenStateNextPing = false

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
    TriggerClientEvent("PING:RemovePlayerBlip",-1,source)
    TriggerClientEvent("PING:StopDisplayingTime",source)
    -- TriggerClientEvent("PING:StopDisplayingVisibility",source)
end)

RegisterNetEvent("PING:Update_Pingtime")
AddEventHandler("PING:Update_Pingtime",function(newtime)
    updateTime = newtime
end)
RegisterNetEvent("PING:Update_startTime",function(newtime)
    TriggerClientEvent("PING:Update_startTime_cl",-1,newtime)
end)

-- RegisterNetEvent("PING:Update_NumberOfHides",function(newMaxHides)
--     TriggerClientEvent("PING:Update_NumberOfHides_cl",-1,newMaxHides)
-- end)

RegisterNetEvent("PING:UpdateOFF_sv")
AddEventHandler("PING:UpdateOFF_sv",function()
    changeHiddenStateNextPing = true
    local set = {source = source, state = true}
    queue:enqueue(set)
end)

RegisterNetEvent("PING:UpdateON_sv")
AddEventHandler("PING:UpdateON_sv",function()
    changeHiddenStateNextPing = true
    local set = {source = source, state = false}
    queue:enqueue(set)
end)


RegisterNetEvent("PING:deliverMessage")
AddEventHandler("PING:deliverMessage",function(message)
    TriggerClientEvent("PING:chatMessage",-1,message)
end)


RegisterNetEvent("PING:ThiefLost", function()
    TriggerClientEvent("PING:ThiefLost_cl",-1)
end)

RegisterNetEvent("PING:slowdownCops",function()
    -- print("Slowing down Cops")
    for _,cop in ipairs(cops) do
        TriggerClientEvent("PING:slowDown",cop)
    end
end)

RegisterNetEvent("PING:slowdownThief",function()
    -- print("Slowing down Thiefs")
    for _,thief in ipairs(thiefs) do
        TriggerClientEvent("PING:slowDown",thief.source)
    end
end)

RegisterNetEvent("PING:removeItemBox")
AddEventHandler("PING:removeItemBox", function(index)
    removeItemBox(index)
end)

RegisterNetEvent("PING:syncItemBoxes")
AddEventHandler("PING:syncItemBoxes", function()
    TriggerClientEvent("PING:syncItemBoxes", source, itemboxes)
end)
RegisterNetEvent("PING:createItemBox", function(pos, boxtype)
    createNewItemBox(pos, boxtype)
end)


