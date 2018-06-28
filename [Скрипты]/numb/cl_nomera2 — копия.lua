tableMarker = {
{-1615.9910888672,686.37036132813,7.1875},
{1580.4874267578,-1634.5069580078,13.561723709106},
{2251.1071777344,2490.2644042969,10.990804672241},
}

addEventHandler ("onClientResourceStart", getResourceRootElement(getThisResource()), function ()
for _, pos in ipairs (tableMarker) do
marker = createMarker (pos[1], pos[2], pos[3]-1, "cylinder", 1.5, 0, 0, 255, 150)
createBlipAttachedTo (marker, "7", 255, 255, 255, 255, 0, 100)
end
end)

addEventHandler ("onClientMarkerHit", root, function ()
if isElementWithinMarker(localPlayer, marker) then
if guiGetVisible (window) ~= true then
guiSetVisible (window, true)
showCursor (true)
writeCar ()
end
end
end)

local screenW, screenH = guiGetScreenSize()
        window = guiCreateWindow((screenW - 493) / 2, (screenH - 200) / 2, 493, 200, "Установка номеров", false)
        guiWindowSetSizable(window, false)
		guiSetVisible (window, false)
        box = guiCreateComboBox(9, 26, 174, 91, "Выберите страну", false, window)
        guiComboBoxAddItem(box, "Российские")
        guiComboBoxAddItem(box, "Белорусские")
        guiComboBoxAddItem(box, "Казахстанские")
        guiComboBoxAddItem(box, "Украинские")
        list = guiCreateGridList(10, 57, 316, 133, false, window)
		guiGridListSetSelectionMode(list, 0)
        guiGridListAddColumn(list, "id", 0.3)
        guiGridListAddColumn(list, "Машина", 0.3)
        guiGridListAddColumn(list, "Номер", 0.3)
        edit = guiCreateEdit(188, 26, 138, 29, "Регион", false, window)
        give = guiCreateButton(335, 57, 147, 46, "Получить номера", false, window)
        guiSetProperty(give, "NormalTextColour", "FFAAAAAA")
        destroy = guiCreateButton(335, 113, 147, 46, "Снять номера", false, window)
        guiSetProperty(destroy, "NormalTextColour", "FFAAAAAA")
        close = guiCreateButton(335, 165, 147, 26, "Закрыть", false, window)
        guiSetProperty(close, "NormalTextColour", "FFAAAAAA")
        label = guiCreateLabel(344, 26, 128, 29, "TRAP_MAFIA.RP", false, window)
        guiLabelSetHorizontalAlign(label, "center", false)    

smb =
{
	'A',
	'B',
	'C',
	'Y',
	'O',
	'P',
	'T',
	'E',
	'X',
	'M',
	'H',
	'K'
}

customCarNames = -- новые названия
{
	[542] = "Chevrolet Camaro SS ",
	[445] = "BMW E34 ",
	[602] = "Nissan GTR ",
	[429] = "Aston Martin ",
	[559] = "Lambarghini Murcielago ",
	[426] = "Dodge Charger R/T ",
	[506] = "Mazda RX-8 ",
	[526] = "Audi S8 ",
	[496] = "BMW M6 ",
	[402] = "Tesla Model S ",
	[405] = "Mersedes Bens E63 AMG ",
	[418] = "Jeep Grand Cherokee SRT8 ",
	[494] = "Buggati Veyron ",
	[579] = "Mersedes Bens G65 AMG ",
	[400] = "Range Rover Sport ",
	[470] = "BMW X6M ",
	[551] = "Mitsubishi EVO X ",
	[458] = "Audi Q7 ",
	[401] = "McLaren MP4 ",
	[562] = "Ford Mustang RTR ",
	[554] = "Mersedes Benz GL 63 ",
	[421] = "BMW M5 E60 ",
	[560] = "Mersedes Benz w140 ",
	[550] = "BMW 750i ",
	[516] = "ВАЗ 2101 ",
	[492] = "ВАЗ 2106 ",
	[419] = "ВАЗ 2103 ",
	[404] = "ВАЗ 2104 ",
	[604] = "ВАЗ 2107 ",
	[580] = "ВАЗ 2109 ",
	[566] = "ВАЗ 21099 ",
	[565] = "ВАЗ 2112 ",
	[546] = "ВАЗ 2114 ",
	[547] = "ВАЗ 2115 ",
	[540] = "ВАЗ Приора ",
	[442] = "Гранта ",
	[536] = "Toyota Supra ",
	[575] = "Nissan Silvia S15 ",
	[518] = "Nissan 350Z ",
	[527] = "Mazda RX 7 ",
	[589] = "Nissan 240SX ",
	[474] = "Chevrole Corvette ",
	[451] = "Buggati Chiron ",
}




function open ()
if guiGetVisible (window) ~= true then
guiSetVisible (window, true)
open = 1
showCursor (true)
writeCar ()
else
open = 0
guiSetVisible (window, false)
showCursor (false)
end
end
addCommandHandler ("NomeraAdmin", open)

function writeCar ()
if open ~= 0 then
	local data = getElementData(localPlayer, "VehicleInfo")
	if data then
		local rw, cl = guiGridListGetSelectedItem(list)
		guiGridListClear(list)
		for i, data in ipairs (data) do
			local carName = customCarNames[ tonumber(data['Model']) ] or getVehicleNameFromModel(data["Model"])
			local ID = data["ID"]
			local numbers = data['numbers']
			local reg = data['region']
			local Cost = data["Cost"]
			local HP = math.floor(data["HP"])
			local PreCost = math.ceil(Cost*.9*HP/100/10)
			local row = guiGridListAddRow(list)
			guiGridListSetItemText(list, row, 1, ID, false, true)
			guiGridListSetItemData(list, row, 1, ID)
			guiGridListSetItemText(list, row, 2, carName, false, true)
			if reg then
			guiGridListSetItemText(list, row, 3, reg, false, true)
			else
			guiGridListSetItemText(list, row, 3, "-", false, true)
			end
		end
		guiGridListSetSelectedItem(list, rw, cl)
	end
end
end
addEventHandler ("onClientElementDataChange", root, writeCar)

regru = {
"01",
"02",
"03",
"04",
"05",
"06",
"07",
"08",
"09",
"102",
"777",
"150",
"10",
"11",
"12",
"13",
"14",
"15",
"16",
"17",
"18",
"19",
"20",
"21",
"22",
"77",
"95",
"55",
"138"
}

regby = {
"1",
"2",
"3",
"4",
"5",
"6",
"7"
}

regua = {
"AB",
"AK",
"AC",
"AE",
"AH",
"AM",
"AO",
"AP",
"AT",
"AA",
"AI",
"BA",
"BB",
"BC",
"BH",
"BI",
"BK",
"CH",
"BM",
"BO",
"AX",
"BT",
"BX",
"CA",
"CB",
"CE"
}

regkz = {
"03",
"04",
"05",
"02",
"01",
"06",
"16",
"08",
"07",
"09",
"10",
"11",
"12",
"14",
"15",
"13"
}

addEventHandler ("onClientGUIClick", getRootElement(), function ()
country = {}
local veh = guiGridListGetItemData (list, guiGridListGetSelectedItem(list), 1)
vehicle = getVehicleByID(veh)
if (source == give) then
	if guiComboBoxGetItemText (box, guiComboBoxGetSelected(box)) == 'Выберите страну' or guiGetText (edit) == 'Регион' then
		outputChatBox("Проверьте правильность ввода данных", 255, 0, 0)
	else
		if guiComboBoxGetItemText (box, guiComboBoxGetSelected(box)) == "Российские" then
			if getElementData(vehicle, "numberType") ~= "ru"  then
			for _, regionsru in ipairs (regru) do
			if guiGetText (edit) == regionsru then --or tonumber(guiGetText (edit)) == number then
				country = "ru"
				createRandomNumber ("ru", guiGetText (edit))
			else
				--outputChatBox("Такого региона нету!", 255, 0, 0)
			end
			end
			end
		elseif guiComboBoxGetItemText (box, guiComboBoxGetSelected(box)) == "Белорусские" then
			if getElementData(vehicle, "numberType") ~= "by"  then
			for _, regionsby in ipairs (regby) do
			if guiGetText (edit) ~= regionsby then
			--outputChatBox("Такого региона нету!", 255, 0, 0)
			else
			country = "by"
			createRandomNumber ("by", guiGetText (edit))
			end
			end
			end
		elseif guiComboBoxGetItemText (box, guiComboBoxGetSelected(box)) == "Украинские" then
			if getElementData(vehicle, "numberType") ~= "ua"  then
			for _, regionsua in ipairs (regua) do
			if guiGetText (edit) ~= regionsua then
			--outputChatBox("Такого региона нету!", 255, 0, 0)
			else
			country = "ua"
			createRandomNumber ("ua", guiGetText (edit))
			end
			end
			end
		elseif guiComboBoxGetItemText (box, guiComboBoxGetSelected(box)) == "Казахстанские" then
			if getElementData(vehicle, "numberType") ~= "kz"  then
			for _, regionskz in ipairs (regkz) do
			if guiGetText (edit) ~= regionskz then
			--outputChatBox("Такого региона нету!", 255, 0, 0)
			else
			country = "kz"
			createRandomNumber ("kz", guiGetText (edit))
			end
			end
			end
		end
		--print (country)
	end
elseif (source == destroy) then
	if getElementData(vehicle, "numberType") then
	destroyPlate ()
	takePlayerMoney (20000)
	end
elseif (source == close) then
	open = 0
	showCursor (false)
	guiSetVisible (window, false)
	end
end)

chaikosText = ""
function createRandomNumber(country, regionEdit)
    local num = generateNums (country)	
	local region = calculateSymbolsInRow (country, #regionEdit)
	print (num, regionEdit)
	if region == true then		
		local veh = guiGridListGetItemData (list, guiGridListGetSelectedItem(list), 1)
		local car = guiGridListGetItemText (list, guiGridListGetSelectedItem(list), 2)
		local vehicle = getVehicleByID(veh)
		triggerServerEvent("buyNumberPlate", localPlayer, veh, region, num..regionEdit, 5000)
		outputChatBox ("#00FF00Номера #FFCC00"..num..regionEdit.."#00FF00 успешно поставлены на ваш #FFCC00"..car, 255, 255, 255, true)
		setElementData(vehicle, "numberType", country)
		setElementData(vehicle, "number:plate", num..regionEdit)
	end
end

function getVehicleByID(id)
	v = false
	for i, veh in ipairs (getElementsByType("vehicle")) do
		if getElementData(veh, "ID") == id then
			v = veh
			break
		end
	end
	return v
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


local textOffset = 12
local textWidth = 164
local numberHeight = 64

local regionOffset = 197
local regionWidth = 47
local regionHeight = 47

numberFont = dxCreateFont("files/numbers.ttf", 28)

function russionNumberPlate ( text, vehicle )
	renderTarget = dxCreateRenderTarget(256, 64)
	dxSetRenderTarget(renderTarget)
	dxDrawImage(0, 0, 256, 64, dxCreateTexture("number/number_ru.png") )
	dxDrawText(string.match(text, "^%a" ), textOffset-10, 0, textOffset + textWidth, numberHeight, tocolor(0, 0, 0), 1, numberFont, "left", "center")
	dxDrawText(string.match(text, "%d%d%d" ), textOffset-30, 0, textOffset + textWidth, numberHeight, tocolor(0, 0, 0), 1, numberFont, "center", "center")
	dxDrawText(string.match(text, "%a%a" ), textOffset, 0, textOffset + textWidth + 10, numberHeight, tocolor(0, 0, 0), 1, numberFont, "right", "center")
	dxDrawText(string.match(text, "%d+$" ), regionOffset, 0, regionOffset + regionWidth, regionHeight, tocolor(0, 0, 0), 0.65, numberFont, "center", "center")
	dxSetRenderTarget()
	
	local texture = getTextureFromRenderTarget(renderTarget)
	destroyElement(renderTarget)
	return texture
end

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


function getTextureFromRenderTarget(renderTarget)
	return dxCreateTexture(dxGetTexturePixels(renderTarget))
end

plateShaders = {}
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
		
	elseif getElementData (vehicle, "numberType" ) == "kz" then
		if not getElementData (vehicle, "number:plate" ) then return end
		texture = kzNumberPlate ( getElementData (vehicle, "number:plate"), vehicle)
		dxSetShaderValue(plateShaders[vehicle], "gTexture", texture)
		
	elseif getElementData (vehicle, "numberType" ) == "by" then
		if not getElementData (vehicle, "number:plate" ) then return end
		texture = byNumberPlate ( getElementData (vehicle, "number:plate"), vehicle)
		dxSetShaderValue(plateShaders[vehicle], "gTexture", texture)
	
	end
end

function destroyPlate ()
local veh = guiGridListGetItemData (list, guiGridListGetSelectedItem(list), 1)
local vehicle = getVehicleByID(veh)
if not plateShaders[vehicle] then
		plateShaders[vehicle] = dxCreateShader("files/texreplace.fx")
	end
engineRemoveShaderFromWorldTexture(plateShaders[vehicle], "nomer", vehicle)
setElementData(vehicle, "numberType", nil)
setElementData(vehicle, "number:plate", nil)
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
		writeCar ()
	end
end )