local screenW, screenH = guiGetScreenSize()
local show = 0

window = guiCreateWindow((screenW - 355) / 2, (screenH - 307) / 2, 355, 307, "Панель админа", false)
guiWindowSetSizable(window, false)
tab = guiCreateTabPanel(10, 20, 335, 277, false, window)
guiSetVisible (window, false) 

tab_1 = guiCreateTab("Основное", tab)

Fuel = guiCreateRadioButton(10, 10, 88, 28, "Бензин", false, tab_1)
Drive = guiCreateRadioButton(10, 48, 88, 28, "Здоровье", false, tab_1)
Money = guiCreateRadioButton(10, 86, 88, 28, "Деньги", false, tab_1)
grid_1 = guiCreateGridList(152, 10, 173, 191, false, tab_1)
guiGridListAddColumn(grid_1, "Игроки", 0.9)
edit_1 = guiCreateEdit(10, 211, 151, 31, "", false, tab_1)
button_1 = guiCreateButton(171, 211, 154, 31, "Установить", false, tab_1)
guiSetProperty(button_1, "NormalTextColour", "FFAAAAAA")
label = guiCreateLabel(10, 173, 142, 28, "", false, tab_1)
guiLabelSetVerticalAlign(label, "center") 

tab_2 = guiCreateTab("Номера", tab)

grid_2 = guiCreateGridList(9, 7, 316, 195, false, tab_2)
guiGridListAddColumn(grid_2, "Игроки", 0.5)
guiGridListAddColumn(grid_2, "Номера", 0.5)
edit_2 = guiCreateEdit(9, 212, 132, 31, "", false, tab_2)
edit_3 = guiCreateEdit(141, 212, 51, 31, "", false, tab_2)
button_2 = guiCreateButton(202, 212, 123, 31, "Установить", false, tab_2)
guiSetProperty(button_2, "NormalTextColour", "FFAAAAAA")

function show ()
if getElementData (localPlayer, "teg") then
	if show ~= 1 then
		guiSetVisible (window, true)
		showCursor (true)
		show = 1
		guiGridListAddPlayers (grid_1)
		guiGridListAddPlayersInCar (grid_2)
		guiSetInputMode ("no_binds_when_editing")
	else
		guiSetVisible (window, false)
		showCursor (false)
		show = 0
		guiSetInputMode ("allow_binds")
	end
end
end
--bindKey ("F7", "down", show)
addCommandHandler ("panelAdmin", show)


addEventHandler ("onClientGUIClick", root, function()
if show ~= 0 then
	if source == tab_1 then
		guiGridListAddPlayers (grid_1)
	elseif source == tab_2 then
		guiGridListAddPlayersInCar (grid_2)
	elseif source == Fuel and guiGridListGetSelectedItem (grid_1) ~= -1 then
		local selected = guiGridListGetItemData ( grid_1, guiGridListGetSelectedItem ( grid_1 ), 1) 
		local veh = getPedOccupiedVehicle (getPlayerFromName(selected))
		guiSetText (label, "Бензин: "..math.floor(tonumber(getElementData(veh, "fuel"))))
	elseif source == Drive and guiGridListGetSelectedItem (grid_1) ~= -1 then
		local selected = guiGridListGetItemData ( grid_1, guiGridListGetSelectedItem ( grid_1 ), 1) 
		local veh = getPedOccupiedVehicle (getPlayerFromName(selected))
		guiSetText (label, "Здоровье: "..math.floor(tonumber(getElementHealth(getPlayerFromName(selected)))))
	elseif source == Money and guiGridListGetSelectedItem (grid_1) ~= -1 then
		local selected = getPlayerFromName(guiGridListGetItemData ( grid_1, guiGridListGetSelectedItem ( grid_1 ), 1))
		print ("1")
		triggerServerEvent ("getMoney", localPlayer, selected)
	elseif source == button_1 then
		if edit_1 ~= "" and guiGridListGetSelectedItem (grid_1) ~= -1 and guiRadioButtonGetSelected(Fuel) or guiRadioButtonGetSelected(Drive) or guiRadioButtonGetSelected(Money) then
			local text_1 = guiGetText (edit_1)
			local selected = guiGridListGetItemData ( grid_1, guiGridListGetSelectedItem ( grid_1 ), 1) 
			local veh = getPedOccupiedVehicle (getPlayerFromName(selected))
			if guiRadioButtonGetSelected (Fuel) then
				if veh then
					setElementData (veh, "fuel", tonumber(text_1))
				end
			elseif guiRadioButtonGetSelected (Drive) then
				setElementHealth (getPlayerFromName(selected), math.floor(tonumber(text_1)))
				guiSetText (label, "Здоровье: "..tonumber(text_1))
			elseif guiRadioButtonGetSelected (Money) then
				triggerServerEvent ("giveMoney", localPlayer, selected, text_1)
			end
		end
	elseif source == button_2 then
		if edit_2 ~= "" or edit_3 ~= "" and guiGridListGetSelectedItem (grid_1) ~= -1 then
			local text_2, text_3 = guiGetText(edit_2), guiGetText (edit_3)
			local selected = guiGridListGetItemData ( grid_2, guiGridListGetSelectedItem ( grid_2 ), 1 )
			local veh = getPedOccupiedVehicle (getPlayerFromName(selected))
			if veh then
				setElementData(veh, "numberType", "ru")
				setElementData(veh, "number:plate", text_2..text_3)
				guiGridListSetItemText (grid_2, guiGridListGetSelectedItem ( grid_2 ), 2, text_2..text_3, false, false)
			end
		end
	end
end
end)

function guiGridListAddPlayers(gridlist)
if gridlist then
	guiGridListClear(gridlist)
	for i, pl in ipairs (getElementsByType ("player")) do
	local row = guiGridListAddRow (gridlist)
	guiGridListSetItemText (gridlist, row, 1, utf8.gsub(getPlayerName (pl), "#%x%x%x%x%x%x", ""), false, false)
	guiGridListSetItemData (gridlist, row, 1, getPlayerName (pl), false, false)
	end
end
end

function guiGridListAddPlayersInCar(gridlist)
if gridlist then
	guiGridListClear(gridlist)
	for i, pl in ipairs (getElementsByType ("player")) do
	local veh = getPedOccupiedVehicle(pl)
	if veh then
		local driver = getVehicleOccupant (veh)
		local row = guiGridListAddRow (gridlist)
		guiGridListSetItemText (gridlist, row, 1, utf8.gsub(getPlayerName (driver), "#%x%x%x%x%x%x", ""), false, false)
		guiGridListSetItemData (gridlist, row, 1, getPlayerName (driver), false, false)
		if getElementData (getPedOccupiedVehicle(driver), "number:plate") then
			guiGridListSetItemText (gridlist, row, 2, tostring(getElementData (getPedOccupiedVehicle(driver), "number:plate")), false, false)
		else
			guiGridListSetItemText (gridlist, row, 2, "-", false, false)
		end
	end
	end
end
end

addEventHandler("onClientElementDataChange", root,
function(dd)
	if getElementType(source) == "vehicle" and dd == "number:plate" then
		local data = getElementData(source, dd)
		if data then
			guiGridListAddPlayers()
			guiGridListAddPlayersInCar ()
		end
	end
end)

addEvent ("setTextMoney", true)
addEventHandler ("setTextMoney", root, function (money)
if money then
guiSetText (label, "Деньги: "..money)
end
end)