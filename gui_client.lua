function showTime()
    local text = ("%ds"):format(math.ceil(remainingseconds))
    drawTxt(text, fontNumber, locationColorText, scaleFactor, screenPosX,screenPosY)
end

function showVisibilityState()
    if playerIsVisible then
        drawTxt("Visibile",4,{255,0,0},0.4,screenPosX+0.02,screenPosY)
    else
        drawTxt("Hidden",4,{0,255,0},0.4,screenPosX+0.02,screenPosY)
    end
end