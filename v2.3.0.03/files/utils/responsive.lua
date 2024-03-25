screen = {guiGetScreenSize ()}
resolution = {1366, 768}
sx, sy = screen[1] / resolution[1], screen[2] / resolution[2]

function setScreenPosition (x, y, w, h)
    return ((x / resolution[1]) * screen[1]), ((y / resolution[2]) * screen[2]), ((w / resolution[1]) * screen[1]), ((h / resolution[2]) * screen[2])
end

function isMouseInPosition (x, y, w, h)
    if isCursorShowing () then
        local cursor = {getCursorPosition ()}
        local mx, my = cursor[1] * screen[1], cursor[2] * screen[2]
        return mx > x and mx < x + w and my > y and my < y + h
    end
    return false
end

_dxDrawImageSem = dxDrawImage
function dxDrawImageSem (x, y, w, h, ...)
    
    return _dxDrawImageSem (x, y, w, h, ...)
end

_dxCreateFont = dxCreateFont
function dxCreateFont (path, scale, ...)
    local _, scale, _, _ = setScreenPosition (0, scale, 0, 0)

    return _dxCreateFont (path, scale, ...)
end

_dxDrawRectangle = dxDrawRectangle
function dxDrawRectangle (x, y, w, h, ...)
    local x, y, w, h = setScreenPosition (x, y, w, h)
    
    return _dxDrawRectangle (x, y, w, h, ...)
end

_dxDrawImage = dxDrawImage
function dxDrawImage (x, y, w, h, ...)
    local x, y, w, h = setScreenPosition (x, y, w, h)
    
    return _dxDrawImage (x, y, w, h, ...)
end

_dxDrawImageSection = dxDrawImageSection
function dxDrawImageSection (x, y, w, h, ...)
    local x, y, w, h = setScreenPosition (x, y, w, h)
    
    return _dxDrawImageSection (x, y, w, h, ...)
end

_dxDrawText = dxDrawText
function dxDrawText (text, x, y, w, h, ...)
    local x, y, w, h = setScreenPosition (x, y, w, h)
    
    return _dxDrawText (text, x, y, (x + w), (y + h), ...)
end

_isMouseInPosition = isMouseInPosition
function isMouseInPosition (x, y, w, h)
    local x, y, w, h = setScreenPosition (x, y, w, h)

    return _isMouseInPosition (x, y, w, h)
end

_tocolor = tocolor
function tocolor(r, g, b, a)
    return _tocolor(r, g, b, a and (a >= 255 and 255 or ((a*255)/100)) or 255)
end

function createEditBox(x, y, w, h, color, fontType, typeBox)
    if (dxGetTextWidth((select == typeBox and guiGetText(edits[typeBox])..'|' or guiGetText(edits[typeBox])), 1.00, fontType) <= w - 10) then
        dxDrawText(select == typeBox and guiGetText(edits[typeBox])..'|' or guiGetText(edits[typeBox]), x + 5, y, w - 10, h, color, 1.00, fontType, "left", "center", true, false, false, false, false)
    else
        dxDrawText(select == typeBox and guiGetText(edits[typeBox])..'|' or guiGetText(edits[typeBox]), x + 5, y, w - 10, h, color, 1.00, fontType, "right", "center", true, false, false, false, false)
    end
end