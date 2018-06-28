local scx,scy = guiGetScreenSize()
local px = scx/1920
local font20 = guiCreateFont( "files/font.ttf", 15*px )
local numberFont = dxCreateFont("files/numbers.ttf", 28)
local isPlayerCanClick = true

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

local plateShaders = {}
local markers = 
{
	{-1611.251953125,674.7431640625,6.1},
	{-1611.251953125,684.7431640625,6.1},
}



for k,v in pairs(markers) do
	local marker = createMarker(v[1],v[2],v[3],"cylinder",3, 200,150,0,150)
	setElementData(marker,"nomera",true)
end

local numberWindow = nil
local currentNumberType = false

addEventHandler("onClientMarkerHit",root,function(ply)
	if getElementData(source,"nomera") and ply == localPlayer then
		if isPedInVehicle( ply ) then
			initNewNumberWindow()
		end
	end
end)


local sizeX,sizeY = 1000*px,500*px
local posX,posY = scx/2-sizeX/2, scy/2-sizeY/2+100*px
local windowShown = false
local window = nil
local elements = {}
local oldNumber = "-"
local newNumber = "-"
local price = ""
local adminState = false
local chaikosText = ""

addEventHandler ("onClientRender", root, function ()
if windowShown ~= false then
	toggleAllControls (false)
else
	toggleAllControls (true)
end
end)

function initNewNumberWindow(admin)
	if windowShown then
		showCursor(false)
		windowShown = false
		removeEventHandler("onClientRender",root,drawNumberWindow)
		for k,v in pairs(elements) do
			if isElement(v) then
				destroyElement(v)
			end
		end
		elements = {}
	else
		local veh = getPedOccupiedVehicle( localPlayer )
		if veh then
			oldNumber = getElementData(veh,"number:plate") or "-"
		end
		newNumber = "-"
		windowShown = true
		showCursor(true)
		adminState = admin
		addEventHandler("onClientRender",root,drawNumberWindow)
		guiCreateEdit(posX+340*px,posY+sizeY/2+80*px,240*px,50*px,"Введите Регион", false)
		--guiSetFont(elements.edit,font20)
		--guiEditSetReadOnly( elements.edit, true )
		--[[addEventHandler("onClientGUIChanged",elements.edit,function()
		    outputChatBox(currentNumberType)
		    if currentNumberType == "ua" then
			    guiSetText(source, guiGetText(source):gsub("[^0-9]",""))
			else
			    guiSetText(source, guiGetText(source):gsub("([ABEIKMHOPCTX][ABEIKMHOPCTX])[-](%d)$", "") )
			end
			local text = guiGetText(elements.edit)
			chaikosText = text
			if isCorrectNumber(currentNumberType,text) then
				newNumber = text
				price = "$"..getNumberPrice(text)
			else
				newNumber = "-"
				price = ""
			end
		end)]]--
		--[[addEventHandler("onClientGUIClick",elements.edit,
		    function()
		        local text = guiGetText(elements.edit)
			    if text == "Введите Регион" then
				    guiSetText(elements.edit, "")
				end
			end
		)]]--
	end
end
addEvent("initNewNumberWindow", true)
addEventHandler("initNewNumberWindow", root, initNewNumberWindow)

function drawNumberWindow()
    if currentNumberType == "ua" then
	
	else
	
	end
	dxDrawRectangle(posX,posY,250*px,sizeY,tocolor(0,0,0,230))
	dxDrawRectangle(posX+260*px,posY,400*px,sizeY/2-10*px,tocolor(0,0,0,230))
	dxDrawText("Ваш старый номер",posX+260*px,posY,posX+260*px+400*px,posY+50*px,tocolor(255,255,255),2,"default-bold","center","center")
	dxDrawText(oldNumber,posX+260*px,posY+50*px,posX+260*px+400*px,posY+80*px,tocolor(150,150,150),2,"default-bold","center","center")
	dxDrawText("Ваш новый номер",posX+260*px,posY+100*px,posX+260*px+400*px,posY+150*px,tocolor(255,255,255),2,"default-bold","center","center")
	dxDrawText(newNumber,posX+260*px,posY+150*px,posX+260*px+400*px,posY+180*px,tocolor(159,150,255),2,"default-bold","center","center")
	dxDrawRectangle(posX+260*px,posY+sizeY/2,400*px,sizeY/2,tocolor(0,0,0,230))
	if getNumbersData(currentNumberType) then
		dxDrawText("Формат номера",posX+260*px,posY+260*px,posX+260*px+400*px,posY+280*px,tocolor(100,100,100),1,"default-bold","center","top")
		dxDrawText(getNumbersData(currentNumberType)[4],posX+260*px,posY+280*px,posX+260*px+400*px,posY+280*px,tocolor(150,150,155),2,"default-bold","center","top")
	end
	
	if currentNumberType ~= false then
	    if isCursorOverRectangle(posX+440*px,posY+430*px,200*px,50*px) then
		    dxDrawRectangle(posX+440*px,posY+430*px,200*px,50*px,tocolor(0,200,0,230))
		    if getKeyState("mouse1") then
			    if isPlayerCanClick == false then return end
			    isPlayerCanClick = false
			    setTimer(
	    		    function ()
		   		    	isPlayerCanClick = true
					end, 700, 1
				)
			    if getPlayerMoney( ) >= 5000 then
					createRandomNumber(currentNumberType)
				else
				    outputChatBox("Недостаточно денег!", 255, 0, 0)
			    end
		    end
	    else
		    dxDrawRectangle(posX+440*px,posY+430*px,200*px,50*px,tocolor(0,120,0,230))
	    end
	else
		dxDrawRectangle(posX+440*px,posY+430*px,200*px,50*px,tocolor(120,120,120,230))
	end
	dxDrawText("Cлучайные\n 5000$",posX+440*px,posY+430*px,posX+640*px,posY+480*px,tocolor(255,255,255),1,"default-bold","center","center")
	--===========================
	
	
	if isCursorOverRectangle(posX+280*px,posY+430*px,150*px,50*px) then
		dxDrawRectangle(posX+280*px,posY+430*px,150*px,50*px,tocolor(200, 0, 0,230))
		if getKeyState("mouse1") then
		    if isPlayerCanClick == false then return end
			isPlayerCanClick = false
			setTimer(
	    		function ()
		   		   	isPlayerCanClick = true
				end, 700, 1
			)
			initNewNumberWindow()
		end
	else
		dxDrawRectangle(posX+280*px,posY+430*px,150*px,50*px,tocolor(229,59,59,230))
	end
	dxDrawText("Отмена",posX+280*px,posY+430*px,posX+430*px,posY+480*px,tocolor(255,255,255),1,"default-bold","center","center")

	local typeY = 50*px
	dxDrawRectangle(posX,posY,250*px,40*px,tocolor(229,59,59,230))
	dxDrawText("Выберите тип",posX,posY,posX+250*px,posY+typeY,tocolor(255,255,255),1,"default-bold","center","center")
	for k,v in pairs(numberTypes) do
		if v[3] or adminState == true then
			if isCursorOverRectangle(posX+5*px,posY+typeY,240*px,40*px) or currentNumberType == v[1] then
				dxDrawRectangle(posX+5*px,posY+typeY,240*px,40*px,tocolor(229,59,59,230))
				
				dxDrawText(v[2],posX,posY+typeY,posX+250*px,posY+typeY+40*px,tocolor(255,255,255),1,"default-bold","center","center")
				if getKeyState("mouse1") then
				   -- createTimerForCheck ()
					currentNumberType = v[1]
					if isElement(elements.edit) then
					    guiEditSetReadOnly( elements.edit, false )
				        guiSetText(elements.edit, "Введите Регион")
					end
				end
			else
				dxDrawRectangle(posX+5*px,posY+typeY,240*px,40*px,tocolor(103,103,103,230))
				dxDrawText(v[2],posX,posY+typeY,posX+250*px,posY+typeY+40*px,tocolor(255,255,255),1,"default-bold","center","center")
			end
		end
		--dxDrawText( string text, float left, float top [, float right=left, float bottom=top, int color=white,                   float scale=1, mixed font="default", string alignX="left", string alignY="top",                  bool clip=false, bool wordBreak=false, bool postGUI=false,                  bool colorCoded=false, bool subPixelPositioning=false,                   float fRotation=0, float fRotationCenterX=0, float fRotationCenterY=0 ] )
		typeY=typeY+43*px
	end
end
--initNewNumberWindow(true)




-- русские номера
local textOffset = 12
local textWidth = 164
local numberHeight = 64

local regionOffset = 197
local regionWidth = 47
local regionHeight = 47

function russionNumberPlate ( text, vehicle )
	renderTarget = dxCreateRenderTarget(256, 64)
	dxSetRenderTarget(renderTarget)
	dxDrawImage(0, 0, 256, 64, dxCreateTexture("number/number_ru.png") )
	dxDrawText(string.match(text, "^%a" ), textOffset-5, 0, textOffset + textWidth, numberHeight, tocolor(0, 0, 0), 1, numberFont, "left", "center")
	dxDrawText(string.match(text, "%d%d%d" ), textOffset-20, 0, textOffset + textWidth, numberHeight, tocolor(0, 0, 0), 1, numberFont, "center", "center")
	dxDrawText(string.match(text, "%a%a" ), textOffset, 0, textOffset + textWidth + 10, numberHeight, tocolor(0, 0, 0), 1, numberFont, "right", "center")
	dxDrawText(string.match(text, "%d+$" ), regionOffset, 0, regionOffset + regionWidth, regionHeight, tocolor(0, 0, 0), 0.65, numberFont, "center", "center")
	dxSetRenderTarget()
	
	local texture = getTextureFromRenderTarget(renderTarget)
	destroyElement(renderTarget)
	return texture
end

-- Полицейские номера
function policeNumberPlate ( text, vehicle )
	renderTarget = dxCreateRenderTarget(256, 64)
	dxSetRenderTarget(renderTarget)
	dxDrawImage(0, 0, 256, 64, dxCreateTexture("number/number_police.png") )
	dxDrawText(string.match(text, "^%a" ), textOffset, 0, textOffset + textWidth, numberHeight, tocolor(255, 255, 255), 1, numberFont, "left", "center")
	dxDrawText(string.match(text, "%d%d%d%d" ), textOffset+30, 0, textOffset + textWidth, numberHeight, tocolor(255, 255, 255), 1, numberFont, "center", "center")
	dxDrawText(string.match(text, "%d+$",6 ), regionOffset, 0, regionOffset + regionWidth, regionHeight, tocolor(255, 255, 255), 0.65, numberFont, "center", "center")
	dxSetRenderTarget()
	
	local texture = getTextureFromRenderTarget(renderTarget)
	destroyElement(renderTarget)
	return texture
end


-- Черные номера
function blackNumberPlate ( text, vehicle )
	renderTarget = dxCreateRenderTarget(256, 64)
	dxSetRenderTarget(renderTarget)
	dxDrawImage(0, 0, 256, 64, dxCreateTexture("number/black.png") )
	dxDrawText(string.match(text, "^%d%d%d%d" ), textOffset, 0, textOffset + textWidth, numberHeight, tocolor(255, 255, 255), 1, numberFont, "left", "center")
	dxDrawText(string.match(text, "%a%a" ), textOffset+120, 0, textOffset + textWidth, numberHeight, tocolor(255, 255, 255), 1, numberFont, "center", "center")
	dxDrawText(string.match(text, "%d%d",6 ), regionOffset, 0, regionOffset + regionWidth, regionHeight, tocolor(255, 255, 255), 0.65, numberFont, "center", "center")
	dxSetRenderTarget()
	
	local texture = getTextureFromRenderTarget(renderTarget)
	destroyElement(renderTarget)
	return texture
end

-- автобусные номера
local bus_textOffset = 12
local bus_textWidth = 164
local bus_numberHeight = 64

local bus_regionOffset = 197
local bus_regionWidth = 47
local bus_regionHeight = 47

function busNumberPlate ( text, vehicle )
	renderTarget = dxCreateRenderTarget(256, 64)
	dxSetRenderTarget(renderTarget)
	dxDrawImage(0, 0, 256, 64, dxCreateTexture("number/number_bus.png") )
	dxDrawText(string.match(text, "^%a%a" ), bus_textOffset, 0, bus_textOffset + bus_textWidth, bus_numberHeight, tocolor(0, 0, 0), 1, numberFont, "left", "center")
	dxDrawText(string.match(text, "%d%d%d" ), bus_textOffset+60, 0, bus_textOffset + bus_textWidth, bus_numberHeight, tocolor(0, 0, 0), 1, numberFont, "center", "center")
	--dxDrawText(string.match(text, "%a%a" ), bus_textOffset, 0, bus_textOffset + bus_textWidth + 10, bus_numberHeight, tocolor(0, 0, 0), 1, numberFont, "right", "center")
	dxDrawText(string.match(text, "%d+$",6 ), bus_regionOffset, 0, bus_regionOffset + bus_regionWidth, bus_regionHeight, tocolor(0, 0, 0), 0.5, numberFont, "center", "center")
	dxSetRenderTarget()
	
	local texture = getTextureFromRenderTarget(renderTarget)
	destroyElement(renderTarget)
	return texture
end

-- укринские номера
local ua_textOffset = 60
local ua_textWidth = 164
local ua_numberHeight = 64

function ukraineNumberPlate ( text, vehicle)
	renderTarget = dxCreateRenderTarget(256, 64)
	dxSetRenderTarget(renderTarget)
	dxDrawImage(0, 0, 256, 64, dxCreateTexture("number/number_ua.png") )
	dxDrawText( string.match(text, "^%a%a" ), ua_textOffset-30, 0, ua_textOffset + ua_textWidth, ua_numberHeight-15, tocolor(0, 0, 0), 1, 1.5, numberFont, "left", "center")
	dxDrawText( string.gsub(text, "%a", "" ), ua_textOffset, 0, ua_textOffset + ua_textWidth, ua_numberHeight, tocolor(0, 0, 0), 0.8, 1.2, numberFont, "center", "center")
	dxDrawText( string.match(text, "%a%a$" ), ua_textOffset, 0, ua_textOffset + ua_textWidth +25, ua_numberHeight-15, tocolor(0, 0, 0), 1, 1.5, numberFont, "right", "center")
	dxSetRenderTarget()
	
	local texture = getTextureFromRenderTarget(renderTarget)
	destroyElement(renderTarget)
	return texture
end

-- казахстанские номера
local kz_textOffset = 40
local kz_textWidth = 256
local kz_numberHeight = 64

function kzNumberPlate ( text, vehicle )
	renderTarget = dxCreateRenderTarget(256, 64)
	dxSetRenderTarget(renderTarget)
	dxDrawImage(0, 0, 256, 64, dxCreateTexture("number/number_kz.png") )
	dxDrawText(string.gsub(text, "(%a%a+)(%d%d)$", "" ), kz_textOffset, 0, kz_textOffset + kz_textWidth, kz_numberHeight, tocolor(0, 0, 0), 0.95, numberFont, "left", "center")
	dxDrawText(string.gsub(text, "%d", "" ), kz_textOffset-25, 0, kz_textOffset + kz_textWidth, kz_numberHeight, tocolor(0, 0, 0), 0.95, numberFont, "center", "center")
	dxDrawText(string.gsub(text, "^(%d%d%d)(%a%a+)", "" ), kz_textOffset+115, 0, kz_textOffset + kz_textWidth, kz_numberHeight, tocolor(0, 0, 0), 0.95, numberFont, "center", "center")
	dxSetRenderTarget()
	
	local texture = getTextureFromRenderTarget(renderTarget)
	destroyElement(renderTarget)
	return texture
end

-- белорусские номера
local by_textOffset = 40
local by_textWidth = 256
local by_numberHeight = 64

function byNumberPlate ( text, vehicle )
	renderTarget = dxCreateRenderTarget(256, 64)
	dxSetRenderTarget(renderTarget)
	dxDrawImage(0, 0, 256, 64, dxCreateTexture("number/number_by.png") )
	dxDrawText(string.gsub(text, "([ABEIKMHOPCTX][ABEIKMHOPCTX])[-](%d)$", "" ), by_textOffset, 0, by_textOffset + by_textWidth, by_numberHeight, tocolor(0, 0, 0), 3.5, 4.5, "default-bold", "left", "center")
	dxDrawText(string.gsub(text, "^(%d%d%d%d)", "" ), by_textOffset, 0, by_textOffset + by_textWidth - 45, by_numberHeight, tocolor(0, 0, 0), 3.5, 4.5, "default-bold", "right", "center")
		
	dxSetRenderTarget()
	
	local texture = getTextureFromRenderTarget(renderTarget)
	destroyElement(renderTarget)
	return texture
end

-- азейборджанские номера
local arm_textOffset = 55
local arm_textWidth = 256
local arm_numberHeight = 64

function armNumberPlate ( text, vehicle)
	renderTarget = dxCreateRenderTarget(256, 64)
	dxSetRenderTarget(renderTarget)
	dxDrawImage(0, 0, 256, 64, dxCreateTexture("number/number_arm.png") )
	--dxDrawText(string.gsub(text, "", "" ), arm_textOffset, 0, arm_textOffset + arm_textWidth, arm_numberHeight, tocolor(0, 0, 0), 3.4, 4.5, "default-bold", "left", "center")
	dxDrawText(string.match(text, "^%d%d" ), arm_textOffset, 0, arm_textOffset + arm_textWidth, arm_numberHeight, tocolor(0, 0, 0), 0.95, numberFont, "left", "center")
	dxDrawText(""..string.match(text, "%a%a" ), arm_textOffset+55, 0, arm_textOffset + arm_textWidth, arm_numberHeight, tocolor(0, 0, 0), 0.95, numberFont, "left", "center")
	dxDrawText(""..string.match(text, "%d%d%d" ), arm_textOffset+115, 0, arm_textOffset + arm_textWidth, arm_numberHeight, tocolor(0, 0, 0), 0.95, numberFont, "left", "center")
	dxSetRenderTarget()
	
	local texture = getTextureFromRenderTarget(renderTarget)
	destroyElement(renderTarget)
	return texture
end

-- пустые номера
local c_textOffset = 0
local c_textWidth = 256
local c_numberHeight = 64

function clearNumberPlate ( text, vehicle )
	renderTarget = dxCreateRenderTarget(256, 64)
	dxSetRenderTarget(renderTarget)
	dxDrawImage(0, 0, 256, 64, dxCreateTexture("number/number_c.png") )
	dxDrawText(text, c_textOffset, 0, c_textOffset + c_textWidth, c_numberHeight, tocolor(0, 0, 0), 2, 4, "default", "center", "center")
	dxSetRenderTarget()
	local texture = getTextureFromRenderTarget(renderTarget)
	destroyElement(renderTarget)
	return texture
end

function getTextureFromRenderTarget(renderTarget)
	return dxCreateTexture(dxGetTexturePixels(renderTarget))
end

-- установка номера
function setVehicleNumberPlate ( vehicle )
	if not plateShaders[vehicle] then
		plateShaders[vehicle] = dxCreateShader("files/texreplace.fx")
	end
	if not getElementData (vehicle, "numberType" ) then return end
	engineApplyShaderToWorldTexture(plateShaders[vehicle], "nomer", vehicle)

	if getElementData (vehicle, "numberType") == "ru" then
		if not getElementData (vehicle, "number:plate" ) then return end
		texture = russionNumberPlate ( getElementData (vehicle, "number:plate"), vehicle)
		dxSetShaderValue(plateShaders[vehicle], "gTexture", texture)
	elseif getElementData (vehicle, "numberType") == "ua" then
		if not getElementData (vehicle, "number:plate" ) then return end
		texture = ukraineNumberPlate ( getElementData (vehicle, "number:plate"), vehicle )
		dxSetShaderValue(plateShaders[vehicle], "gTexture", texture)
	elseif getElementData (vehicle, "numberType" ) == "c" then
		if not getElementData (vehicle, "number:plate" ) then return end
		texture = clearNumberPlate ( getElementData (vehicle, "number:plate"), vehicle )
		dxSetShaderValue(plateShaders[vehicle], "gTexture", texture)
	elseif getElementData (vehicle, "numberType" ) == "kz" then
		if not getElementData (vehicle, "number:plate" ) then return end
		texture = kzNumberPlate ( getElementData (vehicle, "number:plate"), vehicle)
		dxSetShaderValue(plateShaders[vehicle], "gTexture", texture)
	elseif getElementData (vehicle, "numberType" ) == "arm" then
		if not getElementData (vehicle, "number:plate" ) then return end
		texture = armNumberPlate ( getElementData (vehicle, "number:plate"), vehicle)
		dxSetShaderValue(plateShaders[vehicle], "gTexture", texture)
	elseif getElementData (vehicle, "numberType" ) == "by" then
		if not getElementData (vehicle, "number:plate" ) then return end
		texture = byNumberPlate ( getElementData (vehicle, "number:plate"), vehicle)
		dxSetShaderValue(plateShaders[vehicle], "gTexture", texture)
	elseif getElementData (vehicle, "numberType" ) == "police" then
		if not getElementData (vehicle, "number:plate" ) then return end
		texture = policeNumberPlate ( getElementData (vehicle, "number:plate"), vehicle )
		dxSetShaderValue(plateShaders[vehicle], "gTexture", texture)
	elseif getElementData (vehicle, "numberType" ) == "black" then
		if not getElementData (vehicle, "number:plate" ) then return end
		texture = blackNumberPlate ( getElementData (vehicle, "number:plate"), vehicle )
		dxSetShaderValue(plateShaders[vehicle], "gTexture", texture)
	elseif getElementData (vehicle, "numberType" ) == "bus" then
		if not getElementData (vehicle, "number:plate" ) then return end
		texture = busNumberPlate ( getElementData (vehicle, "number:plate"), vehicle )
		dxSetShaderValue(plateShaders[vehicle], "gTexture", texture)
	end
end

addEventHandler( "onClientElementStreamIn", getRootElement(), function()
	if getElementType( source ) == "vehicle" then
	if not getElementData (source, "numberType" ) then return end
	setVehicleNumberPlate ( source )
	end
end)

addEventHandler ( "onClientElementDataChange", getRootElement(),
function ( dataName )
	if getElementType ( source ) == "vehicle" and dataName == "number:plate" then
		setVehicleNumberPlate ( source )
	end
end )

local smb = {
    "A",
	"B",
	"C",
	"E",
	"H",
    "K",
	"M",
	"O",
	"P",
	"T",
	"X",
	"Y"
}

function createRandomNumber(country)
    local num = generateNums (country)	
	local region = calculateSymbolsInRow (country, #chaikosText)
	--outputChatBox(num..chaikosText)
	if region == true then
	    triggerServerEvent("buyNumberPlate",localPlayer, currentNumberType, num..chaikosText, 5000)
		
		local vehicle = getPedOccupiedVehicle(getLocalPlayer())
		setElementData(vehicle, "numberType", country)
		setElementData(vehicle, "number:plate", num..chaikosText)
	else
	    outputChatBox("Введен не корректный регион!", 255, 0, 0)
	end
end

function calculateSymbolsInRow (country, text)
    if text <= 0 then return end
    if country == "ru" then
        if text <= 3 then return true end
	elseif country == "ua" then
        if text <= 2 then return true end
	elseif country == "kz" then
        if text <= 2 then return true end
	elseif country == "by" then
        if text <= 1 then return true end
	elseif country == "arm" then
        if text <= 3 then return true end
	end
	return false
end
 
function generateNums (country)	
	local num = ""
	if country == "ru" then
	    num = num..smb[math.random(1, #smb)]
		for i = 1,3 do
		    num = num..math.random(0,9)
		end
		for i = 1, 2 do
		    num = num..smb[math.random(1, #smb)]
		end
		return num
	elseif country == "ua" then
	    for i = 1, 2 do
		    num = num..smb[math.random(1, #smb)]
		end
		for i = 1,4 do
		    num = num..math.random(0,9)
		end
		return num
	elseif country == "kz" then
	    for i = 1,3 do
		    num = num..math.random(0,9)
		end
		for i = 1, 2 do
		    num = num..smb[math.random(1, #smb)]
		end
		return num
	elseif country == "by" then
	    for i = 1,4 do
		    num = num..math.random(0,9)
		end
		for i = 1, 2 do
		    num = num..smb[math.random(1, #smb)]
		end
		num = num.."-"
		return num
	elseif country == "arm" then
	    for i = 1,2 do
		    num = num..math.random(0,9)
		end
		for i = 1, 2 do
		    num = num..smb[math.random(1, #smb)]
		end
		return num
	end
end