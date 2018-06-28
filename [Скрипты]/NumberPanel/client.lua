local screenW, screenH = guiGetScreenSize()
open = false
window = guiCreateWindow((screenW - 249) / 2, (screenH - 194) / 2, 249, 292, "Выборочный номер", false)
guiWindowSetSizable(window, false)
guiSetVisible (window, false)

box = guiCreateComboBox(9, 30, 230, 154, "Игроки", false, window)
edit = guiCreateEdit(9, 92, 180, 19, "", false, window)
edit2 = guiCreateEdit(190, 92, 50, 19, "", false, window)
tp = guiCreateButton(9, 131, 230, 43, "Поставить", false, window)
guiSetProperty(tp, "NormalTextColour", "FFAAAAAA")
close = guiCreateButton(9, 181, 230, 43, "Закрыть", false, window)
guiSetProperty(close, "NormalTextColour", "FFAAAAAA")
label = guiCreateLabel(9, 234, 230, 19, "TCW", false, window)
guiLabelSetHorizontalAlign(label, "center", false)

numberTypeBox = guiCreateComboBox(9, 60, 230, 91, "Русские", false, window)
guiComboBoxAddItem(numberTypeBox, "Русские")
guiComboBoxAddItem(numberTypeBox, "Украинские")
guiComboBoxAddItem(numberTypeBox, "Казахстанские")
guiComboBoxAddItem(numberTypeBox, "Белорусские")
guiComboBoxAddItem(numberTypeBox, "Именные")     

function openNumber ()
    if not open then
        guiComboBoxClear (box)
        open = true
        guiSetInputMode("no_binds_when_editing")
        guiSetVisible (window, true)
        showCursor (true)
        addItem ()
    end
end
addEvent("openNumber", true)
addEventHandler("openNumber", getRootElement(), openNumber)

function addItem ()
local data = getElementsByType ("player")
for i, players in ipairs (data) do
	guiComboBoxAddItem(box, getPlayerName(players))--utf8.gsub(getPlayerName(players), "#%x%x%x%x%x%x", ""))
end
end

addEventHandler ("onClientGUIClick", root, function()
if guiGetVisible (window) then
if source == tp then
	local target = guiComboBoxGetItemText (box, guiComboBoxGetSelected(box))
	local text = guiGetText (edit)
	local text2 = guiGetText (edit2)
	local textBox = guiComboBoxGetItemText(numberTypeBox, guiComboBoxGetSelected(numberTypeBox))
	local country = getCountry (textBox)
	if country ~= "c" then
		if text and text2 and target ~= "Игроки" then
			local veh = getPedOccupiedVehicle (getPlayerFromName(target))
			triggerServerEvent ("numberPlate", localPlayer, veh, country, text..text2)
		end
	else
		if text and target ~= "Игроки" then
			local veh = getPedOccupiedVehicle (getPlayerFromName(target))
			triggerServerEvent ("numberPlate", localPlayer, veh, country, text)
		end
	end
	exports.and_salon:refreshCarClient ()
elseif source == close then
	open = false
	guiSetInputMode("allow_binds")
	guiSetVisible (window, false)
	showCursor (false)
end
end
end)

function getCountry (textBox)
country = {}
if textBox == "Русские" then
	local country = "ru"
	return country
elseif textBox == "Казахстанские" then
	local country = "kz"
	return country
elseif textBox == "Украинские" then
	local country = "ua"
	return country
elseif textBox == "Белорусские" then
	local country = "by"
elseif textBox == "Именные" then
	local country = "c"
	return country
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