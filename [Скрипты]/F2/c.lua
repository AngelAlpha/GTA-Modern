local screenW2,screenH2 = guiGetScreenSize()
local resW2, resH2 = 1366,768
local x, y =  (screenW2/resW2), (screenH2/resH2)

local font_Menu = dxCreateFont("files/font/font.ttf", 15)
local movertexto = 0
local parte1 = false

cor = {}

local idModel = {
[1] = 14399,
[2] = 14400,
[3] = 14401,
[4] = 14402,
[5] = 14403,
[6] = 14404
}

function part1()

		movertexto = movertexto + 0.999*3
		local movertexto1, movertexto2 = interpolateBetween (x*1210, y*900, 0, x*1480, y*900, 0, movertexto, "SineCurve")
		dxDrawText("Группа https://vk.com/tcwrp", x*640, movertexto2, x*715, y, tocolor(255, 255, 255, 255), x*0.68, font_Menu, "center", "center", false, false, true, true, true)
		
		
        dxDrawRectangle(x*500, y*165, x*350, y*300, tocolor(0, 0, 0, 200), false)
        dxDrawRectangle(x*500, y*165, x*350, y*35, tocolor(0, 0, 0, 180), false)
        dxDrawEmptyRec(x*500, y*165, x*350, y*300, tocolor(0, 0, 0, 255), 2)		
		dxDrawRectangle(x*840, y*165, x*35, y*30, tocolor(0, 0, 0, 0), false)
		dxDrawText("Панель управления авто", x*640, y*13, x*715, y*350, tocolor(255, 255, 255, 255), x*1.0, font_Menu, "center", "center", false, false, false, false, false)


		dxDrawImage(x*600, y*240, x*140, y*140, 'gfx/arrow.png')
		
		dxDrawImage(x*655, y*203, x*30, y*30, "gfx/seta.png", 0, 0, 0, tocolor(255,255,255,255))
		dxDrawImage(x*655, y*389, x*30, y*30, "gfx/seta.png", 180, 0, 0, tocolor(255,255,255,255))
        dxDrawImage(x*655, y*409, x*30, y*30, "gfx/seta.png", 180, 0, 0, tocolor(255,255,255,255))		
	
		dxDrawImage(x*575, y*265, x*30, y*30, "gfx/seta.png", 270, 0, 0, tocolor(255,255,255,255))
		dxDrawImage(x*575, y*325, x*30, y*30, "gfx/seta.png", 270, 0, 0, tocolor(255,255,255,255))

		dxDrawImage(x*735, y*265, x*30, y*30, "gfx/seta.png", 90, 0, 0, tocolor(255,255,255,255))
		dxDrawImage(x*735, y*325, x*30, y*30, "gfx/seta.png", 90, 0, 0, tocolor(255,255,255,255))				
end	

function porta1 (_,state)
if parte1 == true then
if state == "down" then
if isCursorOnElement (x*655, y*203, x*30, y*30) then
triggerServerEvent ("porta1", getLocalPlayer())
end
end
end
end
addEventHandler ("onClientClick", root, porta1)

function porta2 (_,state)
if parte1 == true then
if state == "down" then
if isCursorOnElement (x*655, y*389, x*30, y*30) then
triggerServerEvent ("porta2", getLocalPlayer())
end
end
end
end
addEventHandler ("onClientClick", root, porta2)

function porta2_2 (_,state)
if parte1 == true then
if state == "down" then
if isCursorOnElement (x*655, y*409, x*30, y*30) then
triggerServerEvent ("porta2_2", getLocalPlayer())
end
end
end
end
addEventHandler ("onClientClick", root, porta2_2)

function porta3 (_,state)
if parte1 == true then
if state == "down" then
if isCursorOnElement (x*575, y*265, x*30, y*30) then
triggerServerEvent ("porta3", getLocalPlayer())
end
end
end
end
addEventHandler ("onClientClick", root, porta3)

function porta4 (_,state)
if parte1 == true then
if state == "down" then
if isCursorOnElement (x*575, y*325, x*30, y*30) then
triggerServerEvent ("porta4", getLocalPlayer())
end
end
end
end
addEventHandler ("onClientClick", root, porta4)

function porta5 (_,state)
if parte1 == true then
if state == "down" then
if isCursorOnElement (x*735, y*265, x*30, y*30) then
triggerServerEvent ("porta5", getLocalPlayer())
end
end
end
end
addEventHandler ("onClientClick", root, porta5)

function porta6 (_,state)
if parte1 == true then
if state == "down" then
if isCursorOnElement (x*735, y*325, x*30, y*30) then
triggerServerEvent ("porta6", getLocalPlayer())
end
end
end
end
addEventHandler ("onClientClick", root, porta6)


function dxPainelAbrir()
local vehicle = getPedOccupiedVehicleSeat(localPlayer)
    if vehicle == 0 then
        if parte1 == false then
        addEventHandler ("onClientRender", root, part1)
        parte1 = true 
        showCursor (true)
    else
    removeEventHandler ("onClientRender", root, part1)
    parte1 = false
    showCursor (false) 
        end
    end  
end
bindKey("F2", "down", dxPainelAbrir)

local x,y = guiGetScreenSize()

function dxDrawEmptyRec(absX, absY, sizeX, sizeY, color, ancho)
	dxDrawRectangle(absX, absY, sizeX, ancho, color)
	dxDrawRectangle(absX, absY + ancho, ancho, sizeY - ancho, color)
	dxDrawRectangle(absX + ancho, absY + sizeY - ancho, sizeX - ancho, ancho, color)
	dxDrawRectangle(absX + sizeX - ancho, absY + ancho, ancho, sizeY - ancho * 2, color)
end
 
function isCursorOnElement(x,y,w,h)
 local mx,my = getCursorPosition ()
 local fullx,fully = guiGetScreenSize()
 cursorx,cursory = mx*fullx,my*fully
 if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
  return true
 else
  return false
 end
end

if fileExists("s.lua") then fileDelete("s.lua") end

function isMousePosition(x,y,w,h)
	if (not isCursorShowing()) then
		return false
	end
	local mx,my = getCursorPosition ()
	local fullx,fully = guiGetScreenSize()
	cursorx,cursory = mx*fullx,my*fully
	if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
		return true
	else
		return false
	end
end

function isMouseInPosition(x,y,width,height)
    local cx, cy = getCursorPosition()
    local cx, cy = (cx*sx), (cy*sy)
    if (cx >= x and cx <= x + width) and (cy >= y and cy <= y + height) then
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

--[[function replaceTXD() 
txd = engineLoadTXD ( "models/MatTextures.txd" )
engineImportTXD ( txd, idModel[1] )
engineImportTXD ( txd, idModel[2] )
engineImportTXD ( txd, idModel[3] )
engineImportTXD ( txd, idModel[4] )
engineImportTXD ( txd, idModel[5] )
engineImportTXD ( txd, idModel[6] )

col = engineLoadCOL("models/RedNeonTube1.col")
engineReplaceCOL(col, idModel[1])
col = engineLoadCOL("models/BlueNeonTube1.col")
engineReplaceCOL(col, idModel[2])
col = engineLoadCOL("models/GreenNeonTube1.col")
engineReplaceCOL(col, idModel[3])
col = engineLoadCOL("models/YellowNeonTube1.col")
engineReplaceCOL(col, idModel[4])
col = engineLoadCOL("models/PinkNeonTube1.col")
engineReplaceCOL(col, idModel[5])
col = engineLoadCOL("models/WhiteNeonTube1.col")
engineReplaceCOL(col, idModel[6])

dff = engineLoadDFF ( "models/RedNeonTube1.dff", idModel[1] )
engineReplaceModel ( dff, idModel[1] ) 
dff = engineLoadDFF ( "models/BlueNeonTube1.dff", idModel[2] )
engineReplaceModel ( dff, idModel[2] ) 
dff = engineLoadDFF ( "models/GreenNeonTube1.dff", idModel[3] )
engineReplaceModel ( dff, idModel[3] ) 
dff = engineLoadDFF ( "models/YellowNeonTube1.dff", idModel[4] )
engineReplaceModel ( dff, idModel[4] ) 
dff = engineLoadDFF ( "models/PinkNeonTube1.dff", idModel[5] )
engineReplaceModel ( dff, idModel[5] ) 
dff = engineLoadDFF ( "models/WhiteNeonTube1.dff", idModel[6] )
engineReplaceModel ( dff, idModel[6] ) 
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), replaceTXD)]]--