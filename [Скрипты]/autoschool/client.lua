font = dxCreateFont("ui/font.otf", 25)
font2 = dxCreateFont("ui/font.otf", 22)
font3 = dxCreateFont("ui/font.otf", 20)
x,y = guiGetScreenSize()

marker = createMarker(markerGUI[1],markerGUI[2], markerGUI[3]-1, "cylinder", 1.5, 72,159,204,150,true)
createBlipAttachedTo (marker, 5)
addEventHandler("onClientMarkerHit", marker, function(element)
	if element ~= localPlayer then return end
	veh = getPedOccupiedVehicle(localPlayer)
	if not veh then
		addEventHandler("onClientRender", root, drawGUI)
		drawIn = false
		guiType = "gui1"
		showCursor(true)
	end
end)

prava = {
	{"легковой", 250, "cars"},
	{"пассажирский", 350, "passangers"},
	{"мотоциклы", 50, "moto"},
	{"грузовой", 250, "gruz"},
}

local scx, scy = guiGetScreenSize()
local px, py = scx/700, scy/800
local iGridX, iGridY, iGridW, iGridH = x / 2 - (486/2), y / 2 - 150, 307, 300
function isCursorOverRectangle(x,y,w,h)
	if isCursorShowing() then
		local mx,my = getCursorPosition() -- relative
		cursorx,cursory = mx*scx,my*scy
		if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
			return true
		end
	end
	return false
end

addEventHandler("onClientVehicleStartExit",getRootElement(),
	function (player, seat)
	    if player ~= localPlayer then return end
	    if seat ~= 0 then return end
    	if getElementData(source, "OwnerSchool") and getElementData(source, "OwnerSchool") == player then
    		removeEventHandler("onClientRender", root, drawStatistic)
    		outputChatBox("[#FF0022Автошкола#ffffff]Вы не сдали экзамен!",255,255,255,true)
			if getElementData(localPlayer, "OwnerSchool") then
				setElementData (localPlayer, "OwnerSchool", nil)
			end
    		if getElementData(localPlayer,"marker_school") then
    			destroyElement(getElementData(localPlayer,"marker_school"))
    		end
    		if getElementData(localPlayer,"blip_school") then
    			destroyElement(getElementData(localPlayer,"blip_school"))
    		end
			triggerServerEvent("stopDriving", player, source)
    	end
    end
)

image = {}
image["gui1"] = "ui/gui1/gui.png"
image["gui1_but1"] = "ui/gui1/but1.png"
image["gui1_but3"] = "ui/gui1/but3.png"
image["gui1_but2"] = "ui/gui1/but2.png"
image["gui1_but4"] = "ui/gui1/but4.png"

image["gui2"] = "ui/gui2/gui.png"
image["gui2_butGrid1"] = "ui/gui2/butGrid1.png"
image["gui2_butGrid2"] = "ui/gui2/butGrid2.png"
image["gui2_but1"] = "ui/gui2/but1.png"
image["gui2_but2"] = "ui/gui2/but2.png"

local bClicked = false
local iCurrentCell = 0

function drawGUI()
	dxDrawImage(-1, -1, x+1, y+1, "ui/image/zad.png")
	if guiType == "gui1" then
		dxDrawImage(x / 2 - ((552)/2), y / 2 - ((492)/2), 552, 492, image.gui1)
		dxDrawImage(x / 2 - (236)-10,y / 2 + 170,236,41, image.gui1_but1)
		if isCursorOverRectangle(x / 2 - (236)-10,y / 2 + 170,236,41) then
			dxDrawImage(x / 2 - (236)-10,y / 2 + 170,236,41, image.gui1_but3)
			if getKeyState("mouse1") then
				if bClicked == false then
					bClicked = true
					guiType = "gui2"
				end
			else
				bClicked = false
			end
		end
		dxDrawImage(x / 2+10,y / 2 + 170,236,41, image.gui1_but2)
		if isCursorOverRectangle(x / 2+10,y / 2 + 170,236,41) then
			dxDrawImage(x / 2+10,y / 2 + 170,236,41, image.gui1_but4)
			if getKeyState("mouse1") then
				if bClicked == false then
					bClicked = true
					guiType = nil
					removeEventHandler("onClientRender", root, drawGUI)
					showCursor(false)
				end
			else
				bClicked = false
			end
		end
	end
	if guiType == "gui2" then
		dxDrawImage(x / 2 - ((552)/2), y / 2 - ((492)/2), 552, 492, image.gui2)
		dxDrawImage(x / 2+10,y / 2 + 170,236,41, image.gui1_but2)
		if isCursorOverRectangle(x / 2+10,y / 2 + 170,236,41) then
			dxDrawImage(x / 2+10,y / 2 + 170,236,41, image.gui1_but4)
			if getKeyState("mouse1") then
				if bClicked == false then
					bClicked = true
					guiType = "gui1"
				end
			else
				bClicked = false
			end
		end
		iRows = #prava
		iVisibleRows = 4
		iCellHeight = 65
		for i = iCurrentCell, iVisibleRows+iCurrentCell-1 do
			dxDrawImage(x / 2 - (236)-10,y / 2 + 170,236,41, image.gui2_but1)
			if isCursorOverRectangle(x / 2 - (236)-10,y / 2 + 170,236,41) then
				dxDrawImage(x / 2 - (236)-10,y / 2 + 170,236,41, image.gui2_but2)
				if getKeyState("mouse1") then
					if price then
						if bClicked == false then
							bClicked = true
							for s, data in pairs(prava) do
								if i == s - 1 then
									if getPlayerMoney(localPlayer) >= tonumber(price) then
										for _,p in pairs(points[dataName]) do
											veh = p[1]
										end
										triggerServerEvent("startDriving", localPlayer, dataName, price, veh)
										guiType = nil
										removeEventHandler("onClientRender", root, drawGUI)
										showCursor(false)
									else
										guiType = "gui3"
										notMoney = tonumber(price - getPlayerMoney(localPlayer))
									end
								end
							end
						end
					end
				else
					bClicked = false
				end
			end
			visibleI = i  - iCurrentCell
			local textColor = tocolor(0,0,0,255)
			if drawIn then
				if i == drawIn then
					if price then
						dxDrawImage(iGridX + 19.7, iGridY+iCellHeight*visibleI + 25.5, 21,21, "ui/gui2/around2.png" )
						priceInZero = string.gsub(tostring(price), "^(-?%d+)(%d%d%d)", "%1 %2")
						priceInZero = string.gsub(tostring(priceInZero), "^(-?%d+)(%d%d%d)", "%1 %2")
						priceInZero = string.gsub(tostring(priceInZero), "^(-?%d+)(%d%d%d)", "%1 %2")
						dxDrawText("Цена: "..priceInZero.." $", iGridX, iGridY+ 290, iGridX + 70, iGridY+ 290, tocolor(255,255,255,255), 0.65, font2, "left", "center")
					end
				end
			end
			if iRows < 6 then
				scrollThen = 1
				with = 0
				notScroll = true
			else
				scrollThen = iRows
				with = 334/scrollThen*iVisibleRows
			end
			dxDrawRectangle(iGridX+iGridW + 20, iGridY+iGridH/scrollThen*iCurrentCell, 10, with, tocolor(0,0,0,255), true)
			if isCursorOverRectangle(iGridX, iGridY+iCellHeight*visibleI + 12, 486,50) then
				for s, data in pairs(prava) do
					if i == s - 1 then
						if not getElementData(localPlayer, data[3]) then
							dxDrawImage(iGridX, iGridY+iCellHeight*visibleI + 12, 486,50, image.gui2_butGrid2 )
						end
					end
				end
				if getKeyState("mouse1") then
					if bClicked == false then
						for s, data in pairs(prava) do
							if i == s - 1 then
								if not getElementData(localPlayer, data[3]) then
									drawIn = i
									price = data[2]
									dataName = data[3]
									bClicked = true
								end
							end
						end
					end
				else
					bClicked = false
				end
			end
			for s, data in pairs(prava) do
				if i == s - 1 then
					if not getElementData(localPlayer, data[3]) then
						dxDrawImage(iGridX, iGridY+iCellHeight*visibleI + 12, 486,50, image.gui2_butGrid1 )
						dxDrawImage(iGridX + 15, iGridY+iCellHeight*visibleI + 21, 30,30, "ui/gui2/around1.png" )
					else
						dxDrawImage(iGridX + 15, iGridY+iCellHeight*visibleI + 21, 30,30, "ui/gui2/around1.png",0,0,0, tocolor(255,255,255,50) )
						dxDrawImage(iGridX, iGridY+iCellHeight*visibleI + 12, 486,50, image.gui2_butGrid1,0,0,0, tocolor(255,255,255,50) )
					end
					if getElementData(localPlayer, data[3]) then
					 	if getElementData(localPlayer, data[3]) == true then
					 		dxDrawImage(iGridX + 320, iGridY+iCellHeight*visibleI + 20, 138,33, "ui/gui2/pol.png")
					 	end
					else
					 	dxDrawImage(iGridX + 320, iGridY+iCellHeight*visibleI + 20, 138,33, "ui/gui2/nepol.png" )
					end
					dxDrawText(data[1], iGridX + 70, iGridY+iCellHeight*visibleI + 8, iGridX+iGridW + 1, iGridY+iCellHeight*(visibleI+1) + 1, tocolor(255,255,255,255), 0.65, font, "left", "center")
				end
			end
		end
	end
	if guiType == "gui3" then
		if notMoney then
			notMoneyZero = string.gsub(tostring(notMoney), "^(-?%d+)(%d%d%d)", "%1 %2")
			notMoneyZero = string.gsub(tostring(notMoneyZero), "^(-?%d+)(%d%d%d)", "%1 %2")
			notMoneyZero = string.gsub(tostring(notMoneyZero), "^(-?%d+)(%d%d%d)", "%1 %2")
			dxDrawImage(x/2 - 173, y / 2 - 68, 346,136, "ui/gui3/gui.png" )	
			dxDrawText("У Вас не хватает "..notMoneyZero.." руб.", x/2, y/2 - 10, x/2, y/2 - 10, tocolor(255,255,255,255), 0.65, font3, "center", "center")
			dxDrawImage(x/2 - (238/2), y / 2 + 20, 238,36, "ui/gui3/close1.png" )
			if isCursorOverRectangle(x/2 - (238/2), y / 2 + 20, 238,36) then
				dxDrawImage(x/2 - (238/2), y / 2 + 20, 238,36, "ui/gui3/close2.png" )
				if getKeyState("mouse1") then
					if bClicked == false then
						bClicked = true
						guiType = "gui2"
					end
				else
					bClicked = false
				end
			end
		else
			guiType = nil
			removeEventHandler("onClientRender", root, drawGUI)
			showCursor(false)
		end
	end
end


bindKey("mouse_wheel_up", "down", function()
	if isTestable ~= true then return end
	if notScroll == true then return end
	if isCursorOverRectangle(iGridX, iGridY, iGridW + 30, 335) then
		iCurrentCell = iCurrentCell - 1
		if iCurrentCell < 0 then iCurrentCell = 0 end
	end
end)
bindKey("mouse_wheel_down", "down", function()
	if isTestable ~= true then return end
	if notScroll == true then return end
	if isCursorOverRectangle(iGridX, iGridY, iGridW + 30, 335) then
		iCurrentCell = iCurrentCell + 1
		if iCurrentCell > iRows-iVisibleRows then iCurrentCell = iRows-iVisibleRows end
	end
end)

addEvent("startPoints", true)
addEventHandler("startPoints", getRootElement(), function(veh, type)
	if source == localPlayer then
		point = 0
		startPoints(type)
		minutes = 0
		secundes = 0
		addEventHandler("onClientRender", root, drawStatistic)
	end
end)

function startPoints(name)
	if not isTimer(timer) then
		timer = setTimer(function()
			if secundes then
				if tonumber(secundes) >= 60 then
					minutes = minutes + 1
					secundes = 0
				end
				secundes = secundes + 1
			end
		end, 1000,0)
	end
	point = point + 1
	pointNames = points[name]["markers"]
	pos = pointNames[point]
	marker = createMarker(pos[1],pos[2],pos[3],"corona", 1.5,72,159,204,200,true)
	blip = createBlipAttachedTo ( marker, 41 )
	setElementData(localPlayer, "marker_school", marker)
	setElementData(localPlayer, "blip_school", blip)
	addEventHandler("onClientMarkerHit", marker, function(src)
		if src ~= localPlayer then return end
		veh = getPedOccupiedVehicle(localPlayer)
		if not veh then return end
		if getElementData(veh, "OwnerSchool") ~= localPlayer then return end
		destroyElement(marker)
		destroyElement(blip)
		if point == #pointNames then
			if name == "cars" then
				outputChatBox("[#FF0022Автошкола#ffffff]Вы закончили экзамен на легковой транспорт!",255,255,255,true)
			end
			if name == "moto" then
				outputChatBox("[#FF0022Автошкола#ffffff]Вы закончили экзамен на мототранспорт!",255,255,255,true)
			end
			if name == "passangers" then
				outputChatBox("[#FF0022Автошкола#ffffff]Вы закончили экзамен на пассажирский транспорт!",255,255,255,true)
			end
			if name == "gruz" then
				outputChatBox("[#FF0022Автошкола#ffffff]Вы закончили экзамен на грузовой транспорт!",255,255,255,true)
			end
			setElementData(localPlayer,name,true)
			if isTimer(timer) then killTimer(timer) end
			removeEventHandler("onClientRender", root, drawStatistic)
			triggerServerEvent("stopDriving", localPlayer, veh)
			return
		end
		startPoints(name)
	end)
end

function drawStatistic()
	dxDrawImage(x-330, y / 2 - (147/2), 311,147, "ui/image/statistic.png")
	if tonumber(secundes) <= 9 then secundes = "0"..tonumber(secundes) end
	dxDrawText("Время: "..minutes..":"..secundes, x-320, y / 2 - 20, x-300, y / 2 , tocolor(255,255,255,255), 0.65, font, "left", "center")
	dxDrawText("Контр.точки: ".. (point-1) .."/"..#pointNames, x-320, y / 2 + 40, x-300, y / 2 + 20, tocolor(255,255,255,255), 0.65, font, "left", "center")
end