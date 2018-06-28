local scx,scy = guiGetScreenSize()
local px = scx/1920
local sizeX, sizeY = 400*px,600*px
local posX,posY = 10*px,scy-sizeY-100*px
local screen = dxCreateScreenSource( scx,scy )



setCameraTarget(localPlayer)

local function isCursorOverRectangle(x,y,w,h)
	if isCursorShowing() then
		local mx,my = getCursorPosition() -- relative
		local cursorx,cursory = mx*scx,my*scy
		if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
			return true
		end
	end
return false
end

--[[for k,v in pairs(tradeMarkerPositions) do
	local marker = createMarker(v[1],v[2],v[3],"cylinder",2.5,100,100,100)
	setElementData(marker,"trade",k,false)
	local blip = createBlipAttachedTo( marker, 17, 2, 255, 255, 255, 255, 0, 200 )
end]]--

for k,v in pairs(vehShopsTable) do
	local marker = createMarker(v[1],v[2],v[3],"cylinder",2.5,255,0,0)
	setElementData(marker,"shop",k,false)
	local blip = createBlipAttachedTo( marker, 55, 2, 255, 255, 255, 255, 0, 200 )
end

local shopWindow = false
local currentShop = "Wang Cars"
local currentMarker = nil
local veh = nil
local selection = 1
local currentColor = 1
local currentWheels = 1
local press = false
local scroll = 0
local scrollMax = 0
local rt = dxCreateRenderTarget( 400*px, 300*px, true )
local clk = false

function switchVehicleModel()
	setElementModel(veh,vehShopVehicles[currentShop][selection][1])
end


local screX, screY = guiGetScreenSize()
guiNumbers = guiCreateWindow(screX-700,screY-210, 343, 200, "Выбор региона номерного знака", false)
search = guiCreateEdit ( 0, 0.12, 1, 0.1, "", true, guiNumbers )
gridNumbers = guiCreateGridList(0,0.25,1,0.6,true, guiNumbers)
guiGridListAddColumn(gridNumbers, "Номер", 0.15)
guiGridListAddColumn(gridNumbers, "Название", 0.7)
labelNum = guiCreateLabel(0.05,0.87,0.6,0.2,"Выбран регион: 77", true, guiNumbers)
guiWindowSetSizable(guiNumbers, false)
guiSetVisible(guiNumbers, false)

function ClientGUIChanged ()
	if ( source == search ) then
		guiGridListClear ( gridNumbers )
		local text = guiGetText ( search )
		if ( text == "" ) then
			for i,reg in pairs(regions) do
				row = guiGridListAddRow(gridNumbers)
				if tonumber(reg[1]) <= 9 then reg[1] = "0"..tonumber(reg[1]) end
				guiGridListSetItemText(gridNumbers, row, 1, reg[1], false, true)
				guiGridListSetItemText(gridNumbers, row, 2, reg[2], false, true)
			end
		else
			for i,reg in pairs(regions) do
				if ( string.find ( string.upper (reg[1]), string.upper ( text ), 1, true ) ) then
					row = guiGridListAddRow(gridNumbers)
					if tonumber(reg[1]) <= 9 then reg[1] = "0"..tonumber(reg[1]) end
					guiGridListSetItemText(gridNumbers, row, 1, reg[1], false, true)
					guiGridListSetItemText(gridNumbers, row, 2, reg[2], false, true)
				end
				if ( string.find ( string.upper (reg[2]), string.upper ( text ), 1, true ) ) then
					row = guiGridListAddRow(gridNumbers)
					if tonumber(reg[1]) <= 9 then reg[1] = "0"..tonumber(reg[1]) end
					guiGridListSetItemText(gridNumbers, row, 1, reg[1], false, true)
					guiGridListSetItemText(gridNumbers, row, 2, reg[2], false, true)
				end
			end
		end
	end
end
addEventHandler ( "onClientGUIChanged", guiNumbers, ClientGUIChanged )

addEventHandler("onClientGUIClick", getRootElement(), function()
	if source == numsButton then
		if guiGetVisible(guiNumbers) == true then
			guiSetVisible(guiNumbers, false)
		else
			guiSetVisible(guiNumbers, true)
		end
		guiGridListClear(gridNumbers)
		for i,reg in pairs(regions) do
			row = guiGridListAddRow(gridNumbers)
			if tonumber(reg[1]) <= 9 then reg[1] = "0"..tonumber(reg[1]) end
			guiGridListSetItemText(gridNumbers, row, 1, reg[1], false, true)
			guiGridListSetItemText(gridNumbers, row, 2, reg[2], false, true)
		end
	end
	if source == gridNumbers then
		row = guiGridListGetSelectedItem(gridNumbers)
		if row and row ~= -1 then
			reg = guiGridListGetItemText(gridNumbers, row, 1)
			guiSetText(labelNum, "Выбран регион: "..reg)
			if veh then
				if not reg then reg = 197 end
				setElementData(veh, "numberType", "ru")
				setElementData(veh, "number:plate", "A000AA"..reg)
			end
		end
	end
end)

function drawVehicleShop() 
	--showCursor(true)
	dxUpdateScreenSource( screen )
	dxDrawImage(0,0,scx,scy,screen)
	--UPPER BOX
	dxDrawImage(posX+630*px,posY+650*px,605*px,55*px,"files/colors.png", 0, 0, 0, tocolor(255, 255, 255, 255) )
	dxDrawImage(posX-10*px,posY-500*px,1920*px,1200*px,"files/cam.png", 0, 0, 0, tocolor(255, 255, 255, 255) )
	dxDrawImage(posX-10,posY-65,sizeX+20,sizeY-150*px,"files/fon.png", 0, 0, 0, tocolor(255, 255, 255, 255) )
	dxDrawImage(posX-2,posY+400*px,sizeX+2,200*px,"files/fon2.png", 0, 0, 0, tocolor(255, 255, 255, 255) )
	dxDrawText("Автосалон\nTCW",posX*px-5,posY-130*px,posX+sizeX,posY+30*px,tocolor(240,240,240),2*px,"default-bold","center","center")
	
	-- colors
	local cbx = posX+645*px
	for k,v in pairs(vehShopColors) do
		local color = tocolor(v[1],v[2],v[3])
		if isCursorOverRectangle(cbx,posY+658*px,36*px,36*px) or currentColor == k then
			dxDrawRectangle(cbx-2*px,posY+657*px,40*px,40*px,color)
			if getKeyState("mouse1") then
				currentColor = k
				setVehicleColor(veh,v[1],v[2],v[3])
			end
		end
		dxDrawRectangle(cbx,posY+658*px,36*px,36*px,color)
		cbx = cbx + 45*px
	end
	dxDrawText("",posX,posY+30*px,posX+sizeX,posY+30*px,tocolor(240,240,240),2*px,"default-bold","center","center")
	dxDrawText("Выберите цвет",posX+1500*px,posY+1230*px,posX+sizeX,posY+30*px,tocolor(240,240,240),2*px,"default-bold","center","center")

	--[[ WHEELS
	dxDrawText("Выберите диски | Цена 50$",posX,posY+150*px,posX+sizeX,posY+150*px,tocolor(240,240,240),2*px,"default-bold","center","center")
	local wx,wy = posX+25*px, posY+180*px
	local row,column = 1,1
	for k,v in pairs(vehShopWheels) do
		if isCursorOverRectangle(wx+120*px*column-120*px,wy+50*px*row-50*px,100*px,40*px) or currentWheels == k  then
			dxDrawRectangle(wx+120*px*column-120*px,wy+50*px*row-50*px,100*px,40*px,tocolor(210,210,210))
			dxDrawText("Диски #"..k,wx+120*px*column-120*px,wy+50*px*row-50*px,wx+120*px*column-120*px+100*px,wy+50*px*row-50*px+40*px,tocolor(20,20,20),1,"default-bold","center","center")
			if getKeyState("mouse1") then
				currentWheels = k
				if k ~= 1 then
					addVehicleUpgrade(veh,v)
				else
					for key,val in pairs(vehShopWheels) do
						removeVehicleUpgrade(veh, val)
					end
				end
			end
		else
			dxDrawRectangle(wx+120*px*column-120*px,wy+50*px*row-50*px,100*px,40*px,tocolor(100,100,100))
			dxDrawText("Диски #"..k,wx+120*px*column-120*px,wy+50*px*row-50*px,wx+120*px*column-120*px+100*px,wy+50*px*row-50*px+40*px,tocolor(255,255,255),1,"default-bold","center","center")
		end
		column = column + 1
		if column == 4 then 
			row = row +1
			column = 1
		end
	end

	]]--
	
	
	-- NAME AND ARROWS
	
	
	
	dxSetRenderTarget( rt,true )
	if scroll < 0 then scroll = 0
	elseif scroll >= scrollMax then scroll = scrollMax end
	local sy = 0
		for k,v in pairs(vehShopVehicles[currentShop]) do
			if k == selection then
				dxDrawRectangle(0,sy-scroll,500*px,29*px,tocolor(0,0,0,200))
				dxDrawRectangle(0,sy-scroll,5*px,29*px,tocolor(227,27,27,255))
				colorname = tocolor(227,27,27,255)
				namesize = 1.7
			else
				--dxDrawRectangle(0,sy-scroll,500*px,29*px,tocolor(50,50,200,150))
				colorname = tocolor(255,255,255)
				namesize = 1.5
			end
			dxDrawText(v[2],15*px,sy-scroll,500*px,sy-scroll+30*px,colorname,namesize,"default-bold","left","center")
			--dxDrawText("$"..v[3],15*px,sy-scroll,390*px,sy-scroll+30*px,tocolor(255,255,255),1.2,"default-bold","right","center")
			sy = sy + 30*px
		end
	dxSetRenderTarget()
	dxDrawImage(posX,posY+5*px,380*px,300*px,rt)
	if sy >= 300*px then
		scrollMax = sy-300*px
		local size = 300*px/sy*300*px
		--dxDrawRectangle(posX+385*px,posY+5*px,10*px,300*px,tocolor(0,0,0,200))
		--dxDrawRectangle(posX+385*px,posY+5*px+scroll/scrollMax*(300*px-size),10*px,size,tocolor(127,217,228,200))
		dxDrawImage(posX+385*px,posY+5*px+scroll/scrollMax*(300*px-size),10*px,size,"files/scroll.png")
		dxDrawImage(posX+382*px,posY+2*px,15*px,305*px,"files/scrollbar.png")
	end

	local spy = 0
	for k,v in pairs(vehShopVehicles[currentShop]) do
		if isCursorOverRectangle(posX,posY+5*px,380*px,300*px) then
			if isCursorOverRectangle(posX,posY+5*px+spy-scroll,400*px,29*px) then
				if getKeyState("mouse1") and not clk then
					selection = k
					switchVehicleModel()
				end
			end
		end
		spy = spy + 30*px
	end
	
	
	
	
	dxDrawText(vehShopVehicles[currentShop][selection][2],posX,posY+260*px,posX+sizeX,posY+452*px,tocolor(227,27,27,255),1.5*px,"default-bold","center","center")
	if isCursorOverRectangle(posX+20*px,posY+320*px,45*px,45*px) then
		dxDrawImage(posX+20*px,posY+320*px,45*px,45*px,"files/arrow.png",180,0,0,tocolor(255,255,255))
		if getKeyState("mouse1") then
			if not press then
				press = true
				if selection > 1 then
					selection = selection - 1
					setElementModel(veh,vehShopVehicles[currentShop][selection][1])
				end
			end
		else
			press = false
		end
	else
		dxDrawImage(posX+20*px,posY+320*px,45*px,45*px,"files/arrow.png",180,0,0,tocolor(150,150,150))
	end
	if isCursorOverRectangle(posX+335*px,posY+320*px,45*px,45*px) then
		dxDrawImage(posX+335*px,posY+320*px,45*px,45*px,"files/arrow.png",0,0,0,tocolor(255,255,255))
		if getKeyState("mouse1") then
			if not press then
				press = true
				if selection < #vehShopVehicles[currentShop] then
					selection = selection + 1
					setElementModel(veh,vehShopVehicles[currentShop][selection][1])
				end
			end
		else
			press = false
		end
	else
		dxDrawImage(posX+335*px,posY+320*px,45*px,45*px,"files/arrow.png",0,0,0,tocolor(150,150,150))
	end
	-- PRICE
	dxDrawText("Цена: "..convertNumber(vehShopVehicles[currentShop][selection][3]).." $",posX,posY+400*px,posX+sizeX,posY+510*px,tocolor(227,27,27,255),1.7*px,"default-bold","center","center")

	-- BUTTONS
	if isCursorOverRectangle(posX+10*px,posY+550*px,120*px,35*px) then
		dxDrawRectangle(posX+10*px,posY+550*px,120*px,35*px,tocolor(200,200,200,255))
		dxDrawText("Купить",posX+10*px,posY+550*px,posX+130*px,posY+585*px,tocolor(10,10,30),1,"default-bold","center","center")
		if getKeyState("mouse1") then
			if not press then
				press = true
				--if getPlayerMoney(localPlayer) >= vehShopVehicles[currentShop][selection][3]+100 then
					--initVehicleShopWindow()
					if not reg then reg = 72 end
					local info = vehShopVehicles[currentShop][selection]
					getVehicleInfo (info[2], info[3])
					--triggerServerEvent( "buyTheVehicle", localPlayer, localPlayer,currentShop,vehShopVehicles[currentShop][selection][1],currentColor,currentWheels, reg)
				--else
					--outputChatBox("Недостаточно средств для покупки данного автомобиля.",200,20,20)
				--end
			end
		else
			press = false
		end
	else
		dxDrawRectangle(posX+10*px,posY+550*px,120*px,35*px,tocolor(40,40,40,255))
		dxDrawText("Купить",posX+10*px,posY+550*px,posX+130*px,posY+585*px,tocolor(255,255,255),1,"default-bold","center","center")
	end

	
	if isCursorOverRectangle(posX+10*px,posY+510*px,380*px,35*px) then
		dxDrawRectangle(posX+10*px,posY+510*px,380*px,35*px,tocolor(200,200,200,255))
		dxDrawText("Регион",posX+10+(380/2)*px,posY+527*px,posX+10+(380/2)*px,posY+527*px,tocolor(10,10,30),1,"default-bold","center","center")
		if getKeyState("mouse1") then
			if not press then
				press = true
				guiSetVisible(guiNumbers, not guiGetVisible(guiNumbers))
				guiGridListClear(gridNumbers)
				for i,reg in pairs(regions) do
					row = guiGridListAddRow(gridNumbers)
					if tonumber(reg[1]) <= 9 then reg[1] = "0"..tonumber(reg[1]) end
					guiGridListSetItemText(gridNumbers, row, 1, reg[1], false, true)
					guiGridListSetItemText(gridNumbers, row, 2, reg[2], false, true)
				end
			end
		else
			press = false
		end
	else
		dxDrawRectangle(posX+10*px,posY+510*px,380*px,35*px,tocolor(40,40,40,255))
		dxDrawText("Регион",posX+10+(380/2)*px,posY+527*px,posX+10+(380/2)*px,posY+527*px,tocolor(255,255,255),1,"default-bold","center","center")
	end
	
	
	
	
	
	if isCursorOverRectangle(posX+140*px,posY+550*px,120*px,35*px) then
		dxDrawRectangle(posX+140*px,posY+550*px,120*px,35*px,tocolor(200,200,200,255))
		dxDrawText("Тест-драйв",posX+140*px,posY+550*px,posX+260*px,posY+585*px,tocolor(10,10,30),1,"default-bold","center","center")
		if getKeyState("mouse1") then
			triggerServerEvent("startTestDrive",localPlayer,vehShopVehicles[currentShop][selection][1])
			initVehicleShopWindow()
		end
	else
		dxDrawRectangle(posX+140*px,posY+550*px,120*px,35*px,tocolor(40,40,40,255))
		dxDrawText("Тест-драйв",posX+140*px,posY+550*px,posX+260*px,posY+585*px,tocolor(255,255,255),1,"default-bold","center","center")
	end

	if isCursorOverRectangle(posX+270*px,posY+550*px,120*px,35*px) then
		dxDrawRectangle(posX+270*px,posY+550*px,120*px,35*px,tocolor(200,200,200,255))
		dxDrawText("Выйти",posX+270*px,posY+550*px,posX+390*px,posY+585*px,tocolor(10,10,30),1,"default-bold","center","center")
		if getKeyState("mouse1") then
			initVehicleShopWindow()
			getVehicleInfo (_,_, true)
			executeCommandHandler ("hud_off")
			showChat (true)
		end
	else
		dxDrawRectangle(posX+270*px,posY+550*px,120*px,35*px,tocolor(40,40,40,255))
		dxDrawText("Выйти",posX+270*px,posY+550*px,posX+390*px,posY+585*px,tocolor(255,255,255),1,"default-bold","center","center")
	end
	--dxDrawText( string text, float left, float top [, float right=left, float bottom=top, int color=white,                   float scale=1, mixed font="default", string alignX="left", string alignY="top",                  bool clip=false, bool wordBreak=false, bool postGUI=false,                  bool colorCoded=false, bool subPixelPositioning=false,                   float fRotation=0, float fRotationCenterX=0, float fRotationCenterY=0 ] )
end
--addEventHandler("onClientRender",root,drawVehicleShop)


function initVehicleShopWindow()
	if shopWindow then
		shopWindow = false
		showCursor(false)
		fadeCamera( false, 1 )
		removeEventHandler("onClientRender",root,drawVehicleShop)
		guiSetVisible(guiNumbers, false)
		setTimer(function()
				setElementAlpha(currentMarker,255)
				setCameraTarget(localPlayer)
				setElementFrozen(localPlayer,true)
				triggerServerEvent( "setPlayerDimension", localPlayer, 0 )
				destroyElement(veh)
				fadeCamera(true,2)
			end,1000,1)
		setTimer(function ()
			local x, y, z = getElementPosition(localPlayer)
			setElementPosition (localPlayer, x, y, z + 1)
			setElementFrozen (localPlayer, false)
		end ,2000,1)
	else
		shopWindow = true
		currentColor = 1
		currentWheels = 1
		selection = 1
		showCursor(true)
		fadeCamera( false, 1 )
		guiSetVisible(guiNumbers, false)
		setElementFrozen(localPlayer,true)
		setTimer(function() 
			fadeCamera(true,1)
			addEventHandler("onClientRender",root,drawVehicleShop)
			showCursor(true)
			setCameraMatrix( -1955,271,36,-1953.009765625,264.6650390625,35.097522735596 )
			setElementDimension(localPlayer, 1)
			veh = createVehicle( vehShopVehicles[currentShop][1][1], -1953.009765625,264.6650390625,35.097522735596,0.406494140625,0.0054931640625,42.994995117188 )
			setVehicleColor(veh,200,200,200)
			setElementDimension(veh,1)
			setElementData(veh,"numberType","ru")
			setElementData(veh,"number:plate","A000AA77")
			setElementData(veh,"ramka","1.png")
		end,1000,1)
	end
end
--initVehicleShopWindow("Wang Cars")

addEventHandler("onClientKey",root,function(key,press)
	if press then
		if not shopWindow then return end
		if key == "mouse_wheel_down" then
			scroll = scroll + 15*px
		elseif key == "mouse_wheel_up" then
			scroll = scroll - 15*px
		end
	end
end)

local managerWindow = nil
local vehmarker = nil
local vehblip = nil
local numberWindow = nil
local barterWindow = nil

function initVehicleManager()
	if isElement(managerWindow) then
		destroyElement(managerWindow)
		showCursor(false)
	else
		--if isElement(numberWindow) then return end
		--if isElement(barterWindow) then return end
		local vehicles = getElementData(localPlayer,"vehicles")
		local soldvehicles = getElementData(localPlayer,"soldvehicles") or {}
		if vehicles and type(vehicles) == "table" then
			showCursor(true)
			managerWindow = guiCreateWindow(scx/2-300,scy/2-200,600,400,"Менеджер автомобилей",false)
			local gridlist = guiCreateGridList(0,0.1,0.7,0.7,true,managerWindow)
			--local labelLimits = guiCreateLabel(0,0.92,0.7,0.1,"Парковочные места: "..limits,true,managerWindow)
			--guiLabelSetHorizontalAlign(labelLimits,"center")
			--guiSetFont(labelLimits,"default-bold-small")
			local btnSell = guiCreateButton(0.72,0.65,0.3,0.1,"Продать",true,managerWindow)
			local btnPlayerSell = guiCreateButton(0.72,0.76,0.3,0.1,"Игроку",true,managerWindow)
			local btnMark = guiCreateButton(0.72,0.43,0.3,0.1,"Метка",true,managerWindow)
			local btnOpen = guiCreateButton(0.72,0.54,0.3,0.1,"Откр/Закр",true,managerWindow)

			local btnSpawn = guiCreateButton(0.72,0.1,0.3,0.1,"Респавн",true,managerWindow)
			local btnDestroy = guiCreateButton(0.72,0.21,0.3,0.1,"Убрать",true,managerWindow)
			local btnBring = guiCreateButton(0.72,0.32,0.3,0.1,"Телепорт",true,managerWindow)
			local btnBlock = guiCreateButton(0.72,0.87,0.3,0.1,"Заблокировать",true,managerWindow)

			local btnNumber1 = guiCreateButton(0,0.82,0.3,0.08,"Установить номер",true,managerWindow)
			local btnNumber2 = guiCreateButton(0.4,0.82,0.3,0.08,"Снять номер",true,managerWindow)

			guiGridListAddColumn( gridlist, "Автомобиль", 0.6 )
			guiGridListAddColumn( gridlist, "Номер", 0.3 )
			guiSetProperty(gridlist, "ColumnsMovable", "False")
			guiGridListSetSortingEnabled( gridlist, false )
			for k,v in pairs(vehicles) do
				local data = getVehicleData(v["Model"])
				local row = guiGridListAddRow(gridlist)
				guiGridListSetItemText( gridlist,row,1, data[2] , false,false )
				if v["Number"] then
					local num = fromJSON(v["Number"])
					guiGridListSetItemText( gridlist,row,2, num[2] or "Не установлен", false,false )
				else
					guiGridListSetItemText( gridlist,row,2, "Не установлен", false,false )
				end
				guiGridListSetItemData( gridlist,row,1, v["ID"] )
				guiGridListSetItemData( gridlist,row,2, v["ID"] )
				if isDonateVehicle(v["Model"]) then
					guiGridListSetItemColor(gridlist,row,1,200,0,0)
					guiGridListSetItemColor(gridlist,row,2,200,0,0)
					guiSetFont(gridlist,"default-bold-small")
				end
			end
			for k,v in pairs(soldvehicles) do
				local data = getVehicleData(v["Model"])
				local row = guiGridListAddRow(gridlist)
				guiGridListSetItemText( gridlist,row,1, data[2] , false,false )
				guiGridListSetItemText( gridlist,row,2, "Выставлена на Б/У", false,false )
				--guiGridListSetItemData( gridlist,row,1, v["ID"] )
				guiSetFont(gridlist,"default-bold-small")
				guiGridListSetItemColor( gridlist, row, 1, 200,0,0 )
				guiGridListSetItemColor( gridlist, row, 2, 200,0,0 )
			end
			if selection then guiGridListSetSelectedItem( gridlist, selection, 1 ) end
			addEventHandler("onClientGUIClick",managerWindow,function()
				local row = guiGridListGetSelectedItem( gridlist )
				if row >= 0 then
					local id = guiGridListGetItemData( gridlist, row,1 )
					if not id then return end
					selection = row
					if source == gridlist then
					elseif source == btnSell then
						if findVeh(id) then
							initVehicleManager()
							initSellConfirmationWindow(id)
						else
							outputChatBox("#ffffff*Автомобиль должен быть заспавнен!",200,50,50,true)
						end
					elseif source == btnPlayerSell then
						initTradeOffer(id)
						initVehicleManager()
						showCursor(true)
					elseif source == btnMark then
						local veh = findVeh(id)
						if veh then
							if isElement(vehmarker) then
								destroyElement(vehblip)
								destroyElement(vehmarker)
							else
								local x,y,z = getElementPosition(veh)
								vehmarker = createMarker( x,y,z )
								vehblip = createBlipAttachedTo(vehmarker)
							end
						end
					elseif source == btnOpen then
						triggerServerEvent( "lockVehicle", localPlayer, findVeh(id) )
					elseif source == btnSpawn then
						triggerServerEvent( "spawnTheVehicle", localPlayer, id )
					elseif source == btnDestroy then
						if isElement (findVeh(id)) then
						triggerServerEvent( "saveVehicle", localPlayer, findVeh(id))
						triggerServerEvent( "refreshCar", localPlayer, localPlayer)
						triggerServerEvent( "destroyTheVehicle", localPlayer, findVeh(id) )
						else
						outputChatBox("#ffffff*Машина не заспавнена!",255,255,255,true)
						end
					elseif source == btnBring then
						triggerServerEvent( "bringVehicle", localPlayer, findVeh(id) )
					elseif source == btnBlock then
						triggerServerEvent( "blockVehicle", localPlayer, localPlayer, findVeh(id))
						initVehicleManager()
					elseif source == btnNumber1 then
						local numbers = getElementData(localPlayer,"numbers") 
						numberWindow = guiCreateWindow(0.4,0.3,0.2,0.3,"Выберите номер",true)
						local gridlistNumber = guiCreateGridList(0,0.05,1,0.7,true,numberWindow)
						local column = guiGridListAddColumn(gridlistNumber,"Номер",0.8)
						local vehID = guiGridListGetItemData(gridlistNumber,row,column)
						for k,v in pairs(numbers) do
							--outputChatBox(tostring(v[2]))
							local row = guiGridListAddRow(gridlistNumber)
							if v[2] then
							guiGridListSetItemText( gridlistNumber,row,1,tostring(v[2]),false,false)
							guiGridListSetItemData( gridlistNumber, row, 1, v )
							end
						end
						local btnClose = guiCreateButton(0,0.8,0.3,0.1,"Отмена",true,numberWindow)
						local btnDelete = guiCreateButton(0.35,0.8,0.3,0.1,"Удалить",true,numberWindow)
						local btnInstall = guiCreateButton(0.7,0.8,0.3,0.1,"Установить ("..numberSwitchPrice.." $)",true,numberWindow)
						addEventHandler("onClientGUIClick",numberWindow,function()
							if source == btnClose then
								destroyElement(numberWindow)
								showCursor(false)
							elseif source == btnInstall then
								----print ("1: "..gridlistNumber)
								local num = guiGridListGetSelectedItem( gridlistNumber )
									----print ("2: "..num)
									if getPlayerMoney(localPlayer) >= numberSwitchPrice then
										if num >= 0 then
											local numberTypeWindow = guiGridListGetItemData (gridlistNumber, num,column)
											local numberWindowNum = guiGridListGetItemText(gridlistNumber, num,column)
											----print ("3: "..)
											local number = toJSON({setElementData (findVeh(id), "numberType", tostring(unpack(numberTypeWindow))), setElementData (findVeh(id), "number:plate", tostring(numberWindowNum))})
											triggerServerEvent( "saveVehicle", localPlayer, findVeh(id))
											triggerServerEvent( "switchVehicleNumberPlate", localPlayer, id, guiGridListGetItemData(gridlistNumber,num,column), false )
											
											destroyElement(numberWindow)
											showCursor(false)
										end
									else
										outputChatBox("#ff0000*Недостаточно #ffffffденег!",200,50,50,true)
									end
							elseif source == btnDelete then
								local num = guiGridListGetSelectedItem( gridlistNumber )
								if num >= 0 then
									triggerServerEvent( "switchVehicleNumberPlate", localPlayer, id, guiGridListGetItemData(gridlistNumber,num,1), true )
									destroyElement(numberWindow)
									showCursor(false)
								end
							end
						end)
						initVehicleManager()
						showCursor(true)
					elseif source == btnNumber2 then
						triggerServerEvent( "switchVehicleNumberPlate", localPlayer, id, {"c",""}, true )
						exports.numb:destroyPlate(findVeh(id))
						initVehicleManager()
					end
				end
			end)
		end
	end
end
addEvent("initVehicleManager",true)
addEventHandler("initVehicleManager",root,initVehicleManager)
--initVehicleManager()


local sellConfirmationWindow = nil

function initSellConfirmationWindow(id)
	if isElement(sellConfirmationWindow) then
		destroyElement(sellConfirmationWindow)
		showCursor(false)
	else
		sellConfirmationWindow = guiCreateWindow(0.3,0.4,0.3,0.15,"Утилизация",true)
		showCursor(true)
		local veh = findVeh(id)
		local data = getVehicleData(getElementModel(veh))
		local label = guiCreateLabel(0.1,0.3,0.8,0.1,"Вы действительно хотите продать "..data[2].." за "..data[3]/2 .."$?",true,sellConfirmationWindow)
		guiLabelSetHorizontalAlign( label, "center" )
		local btn1 = guiCreateButton(0.1,0.6,0.3,0.3,"Отмена",true,sellConfirmationWindow)
		local btn2 = guiCreateButton(0.6,0.6,0.3,0.3,"Подтвердить",true,sellConfirmationWindow)
		addEventHandler("onClientGUIClick",sellConfirmationWindow,function()
			if source == btn1 then
				initSellConfirmationWindow()
			elseif source == btn2 then
				triggerServerEvent("sellVehicle", localPlayer, veh)
				initSellConfirmationWindow()
			end
		end)
	end
end

addEventHandler("onClientMarkerHit", resourceRoot, function(player)
	if player ~= localPlayer then return end
	local shop = getElementData(source, "shop")
	if shop then
		if getElementType(player) == "player" and player == localPlayer then
			if not getPedOccupiedVehicle( player ) then
				outputChatBox("#ffffff*Добро пожаловать в #ff0000"..shop,255,255,255,true)
				currentShop = shop
				initVehicleShopWindow()
				setElementAlpha(source,0)
				executeCommandHandler ("hud_off")
				showChat (false)
				currentMarker = source
			end
		end
	end
	if source == vehmarker then
		destroyElement(vehblip)
		destroyElement(source)
	end
	if getElementData(source,"trade") then
		if getElementType(player) == "player" and player == localPlayer then
			if not isPedInVehicle(player) then
				barterMarkerWindow()
			end
		end
	end
end)

local markerWindow = nil

function initMarkerWindow(city)
	if isElement(markerWindow) then
		showCursor(false)
		destroyElement(markerWindow)
	else
		local veh = getPedOccupiedVehicle( localPlayer )
		local mdl = getElementModel(veh)
		local date = 1
		local withdraw = 100
		setElementFrozen ( veh, false )
		local vehname = getVehicleData(getElementModel(veh))[2] or "Vehicle"
		showCursor(true)
		markerWindow = guiCreateWindow(0.3,0.3,0.3,0.3,"Продажа автомобиля",true)
		guiWindowSetSizable( markerWindow, false )
		local label1 = guiCreateLabel( 0.1,0.1,0.8,0.2,"Выставление на продажу автомобиля \n"..vehname,true,markerWindow )
		guiLabelSetColor(label1,200,200,0)
		guiLabelSetHorizontalAlign( label1,"center" )
		local label2 = guiCreateLabel( 0.1,0.3,0.8,0.2,"Укажите срок аренды парковочного места.",true,markerWindow )
		guiLabelSetColor(label2,100,200,0)
		--guiLabelSetHorizontalAlign( label2,"center" )
		local date1 = guiCreateRadioButton(0.1,0.4,0.6,0.05,"1 День - 1000$",true,markerWindow)
		local date2 = guiCreateRadioButton(0.1,0.45,0.6,0.05,"3 Дня - 4000$",true,markerWindow)
		local date3 = guiCreateRadioButton(0.1,0.5,0.6,0.05,"7 Дней - 8000$",true,markerWindow)
		local date4 = guiCreateRadioButton(0.1,0.55,0.6,0.05,"21 Дня - 16000$",true,markerWindow)
		guiRadioButtonSetSelected( date1, true )
		local edit = guiCreateEdit(0.2,0.65,0.6,0.1,"Укажите цену",true, markerWindow)

		local btnCancel = guiCreateButton(0.05,0.85,0.3,0.12,"Отмена",true, markerWindow)
		local btnAccept = guiCreateButton(0.6,0.85,0.3,0.12,"Подтвердить",true, markerWindow)
		setElementFrozen ( veh, true )
		addEventHandler("onClientGUIClick",markerWindow,function()
			if source == btnCancel then
				initMarkerWindow()
				setElementFrozen ( veh, false )
			elseif source == edit then
				if guiGetText(edit) == "Укажите цену" then guiSetText(edit,"") end
			elseif source == btnAccept then
				local price = tonumber(guiGetText(edit))
				if price then
					if price > 0 and price <= getVehicleData(getElementModel(veh))[3]*0.9 then
						if date then
							if city == "SF" then
								triggerServerEvent( "placeVehicleOnMarket", localPlayer, veh, price, date, withdraw)
								initMarkerWindow()
								setElementFrozen ( veh, false )
							elseif city == "LV" then
								triggerServerEvent( "placeVehicleOnMarketLV", localPlayer, veh, price, date, withdraw)
								initMarkerWindow()
								setElementFrozen ( veh, false )
							elseif city == "LS" then
								triggerServerEvent( "placeVehicleOnMarketLS", localPlayer, veh, price, date, withdraw)
								initMarkerWindow()
								setElementFrozen ( veh, false )
							end
						else
							outputChatBox("#ffffff*Вы не указали сроки продаж!",255,255,255,true)
						end
					else
						outputChatBox("#ff0000*Некорректная #ffffffстоимость, максимальная цена для этой машины - "..math.floor(getVehicleData(getElementModel(veh))[3]*0.9).."!",255,255,255,true)
					end
				else
					outputChatBox("#ff0000*Некорректная #ffffffстоимость!",200,0,0,true)
				end
			elseif source == date1 then
				date = 1
				withdraw = 1000
			elseif source == date2 then
				date = 3
				withdraw = 4000
			elseif source == date3 then
				date = 7
				withdraw = 8000
			elseif source == date4 then
				date = 21
				withdraw = 16000
			end
		end)
	end
end
addEvent("initMarkerWindow",true)
addEventHandler("initMarkerWindow",root,initMarkerWindow)
--initMarkerWindow()

local marketVehicleWindow = nil

function initMarketVehicleWindow(owner)
	if isElement(marketVehicleWindow) then
		showCursor(false)
		destroyElement( marketVehicleWindow )
	else
		local veh = getPedOccupiedVehicle( localPlayer )
		if veh then
			local vehname = getVehicleData(getElementModel(veh))[2]
			local price = getElementData(veh,"Price")
			if owner then price = 0 end
			showCursor(true)
			marketVehicleWindow = guiCreateWindow(0.35,0.4,0.3,0.15,"Покупка автомобиля",true)
			local label = guiCreateLabel(0,0.25,1,0.1,"Купить "..vehname.." за "..price.."$ ?",true,marketVehicleWindow)
			guiLabelSetHorizontalAlign( label, "center" )
			local btnCancel = guiCreateButton(0.1,0.6,0.3,0.3,"Отмена",true,marketVehicleWindow)
			local btnAccept = guiCreateButton(0.6,0.6,0.3,0.3,"Купить",true,marketVehicleWindow)
			addEventHandler("onClientGUIClick",marketVehicleWindow,function()
				if source == btnCancel then
					initMarketVehicleWindow()
					removePedFromVehicle(localPlayer)
				elseif source == btnAccept then
					triggerServerEvent( "buyVehicleFromMarket", localPlayer, veh )
					initMarketVehicleWindow()
				end
			end)
		end
	end
end
addEvent("initMarketVehicleWindow",true)
addEventHandler("initMarketVehicleWindow",root,initMarketVehicleWindow)
--initMarketVehicleWindow()

function drawMarketVehicleInfo()
	for k,v in pairs(getElementsByType("vehicle")) do
		if getElementData(v,"owner") == "Market" then
			local x,y,z = getElementPosition(localPlayer)
			local x2,y2,z2 = getElementPosition(v)
			if getDistanceBetweenPoints3D( x,y,z,x2,y2,z2 ) <= 10 then
				local sx,sy = getScreenFromWorldPosition( x2, y2, z+1 )
				if sx and sy then
					dxDrawText( getVehicleData(getElementModel(v))[2].."\n#00dd00"..getElementData(v,"Price").."$",sx,sy,sx,sy,tocolor(255,255,255),2,"default-bold","center","center",false,false,false,true)
				end
			end
		end
	end
end
addEventHandler("onClientRender",root,drawMarketVehicleInfo)


local tOffer = nil

function initTradeOffer(id)
	if isElement(tOffer) then
		showCursor(false)
		destroyElement(tOffer)
	else
		showCursor(true)
		tOffer = guiCreateWindow(0.4,0.3,0.15,0.3,"Продать автомобиль", true)
		local grid = guiCreateGridList(0,0.1,1,0.5,true,tOffer)
		guiGridListAddColumn(grid,"Выберите игрока",0.8)
		local players = getElementsByType("player")
		local x,y,z = getElementPosition(localPlayer)
		for k,v in pairs(players) do
			local x2,y2,z2 = getElementPosition(v)
			if getDistanceBetweenPoints3D( x,y,z,x2,y2,z2 ) <= 20 then
				local row = guiGridListAddRow(grid)
				guiGridListSetItemText(grid,row,1,getPlayerName(v),false,false)
				guiGridListSetItemData(grid,row,1,v)
			end
		end
		local edit = guiCreateEdit(0.1,0.65,0.8,0.1,"Введите сумму",true,tOffer)
		local btn1 = guiCreateButton(0.05,0.8,0.4,0.15,"Отмена",true,tOffer)
		local btn2 = guiCreateButton(0.55,0.8,0.4,0.15,"Продать",true,tOffer)
		addEventHandler("onClientGUIClick",tOffer,function()
			if source == btn1 then
				initTradeOffer()
			elseif source == btn2 then
				local row = guiGridListGetSelectedItem( grid )
				if row and row >= 0 then
					local sum = guiGetText(edit)
					if sum and tonumber(sum) and tonumber(sum) >= 1 then
						--outputChatBox(tostring(guiGridListGetItemData(grid,row,1)))
						triggerServerEvent( "sendTradeOffer", localPlayer, guiGridListGetItemData(grid,row,1), id, tonumber(sum) )
						initTradeOffer()
					else
						outputChatBox("#ff0000*Некорректная #ffffffсумма!", 200,0,0,true)
					end
				else
					outputChatBox("#ffffff*Вы #ff0000не #ffffffвыбрали игрока!", 200,0,0,true)
				end
			end
		end)
	end
end

local tAccept = nil

function cacheTradeOffer(id,vehname,cash)
	if not isElement(tAccept) then
		showCursor(true)
		local seller = source
		tAccept = guiCreateWindow(0.4,0.35,0.2,0.15,"Покупка автомобиля",true)
		local label = guiCreateLabel(0,0.2,1,0.2,getPlayerName(source).." предлагает вам купить "..vehname.." за "..cash.."$",true,tAccept)
		guiLabelSetHorizontalAlign( label,"center" )
		local btn1 = guiCreateButton(0.1,0.5,0.3,0.3,"Отклонить",true,tAccept)
		local btn2 = guiCreateButton(0.6,0.5,0.3,0.3,"Принять",true,tAccept)
		addEventHandler("onClientGUIClick",tAccept,function()
			if source == btn1 then
				destroyElement(tAccept)
				showCursor(false)
			elseif source == btn2 then
				triggerServerEvent( "tradeAccepted", localPlayer, seller, id, cash )
				destroyElement(tAccept)
				showCursor(false)
			end
		end)
	end
end
addEvent("cacheTradeOffer",true)
addEventHandler("cacheTradeOffer",root,cacheTradeOffer)

--bindKey("g","down",function() triggerServerEvent("toggleEngine",localPlayer) end)

--bindKey("f3","down",function() triggerServerEvent("switchVehicleManager",localPlayer) end)
bindKey("F3","down",initVehicleManager)

-- TEST DRIVE

local demoTimer = nil
local timerShown = false

function initDemoTimer()
	if timerShown then
		removeEventHandler( "onClientRender", root, drawDemoTimer)
		if isTimer(demoTimer) then killTimer(demoTimer) end
		demoTimer = nil
	else
		demoTimer = setTimer(function() end, 60000, 1)
		addEventHandler( "onClientRender", root, drawDemoTimer)
	end
	timerShown = not timerShown
end
addEvent("initDemoTimer",true)
addEventHandler("initDemoTimer",root,initDemoTimer)

function drawDemoTimer()
	if isTimer(demoTimer) then
		local details = getTimerDetails( demoTimer )
		dxDrawRectangle(scx/2-50*px,0,100*px,50*px,tocolor(0,0,0,150))
		dxDrawText("0:"..math.floor(details/1000),scx/2,30,scx/2,30,tocolor(255,255,255),2*px,"default-bold","center","center")
	end
end

-- BARTER SYSTEM

function barterMarkerWindow()
	local window = guiCreateWindow(0.4,0.3,0.2,0.3,"Предложить обмен",true)
	local list = guiCreateGridList(0.1,0.1,0.8,0.7,true,window)
	showCursor(true)
	guiGridListAddColumn( list, "Игроки",0.9 )
	for k,v in pairs(getElementsByType("player")) do
		--if localPlayer ~= v then
			--local x,y,z = getElementPosition(localPlayer)
			--local x2,y2,z2 = getElementPosition(v)
			--if getDistanceBetweenPoints3D( x,y,z,x2,y2,z2 ) <= 15 then
				local row = guiGridListAddRow(list)
				guiGridListSetItemText( list,row,1,getPlayerName(v),false,false )
				guiGridListSetItemData( list,row,1,v)
			--end
		--end
	end
	local btn1 = guiCreateButton(0.1,0.85,0.3,0.1,"Отмена",true,window)
	local btn2 = guiCreateButton(0.6,0.85,0.3,0.1,"Предложить",true,window)
	guiSetEnabled(btn2,false)
	addEventHandler("onClientGUIClick",window,function()
		if source == list then
			local itemI = guiGridListGetSelectedItem( list )
			if itemI and itemI >= 0 then
				guiSetEnabled(btn2,true)
			else
				guiSetEnabled(btn2,false)
			end
		elseif source == btn1 then
			destroyElement(window)
			showCursor(false)
		elseif source == btn2 then
			local sendTo = guiGridListGetItemText(list,guiGridListGetSelectedItem(list))
			triggerServerEvent( "sendBarterOffer", localPlayer, sendTo )
			destroyElement(window)
			showCursor(false)
		end
	end)
end
--barterMarkerWindow()

local cached = false

function cacheBarterOffer()
	if cached then return end
	showCursor(true)
	local ply = source
	local window = guiCreateWindow(0.3,0.4,0.3,0.2,"Предложение обмена",true)
	cached = true
	local label = guiCreateLabel(0.1,0.4,0.8,0.1,getPlayerName(source).." предлагает вам обмен.",true,window)
	guiLabelSetHorizontalAlign( label,"center" )
	local btn1 = guiCreateButton(0.1,0.75,0.3,0.15,"Отмена",true,window)
	local btn2 = guiCreateButton(0.6,0.75,0.3,0.15,"Подтвердить",true,window)
	addEventHandler("onClientGUIClick",window,function()
		if source == btn1 then
			destroyElement(window)
			showCursor(false)
			triggerServerEvent( "abortBarter", localPlayer, ply )
			cached = false
		elseif source == btn2 then
			triggerServerEvent( "offerAccepted", localPlayer, ply )
			destroyElement(window)
			showCursor(false)
			cached = false
		end
	end)
end
addEvent("cacheBarterOfferWindow",true)
addEventHandler("cacheBarterOfferWindow",root,cacheBarterOffer)

local buttonTrade = nil
local items1 = nil -- MY
local items2 = nil -- OFFERED
local ready1,ready2 = false,false
local barter1,barter2 = false,false
local images = {}
local commision = 0

function initBarterWindow()
	if isElement(barterWindow) then
		destroyElement(barterWindow)
		showCursor(false)
		setElementData(localPlayer,"barterWindowShown",false)
	else
		setElementData(localPlayer,"barterWindowShown",true)
		ready1,ready2 = false,false
		barter1,barter2 = false,false
		local addOpened = false
		showCursor(true)
		local ply = source
		barterWindow = guiCreateWindow(0.25,0.2,0.4,0.6,"Обмен с "..getPlayerName(source),true)
		guiWindowSetSizable( barterWindow, false )
		images[1] = guiCreateStaticImage(0.75,0.5,0.05,0.05,"files/notok.png",true,barterWindow)
		images[2] = guiCreateStaticImage(0.85,0.5,0.05,0.05,"files/notok.png",true,barterWindow)
		images[3] = guiCreateStaticImage(0.75,0.6,0.05,0.05,"files/notok.png",true,barterWindow)
		images[4] = guiCreateStaticImage(0.85,0.6,0.05,0.05,"files/notok.png",true,barterWindow)
		items1 = guiCreateGridList(0.05,0.05,0.6,0.4,true,barterWindow)
		guiGridListAddColumn(items1,"Тип",0.3) guiGridListAddColumn(items1,"Описание",0.5)
		local cashrow1 = guiGridListAddRow(items1)
		guiGridListSetItemText(items1,cashrow1,1,"Деньги",false,false)
		guiGridListSetItemText(items1,cashrow1,2,"0",false,false)
		guiGridListSetItemData(items1,cashrow1,1,"0")
		guiGridListSetItemData(items1,cashrow1,2,"0")
		items2 = guiCreateGridList(0.05,0.5,0.6,0.4,true,barterWindow)
		guiGridListAddColumn(items2,"Тип",0.3) guiGridListAddColumn(items2,"Описание",0.5)
		local cashrow2 = guiGridListAddRow(items2)
		guiGridListSetItemText(items2,cashrow2,1,"Деньги",false,false)
		guiGridListSetItemText(items2,cashrow2,2,"0",false,false)
		guiGridListSetItemData(items2,cashrow2,1,"0")
		guiGridListSetItemData(items1,cashrow2,2,"0")
		local btn1 = guiCreateButton(0.7,0.05,0.25,0.08,"Добавить лот",true,barterWindow)
		--local btnCash = guiCreateButton(0.7,0.05,0.25,0.08,"Добавить наличку",true,barterWindow)
		local btn2 = guiCreateButton(0.7,0.15,0.25,0.08,"Убрать лот",true,barterWindow)
		guiSetEnabled(btn2,false)
		local btn3 = guiCreateButton(0.7,0.3,0.25,0.08,"Готов",true,barterWindow)
		buttonTrade = guiCreateButton(0.7,0.4,0.25,0.08,"Обмен",true,barterWindow)
		guiSetEnabled(buttonTrade,false)
		local btn5 = guiCreateButton(0.7,0.82,0.25,0.08,"Отмена",true,barterWindow)
		--local labelCommission = guiCreateLabel(0.7,0.7,0.25,0.08,"Коммиссия: -",true,barterWindow)
		addEventHandler("onClientGUIClick",barterWindow,function()
			if source == items1 then
				local itemI = guiGridListGetSelectedItem( items1 )
				if itemI and itemI >= 0 then
					guiSetEnabled(btn2,true)
				else
					guiSetEnabled(btn2,false)
				end
			elseif source == btn1 then
				if addOpened then return end
				local window = guiCreateWindow(0.3,0.3,0.3,0.3,"Выберите лот",true)
				addOpened = true
				guiWindowSetSizable( window, false )
				local list = guiCreateGridList(0.05,0.1,0.7,0.7,true,window)
				local cashedit = guiCreateEdit(0.78,0.45,0.33,0.1,"Сумма",true,window)
				guiSetVisible(cashedit,false)
				guiGridListAddColumn(list,"Тип",0.4) guiGridListAddColumn(list,"Описание",0.5)
				for k,v in pairs(getElementData(localPlayer,"vehicles")) do
					local row = guiGridListAddRow(list)
					guiGridListSetItemText(list,row,1,"Автомобиль",false,false)
					guiGridListSetItemText(list,row,2,getVehicleData(v["Model"])[2].." Номер: "..fromJSON(v["Number"])[2],false,false)
					guiGridListSetItemData(list,row,1,v["ID"])
					guiGridListSetItemData(list,row,2,getVehicleData(v["Model"])[3])
					for i=0, guiGridListGetRowCount(items1) do
						local numbers = fromJSON(v["Number"])
						if guiGridListGetItemData(items1,i,1) == v["ID"] or isDonateVehicle(v["Model"]) then
							guiGridListRemoveRow( list, row )
						end
					end
				end
				for k,v in pairs(getElementData(localPlayer,"numbers")) do
					local row = guiGridListAddRow(list)
					guiGridListSetItemText(list,row,1,"Номера",false,false)
					guiGridListSetItemText(list,row,2,v[2],false,false)
					guiGridListSetItemData(list,row,1,v)
					guiGridListSetItemData(list,row,2,v)
					for i=0, guiGridListGetRowCount(items1) do
						if guiGridListGetItemText(items1,i,2) == v[2] then
							guiGridListRemoveRow(list, row )
						end
					end
				end
				local moneyrow = guiGridListAddRow(list)
				guiGridListSetItemText(list,moneyrow,1,"Деньги",false,false)
				guiGridListSetItemText(list,moneyrow,2,getPlayerMoney(localPlayer),false,false)
				guiGridListSetItemData(list,moneyrow,1,getPlayerMoney(localPlayer))
				local xbtn1 = guiCreateButton(0.1,0.85,0.3,0.1,"Отмена",true,window)
				local xbtn2 = guiCreateButton(0.6,0.85,0.3,0.1,"Выбрать",true,window)
				guiSetEnabled(xbtn2,false)

				addEventHandler("onClientGUIChanged",cashedit,function()
					local itemI = guiGridListGetSelectedItem( list )
					if itemI and itemI >= 0 then
						if guiGridListGetItemText(list,itemI,1) == "Деньги" then
							local txt = guiGetText(cashedit)
							if tonumber(txt) and tonumber(txt) >= 0 and  tonumber(txt) <= getPlayerMoney(localPlayer) then
								guiSetEnabled(xbtn2,true)
							else
								guiSetEnabled(xbtn2,false)
							end
						end
					end
				end)

				addEventHandler("onClientGUIClick",window,function()
					if source == list then
						local itemI = guiGridListGetSelectedItem( list )
						if itemI and itemI >= 0 then
							if guiGridListGetItemText(list,itemI,1) == "Деньги" then
								guiSetVisible(cashedit,true)
							else
								guiSetEnabled(xbtn2,true)
								guiSetVisible(cashedit,false)
							end
						else
							guiSetEnabled(xbtn2,false)
						end
					elseif source == cashedit then
						if guiGetText(cashedit) == "Сумма" then
							guiSetText(cashedit,"")
						end
					elseif source == xbtn1 then
						destroyElement(window)
						addOpened = false
					elseif source == xbtn2 then
						local row = guiGridListAddRow(items1)
						local item = guiGridListGetSelectedItem(list)
						if guiGridListGetItemText(list,item,1) == "Деньги" then
							guiGridListSetItemText(items1,cashrow1,2,tonumber(guiGetText(cashedit)),false,false)
							guiGridListSetItemData(items1,cashrow1,1,tonumber(guiGetText(cashedit)))
						else
							guiGridListSetItemText(items1,row,1,guiGridListGetItemText(list,item,1),false,false)
							guiGridListSetItemText(items1,row,2,guiGridListGetItemText(list,item,2),false,false)
							guiGridListSetItemData(items1,row,1,guiGridListGetItemData(list,item,1))
							guiGridListSetItemData(items1,row,2,guiGridListGetItemData(list,item,2))
						end
						local items = {}
						commision = 0
						for i = 0, guiGridListGetRowCount(items1) do
							table.insert(items,{guiGridListGetItemText(items1,i,1),guiGridListGetItemText(items1,i,2),guiGridListGetItemData(items1,i,1),guiGridListGetItemData(items1,i,2)})
							if guiGridListGetItemText(items1,i,1) == "Автомобиль" then
								--outputChatBox(guiGridListGetItemData(items1,i,2))
								--commision = commision + math.floor(tonumber(guiGridListGetItemData(items1,i,2))*0.15)
							elseif guiGridListGetItemText(items1,i,1) == "Номера" then
								--commision = commision + 1000000
							end
							--guiSetText(labelCommission,"Коммиссия: $"..commision)
						end
						triggerServerEvent("updateBarterStatus",localPlayer,ply,items,false,false)
						ready1 = false
						barter1 = false
						destroyElement(window)
						addOpened = false
					end
				end)
			elseif source == btn2 then
				local item = guiGridListGetSelectedItem( items1 )
				if guiGridListGetItemText(items1,item,1) == "Деньги" then
					guiGridListSetItemText(items1,item,2,0,false,false)
					guiGridListSetItemData(items1,item,1,0)
				else
					guiGridListRemoveRow(items1,item)
				end
				local items = {}
				for i = 0, guiGridListGetRowCount(items1) do
					table.insert(items,{guiGridListGetItemText(items1,i,1),guiGridListGetItemText(items1,i,2),guiGridListGetItemData(items1,i,1)})
				end
				triggerServerEvent("updateBarterStatus",localPlayer,ply,items,false,false)
				ready1 = false
				barter1 = false
				guiSetEnabled(btn2,false)
			elseif source == btn3 then
				if ready1 then
					guiStaticImageLoadImage( images[1], "files/notok.png" )
					triggerServerEvent("updateBarterStatus",localPlayer,ply,false,false,false)
				else
					guiStaticImageLoadImage( images[1], "files/ok.png" )
					triggerServerEvent("updateBarterStatus",localPlayer,ply,false,true,false)
					if ready2 then
						guiSetEnabled(buttonTrade,true)
					else
						guiSetEnabled(buttonTrade,false)
					end
				end
				ready1 = not ready1
			elseif source == buttonTrade then
				barter1 = true
				guiStaticImageLoadImage( images[3], "files/ok.png" )
				triggerServerEvent("updateBarterStatus",localPlayer,ply,false,true,true)
				if barter2 == true then
					local itemsToSend1 = {}
					for i = 0, guiGridListGetRowCount(items1) do
						if guiGridListGetItemText(items1,i,1) and guiGridListGetItemText(items1,i,1) ~= "" then
							table.insert(itemsToSend1,{guiGridListGetItemText(items1,i,1),guiGridListGetItemText(items1,i,2),guiGridListGetItemData(items1,i,1),guiGridListGetItemData(items1,i,2)})
						end
					end
					local itemsToSend2 = {}
					for i = 0, guiGridListGetRowCount(items2) do
						if guiGridListGetItemText(items2,i,1) and guiGridListGetItemText(items2,i,1) ~= "" then
							table.insert(itemsToSend2,{guiGridListGetItemText(items2,i,1),guiGridListGetItemText(items2,i,2),guiGridListGetItemData(items2,i,1),guiGridListGetItemData(items2,i,2)})
						end
					end
					triggerServerEvent("finishBarter",localPlayer,localPlayer,ply,itemsToSend1,itemsToSend2)
				end
			elseif source == btn5 then
				initBarterWindow()
				triggerServerEvent( "abortBarter", localPlayer, ply, true )
			end
		end)
	end
end
addEvent("initBarterWindow",true)
addEventHandler("initBarterWindow",root,initBarterWindow)
--initBarterWindow()

function updateBarterStatus(items,ready,barter)
	if items then
		for i = 0, guiGridListGetRowCount(items2) do
			guiGridListRemoveRow(items2,i)
		end
		guiGridListClear(items2)
		for k,v in pairs(items) do
			local row = guiGridListAddRow(items2)
			if v[1] and v[1] ~= "" then
				guiGridListSetItemText(items2,row,1,v[1],false,false)
				guiGridListSetItemText(items2,row,2,v[2],false,false)
				guiGridListSetItemData(items2,row,1,v[3],false,false)
				guiGridListSetItemData(items2,row,2,v[4],false,false)
			end
		end
	end
	if ready then
		ready2 = true
		guiStaticImageLoadImage( images[2], "files/ok.png" )
		if ready1 then
			guiSetEnabled(buttonTrade,true)
		end
		if barter then
			barter2 = true
			guiStaticImageLoadImage( images[4], "files/ok.png" )
		else
			barter2 = false
			guiStaticImageLoadImage( images[4], "files/notok.png" )
		end
	else
		for k,v in pairs(images) do
			guiStaticImageLoadImage( v, "files/notok.png" )
		end
		guiSetEnabled(buttonTrade,false)
		ready1 = false
		barter1 = false
		ready2 = false
		barter2 = false
	end
end
addEvent("updateBarterStatus",true)
addEventHandler("updateBarterStatus",root,updateBarterStatus)

local screenW, screenH = guiGetScreenSize()

local menu = {
    car = "",
	cost = 0,
	active = false,
}

function getVehicleInfo (c1, c2, init)
    if init == true then
        menu.active = false
		return
    end
    menu.car = c1
	menu.cost = convertNumber(vehShopVehicles[currentShop][selection][3])
	menu.active = true
end

function onClientRenderBuyMenu ()
    if menu.active == false then return end 
	
	dxDrawRectangle(0,0,screenW,screenH,tocolor(0,0,0,230), true)
	dxDrawImage(screenW * 0.37, screenH * 0.25, screenW * 0.25, screenH * 0.4100,"files/fon.png", 0, 0, 0, tocolor(255, 255, 255, 255), true )
	
	--dxDrawRectangle(screenW * 0.7778, screenH * 0.3067, screenW * 0.1847, screenH * 0.3100, tocolor(0, 0, 0, 189), true)
	--dxDrawLine(screenW * 0.7778, screenH * 0.3389, screenW * 0.9625, screenH * 0.3389, tocolor(255, 17, 17, 189), 3, true)
	
    dxDrawText("Покупка "..menu.car, screenW * 0.39, screenH * 0.269, screenW * 0.599, screenH * 0.30, tocolor(255, 255, 255, 255), 1.50, "default-bold", "center", "center", false, false, true, false, false)
    dxDrawText("Стоимость: "..menu.cost, screenW * 0.39, screenH * 0.369, screenW * 0.599, screenH * 0.30, tocolor(255, 255, 255, 255), 1.50, "default-bold", "center", "center", false, false, true, false, false)
    -- Кнопка закрыть
	if isCursorOverRectangle(screenW * 0.58, screenH * 0.27, screenW * 0.025, screenH * 0.025) then
		dxDrawRectangle(screenW * 0.58, screenH * 0.27, screenW * 0.025, screenH * 0.025, tocolor(0, 0, 0, 209), true)
		if getKeyState("mouse1") then
			menu.active = false
		end
	else
		dxDrawRectangle(screenW * 0.58, screenH * 0.27, screenW * 0.025, screenH * 0.025, tocolor(180, 180, 180, 150), true)
	end
	dxDrawText("Х", screenW * 0.59, screenH * 0.269, screenW * 0.599, screenH * 0.30, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, true, false, false)
	--кнопка банк
	if isCursorOverRectangle(screenW * 0.39, screenH * 0.3889, screenW * 0.21, screenH * 0.0344) then
		dxDrawRectangle(screenW * 0.39, screenH * 0.3889, screenW * 0.21, screenH * 0.0344, tocolor(255, 255, 255, 209), true)
		if getKeyState("mouse1") then
			menu.active = false
			initVehicleShopWindow()
   		    triggerServerEvent( "buyTheVehicle", localPlayer, "bank", localPlayer,currentShop,vehShopVehicles[currentShop][selection][1],currentColor,currentWheels, reg)
			executeCommandHandler ("hud_off")
			showChat (true)
		end
	else
		dxDrawRectangle(screenW * 0.39, screenH * 0.3889, screenW * 0.21, screenH * 0.0344, tocolor(255, 255, 255, 150), true)
	end
	dxDrawText("Оплата с банковского счёта", screenW * 0.2, screenH * 0.3878, screenW * 0.8, screenH * 0.4233, tocolor(0, 0, 0, 209), 1.00, "default-bold", "center", "center", false, false, true, false, false)
    
	-- кнопка нал
	if isCursorOverRectangle(screenW * 0.39, screenH * 0.4522, screenW * 0.21, screenH * 0.0344) then
		dxDrawRectangle(screenW * 0.39, screenH * 0.4522, screenW * 0.21, screenH * 0.0344, tocolor(255, 255, 255, 209), true)
		if getKeyState("mouse1") then
			menu.active = false
			initVehicleShopWindow()
            triggerServerEvent( "buyTheVehicle",localPlayer, "nall", localPlayer,currentShop,vehShopVehicles[currentShop][selection][1],currentColor,currentWheels, reg)
			executeCommandHandler ("hud_off")
			showChat (true)
		end
	else
		dxDrawRectangle(screenW * 0.39, screenH * 0.4522, screenW * 0.21, screenH * 0.0344, tocolor(255, 255, 255, 150), true)
	end
	dxDrawText("Оплата наличными", screenW * 0.2, screenH * 0.4511, screenW * 0.8, screenH * 0.4867, tocolor(0, 0, 0, 209), 1.00, "default-bold", "center", "center", false, false, true, false, false)
   
end
addEventHandler("onClientRender", getRootElement(), onClientRenderBuyMenu)

--//triggerServerEvent( "buyTheVehicle", localPlayer, localPlayer,currentShop,vehShopVehicles[currentShop][selection][1],currentColor,currentWheels, reg)


function refreshCarClient ()
triggerServerEvent( "refreshCar", localPlayer, localPlayer)
end