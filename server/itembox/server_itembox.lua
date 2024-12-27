itemboxes = {}





function createNewItemBox(pos, boxtype)
    -- print("Creating Itembox")
    local box = {
        x = pos.x,
        y = pos.y,
        z = pos.z,
        type = boxtype
    }
    table.insert(itemboxes, box)
    -- TriggerClientEvent("PING:createItemBox", -1, pos, boxtype)
    TriggerClientEvent("PING:syncItemBoxes", -1, itemboxes)
end

function removeItemBox(index)
    if index > #itemboxes then
        return
    end
    table.remove(itemboxes, index)
    -- TriggerClientEvent("PING:removeItemBox", -1, index)
    TriggerClientEvent("PING:syncItemBoxes", -1, itemboxes)

end