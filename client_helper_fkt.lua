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


function notifyPlayer(source,msg)
    TriggerClientEvent('chatMessage', source, "[Ping]", {255, 0, 0}, msg)
end
function printToPlayer(msg)
    TriggerEvent('chat:addMessage', {
        color = { 255, 0, 0},
        multiline = true,
        args = {"[Ping]", msg}
        }
    )
end

function disp_time(time)
    local days = math.floor(time/86400)
    local remaining = time % 86400
    local hours = math.floor(remaining/3600)
    remaining = remaining % 3600
    local minutes = math.floor(remaining/60)
    remaining = remaining % 60
    local seconds = remaining
    if (hours < 10) then
      hours = "0" .. tostring(hours)
    end
    if (minutes < 10) then
      minutes = "0" .. tostring(minutes)
    end
    if (seconds < 10) then
      seconds = "0" .. tostring(seconds)
    end
    answer = tostring(hours)..'h:'..minutes..'m:'..seconds..'s'
    return answer
end

function checkPlayerIsInVehicle()
    local ped = GetPlayerPed(-1)
    return GetVehiclePedIsIn(ped,false) > 0
end


function startCountdown(time_to_count_down)
    time = GetGameTimer() + time_to_count_down*1000
end

function getremainingTime()
    return math.floor((time-GetGameTimer())/1000)
end

function setCountdownTime(time_to_count_down)
    return GetGameTimer() + time_to_count_down*1000)
end

function getRemainingCountdownTime(finishtime)
   return math.floor((finishtime - GetGameTimer())/1000) 
end
-- Utility function to display HUD text
function DrawHudText(text,colour,coordsx,coordsy,scalex,scaley)
    SetTextFont(4)
    SetTextProportional(7)
    SetTextScale(scalex, scaley)
    local colourr,colourg,colourb,coloura = table.unpack(colour)
    SetTextColour(colourr,colourg,colourb, coloura)
    SetTextDropshadow(0, 0, 0, 0, coloura)
    SetTextEdge(1, 0, 0, 0, coloura)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(coordsx,coordsy)
end
