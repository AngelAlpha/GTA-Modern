Markers = createMarker (1657.0137939453,2194.4562988281,9.417999267578, "cylinder", 1.5, 0, 0, 255, 150)
Markers2 = createMarker (-2435.3854980469,1032.7130126953,48.986679077148, "cylinder", 1.5, 0, 0, 255, 150)
Markers3 = createMarker (2486.5532226563,-1463.216796875,22.617364883423, "cylinder", 1.5, 0, 0, 255, 150)
createBlipAttachedTo (Markers, "18", 255, 255, 255, 255, 0, 100)
createBlipAttachedTo (Markers2, "18", 255, 255, 255, 255, 0, 100)
createBlipAttachedTo (Markers3, "18", 255, 255, 255, 255, 0, 100)


local x, y = guiGetScreenSize() 
local fontText = dxCreateFont("font/font.ttf", 10)

show = false
local chek1 = true
local chek2 = true
local chek3 = true
local chek4 = true
--[[local chek5 = true
local chek6 = true
local chek7 = true
local chek8 = true]]--
local scroll = (x-280)+105

function tonerWindow ()
	if not getPedOccupiedVehicle (localPlayer) then show = false showCursor(false) removeEventHandler("onClientRender", root,tonerWindow) return end
	dxDrawWindow( (x-340), (y-200), 330, 180, "ТОНИРОВКА")
	
	--dxDrawText(	"ЦВЕТ ТОНИРОВКИ", (x-175), (y-260), (x-175), (y-260), tocolor(255, 255, 255, 255), 1, 1, fontText, "center", "center", false, false, true, false, false)
	
	-- выделение выбора тонировки
	--if xR and yR then dxDrawRectangle( xR, yR, 44, 44, tocolor(255, 255, 255, 255), false) end
	
	--dxDrawImage ( (x-330), (y-240), 40, 40, "shader/texture1.png" )
	--dxDrawImage ( (x-280), (y-240), 40, 40, "shader/texture2.png" )
	--dxDrawImage ( (x-230), (y-240), 40, 40, "shader/texture3.png" )
	--dxDrawImage ( (x-160), (y-240), 40, 40, "shader/texture4.png" )
	--dxDrawImage ( (x-110), (y-240), 40, 40, "shader/texture5.png" )
	--dxDrawImage ( (x-60), (y-240), 40, 40, "shader/texture6.png" )
	
	dxDrawText(	"ПРОЗРАЧНОСТЬ", (x-170), (y-145), (x-170), (y-145), tocolor(255, 255, 255, 255), 1, 1, fontText, "center", "center", false, false, true, false, false)
	dxDrawScrollBar ( (x-280), (y-130), 210, 10, scroll )
	dxDrawText(	"0", (x-295), (y-125), (x-295), (y-125), tocolor(255, 255, 255, 255), 1, 1, fontText, "center", "center", false, false, true, false, false)
	dxDrawText(	"100", (x-50), (y-125), (x-50), (y-125), tocolor(255, 255, 255, 255), 1, 1, fontText, "center", "center", false, false, true, false, false)
	--dxDrawText(	"Для закрытия окна нажмити правую кнопку мыши", (x-180), (y-30), (x-170), (y-30), tocolor(255, 255, 255, 255), 0.8, 0.8, fontText, "center", "center", false, false, true, false, false)
	dxDrawText(	math.floor(scrollProcent or 50).."%", (x-165), (y-60), (x-165), (y-145), tocolor(255, 255, 255, 255), 1, 1, fontText, "center", "center", false, false, true, false, false)
		
	dxDrawButton( (x-305), (y-50), 290, 25, "Установить")
	dxDrawButton( (x-335), (y-50), 25, 25, "Х")
	
	dxDrawCheckButton( (x-330), (y-90), 15, 15, "Лобовое", chek1 )
	dxDrawCheckButton( (x-330), (y-70), 15, 15, "Передние", chek2 )
	dxDrawCheckButton( (x-160), (y-70), 15, 15, "Задние", chek3 )
	dxDrawCheckButton( (x-160), (y-90), 15, 15, "Все", chek4 )
	--[[dxDrawCheckButton( (x-160), (y-110), 15, 15, "Заднее правое стекло", chek5 )
	dxDrawCheckButton( (x-160), (y-90), 15, 15, "Заднее стекло", chek6 )
	dxDrawCheckButton( (x-160), (y-70), 15, 15, "Выбрать все", chek7 )
	dxDrawCheckButton( (x-330), (y-70), 15, 15, "Люк", chek8 )]]--
end

function tonerWindowS ()
	if not getPedOccupiedVehicle (localPlayer) then show = false showCursor(false) removeEventHandler("onClientRender", root, tonerWindowS) return end
	local x1, y1, sx1, sy1 = getOriginalProcentOfText (471, 364, 498, 127)
	local x2, y2, sx2, sy2 = getOriginalProcentOfText (490, 457, 224, 24)
	local x3, y3, sx3, sy3 = getOriginalProcentOfText (730, 457, 224, 24)
	local x4, y4, sx4, sy4 = getOriginalProcentOfText (483, 395, 959, 436)
	
	dxDrawWindow( x1, y1, sx1, sy1, "ТОНИРОВКА")

	dxDrawText(	"Желаете ли вы приобрести тонировку?", x4, y4, sx4, sy4, tocolor(255, 255, 255, 255), 1.3, 1, fontText, "center", "center", false, false, true, false, false)

	dxDrawButton(x3, y3, sx3, sy3, "Установить")
	dxDrawButton(x2, y2, sx2, sy2, "Закрыть")
end

local sx, sy = guiGetScreenSize()
local scx, scy = (sx / 100), (sy / 100)
function getOriginalProcentOfText (xscreen, yscreen, sx, sy)
    local x, sx = (xscreen / 14.4) * scx, (sx / 14.4) * scx
	local y, sy = (yscreen / 9) * scy, (sy / 9) * scy
	return x, y, sx, sy
end

function showTonerWindow (element)
	if getElementType(element) == "vehicle" then
		if not getElementData(localPlayer,"showNumberWindow") then
			if getPlayerMoney () > 499 then
				triggerServerEvent ("aw", getVehicleOccupant(getPedOccupiedVehicle(localPlayer)), getVehicleOccupant(getPedOccupiedVehicle(localPlayer)), 500) 
				if not getPedOccupiedVehicle (localPlayer) then return end
					if show == true then
						if getElementData(localPlayer,"showNumberWindow") then return end
						addEventHandler ("onClientRender", root, tonerWindow)
						if getElementData (getPedOccupiedVehicle(localPlayer), "toner:toner" ) then
							local toner = getElementData (getPedOccupiedVehicle(localPlayer), "toner:type" ) 
							if toner == 1 then xR, yR = (x-332), (y-242)
							elseif toner == 2 then xR, yR = (x-282), (y-242)
							elseif toner == 3 then xR, yR = (x-232), (y-242)
							elseif toner == 4  then xR, yR = (x-162), (y-242)
							elseif toner == 5 then xR, yR = (x-112), (y-242)
							elseif toner == 6 then xR, yR = (x-62), (y-242)
							end	
						setElementData (getPedOccupiedVehicle(localPlayer),"toner:alpha", getElementData(getPedOccupiedVehicle(localPlayer),"toner:alpha"))
						end
					end
				end
			else
			outputChatBox ("Недостасточно денег", 255, 0, 0)
		end
	end
end

local target
function showTon (element)
if element == localPlayer and getPedOccupiedVehicle (element) and getVehicleOccupant (getPedOccupiedVehicle (element)) == localPlayer then
		if not isEventHandlerAdded("onClientRender", root, tonerWindowS) then
			showCursor (true)
			addEventHandler ("onClientRender", root, tonerWindowS)
			show = true
		else
			showCursor (false)
			removeEventHandler ("onClientRender", root, tonerWindowS)
			show = false
		end
end
end
addEventHandler( "onClientMarkerHit", Markers, showTon )
addEventHandler( "onClientMarkerHit", Markers2, showTon )
addEventHandler( "onClientMarkerHit", Markers3, showTon )

function getVehicleOccupantsF (veh)
if veh then
local countSeat = 0
target = nil
local occ = getVehicleOccupants(veh) or {}
	for seat, player in pairs (occ) do
		if player ~= localPlayer then
		target = player
		countSeat = countSeat + 1
		end
	end
	return countSeat
end
end 

--[[bindKey("mouse2", "down", function ()
	if not show then return end
	if isCursorShowing() then
		showCursor(false)
		--show = false
		--removeEventHandler("onClientRender", root,tonerWindow)
		--chek1 = true
		--chek2 = true
		--chek3 = true
		--chek4 = true
		--chek5 = true
		--chek6 = true
		---chek7 = true
		--chek8 = true
	end
end)]]



addEventHandler( "onClientClick", root, function(button, state, vehicle)
	if not show then return end
	if button == "left" and state == "down" then
		local x2, y2, sx2, sy2 = getOriginalProcentOfText (490, 457, 224, 24)
		local x3, y3, sx3, sy3 = getOriginalProcentOfText (730, 457, 224, 24)
		if cursorPosition(x3, y3, sx3, sy3)  then
			if getPlayerMoney () > 499 then
			removeEventHandler("onClientRender", root,tonerWindowS)
			showTonerWindow (getPedOccupiedVehicle(localPlayer))
			chek1 = true
			chek2 = true
			chek3 = true
			chek4 = true
			end
		end
		if cursorPosition (x2, y2, sx2, sy2) then
			showCursor(false)
			show = false
			removeEventHandler("onClientRender", root,tonerWindowS)
			chek1 = true
			chek2 = true
			chek3 = true
			chek4 = true
		end
		if cursorPosition ((x-305), (y-50), 290, 25) then
			showCursor(false)
			show = false
			removeEventHandler("onClientRender", root,tonerWindow)
			chek1 = true
			chek2 = true
			chek3 = true
			chek4 = true
		end
		-- чек боксы
		if cursorPosition ((x-330), (y-90), 15, 15) then if chek1 then  chek1 = false playSoundFrontEnd (2) else chek1 = true playSoundFrontEnd (1) end
		elseif cursorPosition ((x-330), (y-70), 15, 15) then if chek2 then chek2 = false playSoundFrontEnd(2) else chek2 = true  playSoundFrontEnd(1) end
		elseif cursorPosition ((x-160), (y-70), 15, 15) then if chek3 then chek3 = false playSoundFrontEnd(2) else chek3 = true playSoundFrontEnd(1) end
		elseif cursorPosition ((x-160), (y-90), 15, 15) then if chek4 then chek4 = false playSoundFrontEnd(2) else chek4 = true playSoundFrontEnd(1) end
		--[[elseif cursorPosition ((x-160), (y-110), 15, 15) then if chek5 then chek5 = false playSoundFrontEnd(2) else chek5 = true playSoundFrontEnd(1) end
		elseif cursorPosition ((x-160), (y-90), 15, 15) then if chek6 then chek6 = false playSoundFrontEnd(2) else chek6 = true playSoundFrontEnd(1) end
		elseif cursorPosition((x-330), (y-70), 15, 15) then if chek8 then chek8 = false playSoundFrontEnd(2) else chek8 = true playSoundFrontEnd(1) end]]--
		elseif cursorPosition ((x-160), (y-130), 15, 15) then 
			if chek4 then 
				chek1 = false chek2 = false chek3 = false chek4 = false playSoundFrontEnd (2)
			else
				chek1 = true chek2 = true chek3 = true chek4 = true playSoundFrontEnd (1)
			end
		end
		--if not toner then return outputChatBox ("Выберите цвет тонировки!", 255, 0, 0) end
		setElementData (getPedOccupiedVehicle(localPlayer), "toner:type", 1 )
		setElementData (getPedOccupiedVehicle(localPlayer), "toner:toner", true )
		if cursorPosition( (x-335), (y-50), 25, 25 ) then 
			showCursor(false)
			show = false
			removeEventHandler("onClientRender", root,tonerWindow)
			executeCommandHandler ("showHud")
			--setVehicleFrozen (getPedOccupiedVehicle(localPlayer), false)
		end
	end
end)

addEventHandler( "onClientClick", root, function(button, state)
	if button == "left" and state == "down" then
		local x, y, w, h = x-280, y-130, 210, 10 
		if cursorPosition( scroll, y-5, 10, h+10 ) then
			scrollMoving = true
		else
			if scroll <= x then
				if cursorPosition( x, y-5, 10, h+10 ) then
					scrollMoving = true
				end
			else
				if cursorPosition( (x+w)-10, y-5, 10, h+10 ) then
					scrollMoving = true
				end
			end
		end
	elseif button == "left" and state == "up" then
		if scrollMoving then
			scrollMoving = false
		end
	end
end)

addEventHandler( "onClientCursorMove", getRootElement( ), function ( _, _, xMove )
    if scrollMoving then
		scroll = xMove
	end
end)

-- tzad
-- tpravozad
-- tpravopered
-- tlob
-- tlevozad
-- tlevopered
-- tluk

local tonerShader = {}

function setPlayerVehicleToner ( vehicle, toner )
	if not tonerShader[vehicle] then
		tonerShader[vehicle] = {}
	end
	-- тонировка переднего стекла
	if chek1 then
		tonerShader[vehicle]["lob_steklo"] = dxCreateShader("shader/shader.fx")
		engineApplyShaderToWorldTexture(tonerShader[vehicle]["lob_steklo"], "lob_steklo", vehicle)
		dxSetShaderValue(tonerShader[vehicle]["lob_steklo"], "gTexture", dxCreateTexture("shader/texture1.png") ) 
		dxSetShaderValue(tonerShader[vehicle]["lob_steklo"], "gAlpha", getElementData(vehicle, "toner:alpha" ) ) 
	end
	-- тонировка переднего левого стекла
	if chek2 then
		tonerShader[vehicle]["pered_steklo"] = dxCreateShader("shader/shader.fx")
		engineApplyShaderToWorldTexture(tonerShader[vehicle]["pered_steklo"], "pered_steklo", vehicle)
		dxSetShaderValue(tonerShader[vehicle]["pered_steklo"], "gTexture", dxCreateTexture("shader/texture1.png") ) 
		dxSetShaderValue(tonerShader[vehicle]["pered_steklo"], "gAlpha", getElementData(vehicle, "toner:alpha" ) ) 
	end
	-- тонировка переднего правого стекла
	if chek3 then
		tonerShader[vehicle]["zad_steklo"] = dxCreateShader("shader/shader.fx")
		engineApplyShaderToWorldTexture(tonerShader[vehicle]["zad_steklo"], "zad_steklo", vehicle)
		dxSetShaderValue(tonerShader[vehicle]["zad_steklo"], "gTexture", dxCreateTexture("shader/texture1.png") ) 
		dxSetShaderValue(tonerShader[vehicle]["zad_steklo"], "gAlpha", getElementData(vehicle, "toner:alpha" ) ) 
	end
end

addEventHandler ( "onClientElementDataChange", getRootElement(),
function ( dataName )
	if getElementType ( source ) == "vehicle" and dataName == "toner:alpha" then
		if getElementData( source, "toner:toner" ) then
			setPlayerVehicleToner ( source, getElementData( source, "toner:type" ) )
		end
	elseif getElementType ( source ) == "vehicle" and dataName == "toner:type" then
		setPlayerVehicleToner ( source, getElementData( source, "toner:type" ) )
	end
end )

addEventHandler( "onClientElementStreamIn", getRootElement(), function ()
    if getElementType( source ) == "vehicle" then
		if not getElementData (source, "toner:toner" ) then return end
		setPlayerVehicleToner ( source, getElementData( source, "toner:type" ) )
    end
end)

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
     if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
          local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
          if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
               for i, v in ipairs( aAttachedFunctions ) do
                    if v == func then
        	         return true
        	    end
	       end
	  end
     end
     return false
end