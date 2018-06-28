marker = createMarker (-1615.9910888672,686.37036132813,6.1875, "cylinder", 1.5, 0, 0, 255, 150)
marker2 = createMarker (1580.4874267578,-1634.5069580078,12.561723709106, "cylinder", 1.5, 0, 0, 255, 150)
marker3 = createMarker (2251.1071777344,2490.2644042969,9.990804672241, "cylinder", 1.5, 0, 0, 255, 150)
createBlipAttachedTo (marker, 7, 2, 255, 255, 255, 255, 0, 200)
createBlipAttachedTo (marker2, 7, 2, 255, 255, 255, 255, 0, 200)
createBlipAttachedTo (marker3, 7, 2, 255, 255, 255, 255, 0, 200)


addEventHandler ("onClientMarkerHit", root, function (emelent)
if isElementWithinMarker(localPlayer, marker) or isElementWithinMarker(localPlayer, marker2) or isElementWithinMarker(localPlayer, marker3) then
if guiGetVisible (window) ~= true then
guiSetVisible (window, true)
showCursor (true)
triggerServerEvent ("write", localPlayer, localPlayer)
writeCar (emelent)
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
        guiGridListAddColumn(list, "id", 0.15)
        guiGridListAddColumn(list, "Машина", 0.4)
		guiGridListAddColumn(list, "Тип", 0.1)
        guiGridListAddColumn(list, "Номер", 0.4)
        edit = guiCreateEdit(188, 26, 138, 29, "Регион", false, window)
        give = guiCreateButton(335, 57, 147, 46, "Получить номера", false, window)
        guiSetProperty(give, "NormalTextColour", "FFAAAAAA")
        destroy = guiCreateButton(335, 113, 147, 46, "Снять номера", false, window)
        guiSetProperty(destroy, "NormalTextColour", "FFAAAAAA")
        close = guiCreateButton(335, 165, 147, 26, "Закрыть", false, window)
        guiSetProperty(close, "NormalTextColour", "FFAAAAAA")
        label = guiCreateLabel(344, 26, 128, 29, "The Criminal World", false, window)
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

--[[smb = {
	['A'] ='а',
	['B'] = 'в',
	['C'] = 'с',
	['Y'] = 'у',
	['O'] = 'о',
	['P'] = 'р',
	['T'] = 'т',
	['E'] = 'е',
	['X'] = 'х',
	['M'] = 'м',
	['H'] = 'н',
	['K'] = 'к'
}]]--

customCarNames = -- новые названия
{
[411] = "Lamborghini Huracan";
[421] = "Lexus LX570",
[415] = "Koenigsegg Agera R",
[507] = "Porsche Panamera";
[541] = "Audi R8 2017";
[585] = "BMW 750";
[466] = "BMW E34";
[604] = "Mitsubishi Lancer Evo VIII";
[492] = "BMW E60";
[551] = "BMW F10";
[410] = "BMW I8";
[555] = "BMW M3 E92";
[542] = "BMW M5 F90";
[562] = "BMW M2";
[502] = "Mersedes Benz AMG GT";
[445] = "Mersedes Benz E200";
[580] = "Rolls-Royce Phantom 2018";
[506] = "Porsche 911 Turbo S";
[558] = "Porsche 918";
[402] = "Comaro ZL1";
[503] = "corvette c7";
[561] = "Ford Focus";
[451] = "Lamborghini Huracan";
[547] = "Audi RS6";
[429] = "McLarean P1";
[458] = "Mersedes Benz CLS63";
[516] = "Mersedes Benz E420";
[579] = "Mersedes Benz G65";
[418] = "Mersedes Benz S63 AMG";
[546] = "Mercedes Maybach S400";
[543] = "Nissan Silvia";
[489] = "Land Rover SVA";
[566] = "Lincoln Continental 2017";
[589] = "Porsche 911";
[567] = "peugeot 406";
[494] = "Rolls Royce Wraith";
[490] = "Rolls Royce Phantom";
[400] = "Lamborghini Urus";
[560] = "Subaru Impreza";
[527] = "Lamborghini Aventador";
[401] = "Nissan GTR";
[404] = "Toyota Land Cruiser";
[559] = "Maserati Alfieri";
[505] = "Volkswagen Touareg";
[405] = "ВАЗ 2106";
[438] = "ВАЗ 2107";
[479] = "ВАЗ 2114";
[491] = "ВАЗ 2112";
[540] = "ВАЗ 2170";
[419] = "ВАЗ 2109";
[474] = "Audi S5";
}






function writeCar (pl)
if open ~= 0 then
if pl then
	local data = getElementData(pl, "vehicles")
	if data then
		local rw, cl = guiGridListGetSelectedItem(list)
		guiGridListClear(list)
		for i, data in ipairs (data) do
			local carName = customCarNames[ tonumber(data['Model']) ] or getVehicleNameFromModel(data["Model"])
			local ID = data["ID"]
			local row = guiGridListAddRow(list)
			guiGridListSetItemText(list, row, 1, ID, false, true)
			guiGridListSetItemData(list, row, 1, ID)
			guiGridListSetItemText(list, row, 2, carName, false, true)
			if data['Number'] then
				local numbers = fromJSON(data['Number'])
				local reg1
				local numb1
				if numbers[1] == "ru" then
					reg1 = utf8.match(numbers[2], "^%a" )
					reg1 = reg1..utf8.match(numbers[2], "%d%d%d" )
					reg1 = reg1..utf8.match(numbers[2], "%a%a" )
					reg1 = reg1.."|"..utf8.match(numbers[2], "%d+$" )
					numb1 = "RU"
				elseif numbers[1] == "by" then
					reg1 = utf8.match(numbers[2], "%d%d%d%d" )
					reg1 = reg1..utf8.match(numbers[2], "%a%a" )
					reg1 = reg1.."-"..utf8.match(numbers[2], "%d" )
					numb1 = "BY"
				elseif numbers[1] == "ua" then
					reg1 = utf8.match(numbers[2], "^%a%a" )
					reg1 = reg1..utf8.gsub(numbers[2], "%a", "")
					reg1 = reg1.."|"..utf8.match(numbers[2], "%a%a$" )
					numb1 = "UA"
				elseif numbers[1] == "kz" then
					reg1 = utf8.gsub(numbers[2], "(%a%a+)(%d%d)$", "" )
					reg1 = reg1..utf8.gsub(numbers[2], "%d", "" )
					reg1 = reg1.."|"..utf8.gsub(numbers[2], "^(%d%d%d)(%a%a+)", "" )
					numb1 = "KZ"
				elseif numbers[1] == "c" then
					reg1 = numbers[2]
					numb1 = "-"
				end
				guiGridListSetItemText(list, row, 4, reg1, false, true)
				guiGridListSetItemText(list, row, 3, numb1, false, true)
			else
				guiGridListSetItemText(list, row, 4, " - ", false, true)
			end
		end
		guiGridListSetSelectedItem(list, rw, cl)
	end
end
end
end

regru = { 
'01',
'02', 
'03', 
'04', 
'05',  
'06', 
'07', 
'09',  
'10',  
'11',  
'12',  
'13',  
'14',  
'15',  
'16',  
'17',  
'18',  
'19',  
'20',  
'21',  
'22',  
'23',  
'24',  
'25',  
'26',  
'27',  
'28',  
'29',  
'30',  
'31',  
'32',  
'33',  
'34',  
'35',  
'36',  
'37',  
'38',  
'39',  
'40',  
'41',  
'42',  
'43',  
'44',  
'45',  
'46',  
'47',  
'48',  
'49',  
'50',  
'51',  
'52',  
'53',  
'54',  
'55',  
'56',  
'57',  
'58',  
'59',  
'60',  
'61',  
'62',  
'63',  
'64',  
'65',  
'66',  
'67',  
'68',  
'69',  
'70',  
'71',  
'72',  
'73',  
'74',  
'75',  
'76',  
'77',  
'78',  
'79',   
'80',   
'81',   
'82',   
'83',   
'84',   
'85',   
'86',   
'87',   
'88',   
'89',   
'90',     
'93',     
'95',   
'96',   
'97',   
'98',   
'99',   
'777',   
'178',   
'126',   
'123',   
'116',   
'161',
'150',
'176', 
'197',
'177',
'186',
'716',
'50',
'134',
'799',
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
	if vehicle then
		if guiComboBoxGetItemText (box, guiComboBoxGetSelected(box)) == 'Выберите страну' or guiGetText (edit) == 'Регион' then
			outputChatBox("Проверьте правильность ввода данных", 255, 0, 0)
		else
			if guiComboBoxGetItemText (box, guiComboBoxGetSelected(box)) == "Российские" then
				if getElementData(vehicle, "numberType") ~= "ru"  then
					for _, regionsru in ipairs (regru) do
						if guiGetText (edit) == regionsru then
							country = "ru"
							createRandomNumber ("ru", guiGetText (edit))
							return
						end
					end
					outputChatBox("Такого региона нету!", 255, 0, 0)
				end
			elseif guiComboBoxGetItemText (box, guiComboBoxGetSelected(box)) == "Белорусские" then
				if getElementData(vehicle, "numberType") ~= "by"  then
					for _, regionsby in ipairs (regby) do
						if guiGetText (edit) == regionsby then
							country = "by"
							createRandomNumber ("by", guiGetText (edit))
							return
						end
					end
					outputChatBox("Такого региона нету!", 255, 0, 0)
				end
			elseif guiComboBoxGetItemText (box, guiComboBoxGetSelected(box)) == "Украинские" then
				if getElementData(vehicle, "numberType") ~= "ua"  then
					for _, regionsua in ipairs (regua) do
						if guiGetText (edit) == regionsua then
							country = "ua"
							createRandomNumber ("ua", guiGetText (edit))
							return
						end
					end
					outputChatBox("Такого региона нету!", 255, 0, 0)
				end
			elseif guiComboBoxGetItemText (box, guiComboBoxGetSelected(box)) == "Казахстанские" then
				if getElementData(vehicle, "numberType") ~= "kz"  then
					for _, regionskz in ipairs (regkz) do
						if guiGetText (edit) == regionskz then
							country = "kz"
							createRandomNumber ("kz", guiGetText (edit))
							return
						end
					end
					outputChatBox("Такого региона нету!", 255, 0, 0)
				end
			end
		end
	else
	outputChatBox("Машина не найдена!", 255, 0, 0)
	end
elseif (source == destroy) then
	if vehicle then
		if getElementData(vehicle, "numberType") then
		if getPlayerMoney() >= 100 then
		setElementData(vehicle, "numberType", nil)
		setElementData(vehicle, "number:plate", nil)
		reg = nil
		destroyPlate (vehicle)
		triggerServerEvent ("takeN", localPlayer, localPlayer, 100)
		end
		end
	else
	outputChatBox("Машина не найдена!", 255, 0, 0)
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
	if region == true then		
		local veh = guiGridListGetItemData (list, guiGridListGetSelectedItem(list), 1)
		local car = guiGridListGetItemText (list, guiGridListGetSelectedItem(list), 2)
		local vehicle = getVehicleByID(veh)
		setElementData(vehicle, "numberType", country)
		setElementData(vehicle, "number:plate", num..regionEdit)
		triggerServerEvent("buyNumberPlate", localPlayer, veh, false)
		local reg1
		if country == "ru" then
			guiGridListSetItemText(list, guiGridListGetSelectedItem (list), 4, num.."|"..regionEdit, false, true)
		elseif country == "by" then
			guiGridListSetItemText(list, guiGridListGetSelectedItem (list), 4, num..regionEdit, false, true)
		elseif country == "ua" then
			guiGridListSetItemText(list, guiGridListGetSelectedItem (list), 4, num.."|"..regionEdit, false, true)
		elseif country == "kz" then
			guiGridListSetItemText(list, guiGridListGetSelectedItem (list), 4, num.."|"..regionEdit, false, true)
		end
		guiGridListSetItemText(list, guiGridListGetSelectedItem (list), 3, country, false, true)
		triggerServerEvent("refreshCarNumb", localPlayer, localPlayer)
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
if text then
	renderTarget = dxCreateRenderTarget(256, 64)
	dxSetRenderTarget(renderTarget)
	dxDrawImage(0, 0, 256, 64, dxCreateTexture("number/number_ru.png") )
	if text then
	dxDrawText(utf8.match(text, "^%a" ), textOffset-10, 0, textOffset + textWidth, numberHeight, tocolor(0, 0, 0), 1, numberFont, "left", "center")
	dxDrawText(utf8.match(text, "%d%d%d" ), textOffset-30, 0, textOffset + textWidth, numberHeight, tocolor(0, 0, 0), 1, numberFont, "center", "center")
	dxDrawText(utf8.match(text, "%a%a" ), textOffset, 0, textOffset + textWidth + 10, numberHeight, tocolor(0, 0, 0), 1, numberFont, "right", "center")
	dxDrawText(utf8.match(text, "%d+$" ), regionOffset, 0, regionOffset + regionWidth, regionHeight, tocolor(0, 0, 0), 0.65, numberFont, "center", "center")
	end
	dxSetRenderTarget()
	
	local texture = getTextureFromRenderTarget(renderTarget)
	destroyElement(renderTarget)
	return texture
end
end

local ua_textOffset = 60
local ua_textWidth = 164
local ua_numberHeight = 64

function ukraineNumberPlate ( text, vehicle)
if text then
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
end

-- казахстанские номера
local kz_textOffset = 40
local kz_textWidth = 256
local kz_numberHeight = 64

function kzNumberPlate ( text, vehicle )
if text then
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
end

-- белорусские номера
local by_textOffset = 40
local by_textWidth = 256
local by_numberHeight = 64

function byNumberPlate ( text, vehicle )
if text then
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
end


-- именные номера
local c_textOffset = 40
local c_textWidth = 256
local c_numberHeight = 64

function cNumberPlate ( text, vehicle )
if text then
	renderTarget = dxCreateRenderTarget(256, 64)
	dxSetRenderTarget(renderTarget)
	dxDrawImage(0, 0, 256, 64, dxCreateTexture("number/number_c.png") )
	dxDrawText(text, c_textOffset/utf8.len(text)+utf8.len(text), 0, c_textOffset/utf8.len(text), c_numberHeight, tocolor(0, 0, 0), 3.5, 4.5, "default-bold", "left", "center")		
	dxSetRenderTarget()
	
	local texture = getTextureFromRenderTarget(renderTarget)
	destroyElement(renderTarget)
	return texture
end
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
	elseif getElementData (vehicle, "numberType" ) == "c" then
		if not getElementData (vehicle, "number:plate" ) then return end
		texture = cNumberPlate ( getElementData (vehicle, "number:plate"), vehicle)
		dxSetShaderValue(plateShaders[vehicle], "gTexture", texture)
	elseif getElementData (vehicle, "numberType" ) == nil then
		destroyPlate (vehicle)
	end
end

function destroyPlate (vehicle)
if not plateShaders[vehicle] then
	plateShaders[vehicle] = dxCreateShader("files/texreplace.fx")
end
engineRemoveShaderFromWorldTexture(plateShaders[vehicle], "nomer", vehicle)
setElementData(vehicle, "numberType", nil)
setElementData(vehicle, "number:plate", nil)
local car = guiGridListGetItemData(list, guiGridListGetSelectedItem(list), 1)
triggerServerEvent("buyNumberPlate", localPlayer, car, true)
guiGridListSetItemText(list, guiGridListGetSelectedItem (list), 3, "", false, true)
guiGridListSetItemText(list, guiGridListGetSelectedItem (list), 4, " - ", false, true)
end



addEventHandler( "onClientElementStreamIn", getRootElement(), function()
	if getElementType( source ) == "vehicle" then
	if not getElementData (source, "numberType" ) then return end
	setVehicleNumberPlate ( source )
	end
end)

addEventHandler ( "onClientElementDataChange", getRootElement(),
function ( dataName )
	if getElementType ( source ) == "vehicle" and dataName == "number:plate" or dataName == "numberType" then
		setVehicleNumberPlate ( source )
	end
end )

