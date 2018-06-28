local Markers = createMarker( 1446.71960, -1723.66187, 13.54688, "cylinder", 3, 255, 255, 255, 150 )

local x, y = guiGetScreenSize() 
local fontText = dxCreateFont("font/font.ttf", 8)

show = false
local chek1 = true
local chek2 = true
local chek3 = true
local chek4 = true
local chek5 = true
local chek6 = true
local chek7 = true
local chek8 = true
local scroll = (x-280)+105

function tonerWindow ()
	if not getPedOccupiedVehicle (localPlayer) then show = false showCursor(false) removeEventHandler("onClientRender", root,tonerWindow) return end
	dxDrawWindow( (x-340), (y-310), 330, 290, "ВЫБОР ТОНИРОВКИ")
	
	dxDrawImage ( (x-445), (y-200), 512, 128, "font/icon.png", 0, 0, 0, tocolor(255, 255, 255, 40) ) -- logo
	
	dxDrawText(	"ЦВЕТ ТОНИРОВКИ", (x-175), (y-260), (x-175), (y-260), tocolor(255, 255, 255, 255), 1, 1, fontText, "center", "center", false, false, true, false, false)
	
	-- выделение выбора тонировки
	if xR and yR then dxDrawRectangle( xR, yR, 44, 44, tocolor(255, 255, 255, 255), false) end
	
	dxDrawImage ( (x-330), (y-240), 40, 40, "shader/texture1.png" )
	dxDrawImage ( (x-280), (y-240), 40, 40, "shader/texture2.png" )
	dxDrawImage ( (x-230), (y-240), 40, 40, "shader/texture3.png" )
	dxDrawImage ( (x-160), (y-240), 40, 40, "shader/texture4.png" )
	dxDrawImage ( (x-110), (y-240), 40, 40, "shader/texture5.png" )
	dxDrawImage ( (x-60), (y-240), 40, 40, "shader/texture6.png" )
	
	dxDrawText(	"ПРОЗРАЧНОСТЬ", (x-170), (y-185), (x-170), (y-185), tocolor(255, 255, 255, 255), 1, 1, fontText, "center", "center", false, false, true, false, false)
	dxDrawScrollBar ( (x-280), (y-170), 210, 10, scroll )
	dxDrawText(	"0", (x-295), (y-165), (x-295), (y-165), tocolor(255, 255, 255, 255), 1, 1, fontText, "center", "center", false, false, true, false, false)
	dxDrawText(	"100", (x-50), (y-165), (x-50), (y-165), tocolor(255, 255, 255, 255), 1, 1, fontText, "center", "center", false, false, true, false, false)
	--dxDrawText(	"Для закрытия окна нажмити правую кнопку мыши", (x-180), (y-30), (x-170), (y-30), tocolor(255, 255, 255, 255), 0.8, 0.8, fontText, "center", "center", false, false, true, false, false)
	dxDrawText(	math.floor(scrollProcent or 50).."%", (x-165), (y-145), (x-165), (y-145), tocolor(255, 255, 255, 255), 1, 1, fontText, "center", "center", false, false, true, false, false)
	
	dxDrawButton( (x-305), (y-50), 290, 25, "Установить за 20000$")
	dxDrawButton( (x-335), (y-50), 25, 25, "Х")
	
	dxDrawCheckButton( (x-330), (y-130), 15, 15, "Лобовое стекло", chek1 )
	dxDrawCheckButton( (x-330), (y-110), 15, 15, "Передняя полусфера", chek2 )
	dxDrawCheckButton( (x-330), (y-90), 15, 15, "Задняя полусфера", chek3 )
	dxDrawCheckButton( (x-160), (y-130), 15, 15, "Выбрать все", chek4 )
	--[[dxDrawCheckButton( (x-160), (y-110), 15, 15, "Заднее правое стекло", chek5 )
	dxDrawCheckButton( (x-160), (y-90), 15, 15, "Заднее стекло", chek6 )
	dxDrawCheckButton( (x-160), (y-70), 15, 15, "Выбрать все", chek7 )
	dxDrawCheckButton( (x-330), (y-70), 15, 15, "Люк", chek8 )]]--
end

function showTonerWindow (element)
	if element == localPlayer then
	if not getPedOccupiedVehicle (localPlayer) then return end
	if show == false then
		if getElementData(localPlayer,"showNumberWindow") then return end
		show = true
		showCursor(true)
		addEventHandler("onClientRender", root, tonerWindow)
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
end
addEventHandler( "onClientMarkerHit", Markers, showTonerWindow )

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
	--[[if button == "left" and state == "down" then
		-- цвет тонера
		if cursorPosition( (x-330), (y-240), 40, 40 ) then 
			toner = 1 
			xR, yR = (x-332), (y-242)
			playSoundFrontEnd (1) 
		elseif cursorPosition( (x-280), (y-240), 40, 40 ) then 
			toner = 2
			xR, yR = (x-282), (y-242)
			playSoundFrontEnd (1) 
		elseif cursorPosition( (x-230), (y-240), 40, 40 ) then
			toner = 3 
			xR, yR = (x-232), (y-242)
			playSoundFrontEnd (1) 
		elseif cursorPosition( (x-160), (y-240), 40, 40 ) then 
			toner = 4 
			xR, yR = (x-162), (y-242)
			playSoundFrontEnd (1) 
		elseif cursorPosition( (x-110), (y-240), 40, 40 ) then 
			toner = 5 
			xR, yR = (x-112), (y-242)
			playSoundFrontEnd (1) 
		elseif cursorPosition( (x-60), (y-240), 40, 40 ) then 
			toner = 6 
			xR, yR = (x-62), (y-242)
			playSoundFrontEnd (1)]]--
		elseif cursorPosition( (x-305), (y-50), 290, 25) then
	
		if getPlayerMoney () > 19999 then
			showCursor(false)
			show = false
			removeEventHandler("onClientRender", root,tonerWindow)
			chek1 = true
			chek2 = true
			chek3 = true
			chek4 = true
			--chek5 = true
			--chek6 = true
			--chek7 = true
			--chek8 = true
			triggerServerEvent("aw", getRootElement(), localPlayer, 20000 )
			else
				outputChatBox("Недостаточно средств!",0,0,255,true)
		end
		end
		-- чек боксы
		if cursorPosition ((x-330), (y-130), 15, 15) then if chek1 then  chek1 = false playSoundFrontEnd (2) else chek1 = true playSoundFrontEnd (1) end
		elseif cursorPosition ((x-330), (y-110), 15, 15) then if chek2 then chek2 = false playSoundFrontEnd(2) else chek2 = true  playSoundFrontEnd(1) end
		elseif cursorPosition ((x-330), (y-90), 15, 15) then if chek3 then chek3 = false playSoundFrontEnd(2) else chek3 = true playSoundFrontEnd(1) end
		elseif cursorPosition ((x-160), (y-130), 15, 15) then if chek4 then chek4 = false playSoundFrontEnd(2) else chek4 = true playSoundFrontEnd(1) end
		--[[elseif cursorPosition ((x-160), (y-110), 15, 15) then if chek5 then chek5 = false playSoundFrontEnd(2) else chek5 = true playSoundFrontEnd(1) end
		elseif cursorPosition ((x-160), (y-90), 15, 15) then if chek6 then chek6 = false playSoundFrontEnd(2) else chek6 = true playSoundFrontEnd(1) end
		elseif cursorPosition((x-330), (y-70), 15, 15) then if chek8 then chek8 = false playSoundFrontEnd(2) else chek8 = true playSoundFrontEnd(1) end]]--
		elseif cursorPosition ((x-160), (y-70), 15, 15) then 
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
		end
	end
end)

addEventHandler( "onClientClick", root, function(button, state)
	if button == "left" and state == "down" then
		local x, y, w, h = x-280, y-170, 210, 10 
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
	--[[-- тонировка заднего левого стекла
	if chek4 then
		tonerShader[vehicle]["tlevozad"] = dxCreateShader("shader/shader.fx")
		engineApplyShaderToWorldTexture(tonerShader[vehicle]["tlevozad"], "tlevozad", vehicle)
		dxSetShaderValue(tonerShader[vehicle]["tlevozad"], "gTexture", dxCreateTexture("shader/texture"..toner..".png") ) 
		dxSetShaderValue(tonerShader[vehicle]["tlevozad"], "gAlpha", getElementData(vehicle, "toner:alpha" ) ) 
	end
	-- тонировка заднего правого стекла
	if chek5 then
		tonerShader[vehicle]["tpravozad"] = dxCreateShader("shader/shader.fx")
		engineApplyShaderToWorldTexture(tonerShader[vehicle]["tpravozad"], "tpravozad", vehicle)
		dxSetShaderValue(tonerShader[vehicle]["tpravozad"], "gTexture", dxCreateTexture("shader/texture"..toner..".png") ) 
		dxSetShaderValue(tonerShader[vehicle]["tpravozad"], "gAlpha", getElementData(vehicle, "toner:alpha" ) ) 
	end
	-- тонировка заднего стекла
	if chek6 then
		tonerShader[vehicle]["tzad"] = dxCreateShader("shader/shader.fx")
		engineApplyShaderToWorldTexture(tonerShader[vehicle]["tzad"], "tzad", vehicle)
		dxSetShaderValue(tonerShader[vehicle]["tzad"], "gTexture", dxCreateTexture("shader/texture"..toner..".png") ) 
		dxSetShaderValue(tonerShader[vehicle]["tzad"], "gAlpha", getElementData(vehicle, "toner:alpha" ) ) 
	end
	-- тонировка люка
	if chek8 then
		tonerShader[vehicle]["tluk"] = dxCreateShader("shader/shader.fx")
		engineApplyShaderToWorldTexture(tonerShader[vehicle]["tluk"], "tluk", vehicle)
		dxSetShaderValue(tonerShader[vehicle]["tluk"], "gTexture", dxCreateTexture("shader/texture"..toner..".png") ) 
		dxSetShaderValue(tonerShader[vehicle]["tluk"], "gAlpha", getElementData(vehicle, "toner:alpha" ) ) 
	end]]--
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