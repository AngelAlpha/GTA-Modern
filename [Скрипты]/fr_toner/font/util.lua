local font = dxCreateFont("font/font.ttf", 14)
local font2 = dxCreateFont("font/font2.ttf", 20)
-- скролл
function dxDrawScrollBar (x, y, w, h, scroll)
	local mx, my = getMousePos()
	local bgcolor = tocolor(205, 30, 30, 255)
	local tcolor = tocolor(255, 255, 255, 255)
	if isPointInRect(mx, my, scroll, y-5, 10, h+10) then
		tcolor = tocolor(82, 82, 82, 255)
	elseif isPointInRect(mx, my, x, y-5, 10, h+10 ) then
		tcolor = tocolor(82, 82, 82, 255)
	elseif isPointInRect(mx, my, x, (x+w)-10, y-5, 10, h+10 ) then
		tcolor = tocolor(82, 82, 82, 255)
	end
	if scrollMoving then
		tcolor = tocolor(82, 82, 82, 255)
	end
	dxDrawRectangle(x, y, w, h, bgcolor, false)
	if scroll >= x and scroll <= (x+w)-10 then
		dxDrawRectangle(scroll, y-5, 10, h+10, tcolor, false)
		scrollProcent = ((scroll-x)/w)*100
		setElementData(getPedOccupiedVehicle(localPlayer), "toner:alpha", 1 - math.floor(scrollProcent)*0.01)
	else
		if scroll <= x then
			dxDrawRectangle(x, y-5, 10, h+10, tcolor, false)
			scrollProcent = 0
			setElementData(getPedOccupiedVehicle(localPlayer), "toner:alpha", 1 - math.floor(scrollProcent)*0.01)
		else
			dxDrawRectangle((x+w)-10, y-5, 10, h+10, tcolor, false)
			scrollProcent = 100
			setElementData(getPedOccupiedVehicle(localPlayer), "toner:alpha", 1 - math.floor(scrollProcent)*0.01)
		end
	end
end


function dxDrawButton(x, y, w, h, text)
	local mx, my = getMousePos()
	local bgcolor = tocolor(205, 30, 30, 255)
	local tcolor = tocolor(255, 255, 255, 255)
	if isPointInRect(mx, my, x - 2, y, w, h) then
		bgcolor = tocolor(82, 82, 82, 255)
	else
		bgcolor = tocolor(205, 30, 30, 255)
	end
	dxDrawRectangle(x, y, w, h, bgcolor, false)
	dxDrawText(text, x, y, w + x, h + y, tcolor, 1, "default-bold", "center", "center", true, false, false, true)
end

function dxDrawWindow(x, y, w, h, text)
	local mx, my = getMousePos()
	local bgcolor = tocolor(0, 0, 0, 200)
	local bgcolors = tocolor(205, 30, 30, 255)
	local tcolor = tocolor(255, 255, 255, 255)
	dxDrawRectangle(x, y, w, h, bgcolor, false)
	dxDrawRectangle(x + 4, y + 4, w - 8, 25, bgcolors, false)
	dxDrawText(text, x + 4, y + 4, w + x - 8, 30 + y, tcolor, 1, font, "center", "center", true, false, false, true)
end

function dxDrawCheckButton(x, y, w, h, text, chek )
	local mx, my = getMousePos()
	local color1 = tocolor(205, 30, 30, 255)
	local color2 = tocolor(82, 82, 82, 255)
	local color3 = tocolor(205, 30, 30, 255)
	if isPointInRect(mx, my, x, y, w, h) then
		color3 = tocolor(255, 0, 0, 200)
	end
	local pos = x
	dxDrawRectangle(x, y, w, h, color1, false)
	dxDrawRectangle(x + 2, y + 2, w - 4, h - 4, color2, false)
	if chek then
		dxDrawRectangle(pos + 4, y + 4, w - 8, h - 8, color3, false)
	end
	dxDrawText(text, pos + 20, y + 6, 30 + pos + 25, h - 12 + y + 6, tcolor, 0.4, font2, "left", "center", true, false, false, true)
end

function isPointInRect(x, y, rx, ry, rw, rh)
	if x >= rx and y >= ry and x <= rx + rw and y <= ry + rh then
		return true
	else
		return false
	end
end

function cursorPosition(x, y, w, h)
	if (not isCursorShowing()) then
		return false
	end
	local mx, my = getCursorPosition()
	local fullx, fully = guiGetScreenSize()
	cursorx, cursory = mx*fullx, my*fully
	if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
		return true
	else
		return false
	end
end

function getMousePos()
	local xsc, ysc = guiGetScreenSize()
	local mx, my = getCursorPosition()
	if not mx or not my then
		mx, my = 0, 0
	end
	return mx * xsc, my * ysc
end

