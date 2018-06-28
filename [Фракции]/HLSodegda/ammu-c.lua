local GUIEditor_Window = {}
local GUIEditor_Button = {}
local GUIEditor_Label = {}

local x,y = guiGetScreenSize() 
GUIEditor_Window[1] = guiCreateWindow((x-410)/2, (y-180)/2, 410, 180, "Переодевалка", false )
guiWindowSetSizable(GUIEditor_Window[1],false)
guiSetVisible(GUIEditor_Window[1],false)
GUIEditor_Button[1] = guiCreateButton(5,105,400,40,"Закрыть",false,GUIEditor_Window[1])
GUIEditor_Button[2] = guiCreateButton(5,62,195,40, "Рабочая форма",false,GUIEditor_Window[1])
GUIEditor_Button[3] = guiCreateButton(205,62,195,40, "Моя одежда",false,GUIEditor_Window[1])
img1 = guiCreateStaticImage(5,22,195,40, "img/HOTSMALL.png", false, GUIEditor_Window[1])
--GUIEditor_Button[4] = guiCreateButton(5,91,400,30, "Амфетамин - 5$/шт",false,GUIEditor_Window[1])
--GUIEditor_Button[5] = guiCreateButton(5,124,400,30, "ЛСД - 5$/шт",false,GUIEditor_Window[1])
--GUIEditor_Button[6] = guiCreateButton(5,157,400,30, "Стероиды - 5$/шт",false,GUIEditor_Window[1])
--GUIEditor_Button[7] = guiCreateButton(5,190,400,30, "Спайс - 5$/шт",false,GUIEditor_Window[1])

local x,y = guiGetScreenSize() 
GUIEditor_Window[2] = guiCreateWindow((x-410)/2, (y-180)/2, 410, 180, "Переодевалка Пациента", false )
guiWindowSetSizable(GUIEditor_Window[2],false)
guiSetVisible(GUIEditor_Window[2],false)
GUIEditor_Button[4] = guiCreateButton(5,105,400,40,"Закрыть",false,GUIEditor_Window[2])
GUIEditor_Button[5] = guiCreateButton(5,62,195,40, "Пижама",false,GUIEditor_Window[2])
GUIEditor_Button[6] = guiCreateButton(205,62,195,40, "Моя одежда",false,GUIEditor_Window[2])

GUIEditor_Label[1] = guiCreateLabel(30,300,400,20, 
	"", false, GUIEditor_Window[1])
GUIEditor_Label[2] = guiCreateLabel(30,30,190,20, 
	"", false, GUIEditor_Window[1])
GUIEditor_Label[3] = guiCreateLabel(30,190,190,20, 
	"", false, GUIEditor_Window[1])
GUIEditor_Label[4] = guiCreateLabel(220,30,190,20, 
	"", false, GUIEditor_Window[1])
GUIEditor_Label[5] = guiCreateLabel(220,190,190,20, 
	"", false, GUIEditor_Window[1])
GUIEditor_Label[6] = guiCreateLabel(410,30,190,20, 
	"", false, GUIEditor_Window[1])
GUIEditor_Label[7] = guiCreateLabel(410,190,190,20, 
	"", false, GUIEditor_Window[1])
	
	function initialize_menu_choices(r_type)

	-- Destroy current images if any
	if img1 and isElement(img1) then destroyElement(img1) end

	-- Make new images, (load from files when needed)
	img1 = guiCreateStaticImage(5,22,195,40, "img/CLUHEAL.png", false,GUIEditor_Window[1])
end
	
function showAmmoGUI( hitPlayer, type )
	if type == "cluckin_bell" then
		guiSetText ( GUIEditor_Window[1], "Cluckin' Bell Menu" )
		guiSetText ( GUIEditor_Button[2], "Cluckin' Little Meal (5$)" )
		guiSetText ( GUIEditor_Button[3], "Cluckin' Big Meal (10$)" )
		guiSetText ( GUIEditor_Button[4], "Cluckin' Huge Meal (25$)" )
		guiSetText ( GUIEditor_Button[5], "Salad Meal (20$)" )
	elseif type == "burger" then
		guiSetText ( GUIEditor_Window[1], "Burger Shot Menu" )
		guiSetText ( GUIEditor_Button[2], "Moo kids Meal (5$)" )
		guiSetText ( GUIEditor_Button[3], "Beef Tower Meal (10$)" )
		guiSetText ( GUIEditor_Button[4], "Meat Stack Meal (25$)" )
		guiSetText ( GUIEditor_Button[5], "Salad Meal (20$)" )
	end
	guiSetVisible ( GUIEditor_Window[1], true )
	showCursor( true )
	initialize_menu_choices(r_type)
end
addEvent("showAmmoGUIHLSodegda",true)
addEventHandler("showAmmoGUIHLSodegda",getRootElement(),showAmmoGUI)

function showAmmoGUI1( hitPlayer, type )
	guiSetVisible ( GUIEditor_Window[2], true )
	showCursor( true )
end
addEvent("showAmmoGUIHLSodegdaBolynoy",true)
addEventHandler("showAmmoGUIHLSodegdaBolynoy",getRootElement(),showAmmoGUI1)

addEventHandler("onClientGUIClick",getRootElement(),
function ( player )
	local player2 = getLocalPlayer()
	local money = getPlayerMoney ( player2 )
   	if (source == GUIEditor_Button[1]) then
   		guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
   	elseif (source == GUIEditor_Button[2]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "HLSodeg", getLocalPlayer(), 0, 24, 35 )
   			cooldown = setTimer (function () end, 800, 1)
  		end
   	elseif (source == GUIEditor_Button[3]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "Meinodeg1", getLocalPlayer(), 0, 24, 35 )
   			cooldown = setTimer (function () end, 800, 1)
  		end
  	end
end)

addEventHandler("onClientGUIClick",getRootElement(),
function ( player )
	local player2 = getLocalPlayer()
	local money = getPlayerMoney ( player2 )
   	if (source == GUIEditor_Button[4]) then
   		guiSetVisible (GUIEditor_Window[2],false)
   		showCursor (false)
   	elseif (source == GUIEditor_Button[5]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "Pizhama", getLocalPlayer(), 0, 24, 35 )
   			cooldown = setTimer (function () end, 800, 1)
  		end
   	elseif (source == GUIEditor_Button[6]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "Meinodeg2", getLocalPlayer(), 0, 24, 35 )
   			cooldown = setTimer (function () end, 800, 1)
  		end
  	end
end)

local timer
function heal ()
local object = getElementsByType ("object", true)
for i, v in ipairs (object) do
	if getElementModel (v) == 1796 then
		local pos1 = Vector3(getElementPosition (localPlayer))
		local pos2 = Vector3(getElementPosition (v))
			local block, anim = getPedAnimation (localPlayer)
			if getElementData(localPlayer, "больной") == true then
				if getElementModel (localPlayer) == 62 then
					if getElementData (localPlayer, "лечится") ~= true then
						if math.min(getDistanceBetweenPoints3D (pos1, pos2)) < 2 then
							if getElementData (v, "занято") ~= true then
								local x, y, z = getElementPosition (localPlayer)
								local x2, y2, z2 = getElementPosition (v)
								rot = findRotation3D (x, y, z, x2, y2, z2)
								if rot > -360 and rot < -270 then
									rot = -270
								elseif rot > -270 and rot < -180 then
									rot = -180
								elseif rot > -180 and rot < -90 then
									rot = - 90
								elseif rot > -90 and rot < 0 then
									rot = 0
								elseif rot > 0 and rot < 90 then
									rot = 90
								elseif rot > 90 and rot < 180 then
									rot = 180
								elseif rot > 180 and rot < 270 then
									rot = 270
								elseif rot > 270 and rot < 360 then
									rot = 0 
								end
								if rot == 0 then
									local rotx, roty, rotz = getElementRotation (v)
									if math.floor(rotz) < 271 and math.floor(rotz) > 268 then
										rot = 0
									elseif math.floor(rotz) < 91 and math.floor(rotz) > 88 then
										rot = 180
									end
								end
								unbindKey ("enter", "down", heal)
								setTimer (function()
								setElementRotation (localPlayer, 0, 0, -rot)
								triggerServerEvent ("attache", localPlayer, "1", localPlayer, v)
								timer = setTimer(reHealth, 1000, 0)
								setElementData (localPlayer, "лечится", true)
								setTimer (function () bindKey ("enter", "down", heal) end, 5000, 1)
								end, 500, 1)
							end
						end
					else
						unbindKey ("enter", "down", heal)
						triggerServerEvent ("attache", localPlayer, "2", localPlayer)
						setElementData (localPlayer, "лечится", false)
						killTimer (timer)
						timer = nil
						setTimer (function () bindKey ("enter", "down", heal) end, 5000, 1)
					end
				end
			end
	end
end
end

addEvent ("checkHLS", true)
addEventHandler ("checkHLS", root, function()
for i, v in ipairs (getElementsByType ("player")) do
	if getElementData (v, "frac") == "HLS" then
		return
	end
end
bindKey ("enter", "down", heal)
end)

function reHealth ()
if getElementHealth (localPlayer) ~= 100 then
setElementHealth (localPlayer, getElementHealth (localPlayer) + 1)
else
triggerServerEvent ("attache", localPlayer, "2", localPlayer)
setElementData (localPlayer, "лечится", false)
if isElement(timer) then
killTimer (timer)
timer = nil
end
unbindKey ("enter", "down", heal)
setElementData (localPlayer, "больной", nil)
end
end

function findRotation3D( x1, y1, z1, x2, y2, z2 ) 
	local rotx = math.atan2 ( z2 - z1, getDistanceBetweenPoints2D ( x2,y2, x1,y1 ) )
	rotx = math.deg(rotx)
	local rotz = -math.deg( math.atan2( x2 - x1, y2 - y1 ) )
	rotz = rotz < 0 and rotz + 360 or rotz
	return rotx, 0,rotz
end

function render ()
for i, v in ipairs (getElementsByType("object", true)) do
if getElementModel (v) == 1796 then
	local pos1 = Vector3(getElementPosition (localPlayer))
	local pos2 = Vector3(getElementPosition (v))
	if math.min(getDistanceBetweenPoints3D (pos1, pos2)) < 1.5 then
		if getElementData (v, "занято") ~= true then
			local screenW, screenH = guiGetScreenSize()
			dxDrawRectangle(screenW * 0.3743, screenH * 0.6689, screenW * 0.2333, screenH * 0.1333, tocolor(0, 0, 0, 107), false)
			dxDrawText("Нажмите F или Enter для того чтобы лечь на койку и \nначать лечение", screenW * 0.3812, screenH * 0.6756, screenW * 0.6007, screenH * 0.7956, tocolor(255, 255, 255, 255), 1.00, "pricedown", "center", "center", false, true, false, false, false)
		end
	end
end
end
end
addEventHandler ("onClientRender", root, render)

function getFreeKoika (db)
if db == "лечится" then
for i, v in ipairs (getElementsByType("player")) do
if getElementModel (v) == 62 then
	--if getElementData (v, "лечится") == true then
		if getElementAttachedTo (v) then
			local id = getElementModel (getElementAttachedTo (v))
			if id == 1796 then
				if not getElementAttachedTo (v) then
					setElementData (getElementAttachedTo (v), "занято", false)
				else
					setElementData (getElementAttachedTo (v), "занято", true)
				end
			end
		end
	--end
end
end
end
end
addEventHandler ("onClientElementDataChange", root, getFreeKoika)