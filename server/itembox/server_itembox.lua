itemboxes = {}





function createNewItemBox(pos, boxtype)
    -- print("Creating Itembox")
    local box = {
        x = pos.x,
        y = pos.y,
        z = pos.z,
        type = boxtype
    }
    -- check if at this pos already is a box
    for index, itembox in ipairs(itemboxes) do
        if itembox.x == box.x and itembox.y == box.y and itembox.z == box.z then
            return
        end
    end

    table.insert(itemboxes, box)
    -- TriggerClientEvent("PING:createItemBox", -1, pos, boxtype)
    TriggerClientEvent("PING:syncItemBoxes", -1, itemboxes)
end

function removeItemBox(index)
    print("Removing Itembox")
    if index > #itemboxes then
        return
    end
    table.remove(itemboxes, index)
    -- TriggerClientEvent("PING:removeItemBox", -1, index)
    TriggerClientEvent("PING:syncItemBoxes", -1, itemboxes)

end