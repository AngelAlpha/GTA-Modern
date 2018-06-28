local screenW, screenH = guiGetScreenSize()
open = false
window = guiCreateWindow((screenW - 249) / 2, (screenH - 194) / 2, 249, 224, "Панель заправки", false)
guiWindowSetSizable(window, false)
guiSetVisible (window, false)

box = guiCreateComboBox(9, 30, 230, 154, "Игроки", false, window)
edit = guiCreateEdit (9, 63, 230, 19, "", false, window)
tp = guiCreateButton(9, 113, 230, 43, "Заправить", false, window)
guiSetProperty(tp, "NormalTextColour", "FFAAAAAA")
close = guiCreateButton(9, 166, 230, 43, "Закрыть", false, window)
guiSetProperty(close, "NormalTextColour", "FFAAAAAA")
label = guiCreateLabel(9, 90, 230, 19, "Бензин: N/A", false, window)
guiLabelSetHorizontalAlign(label, "center", false)

addCommandHandler ("benzinPanel", function()
if open == false then
open = true
guiComboBoxClear (box)
guiSetVisible (window, true)
showCursor (true)
addItem ()
end
end)

function addItem ()
local data = getElementsByType ("player")
for i, players in ipairs (data) do
	guiComboBoxAddItem(box, getPlayerName(players))--utf8.gsub(getPlayerName(players), "#%x%x%x%x%x%x", ""))
end
end

addEventHandler ("onClientGUIClick", root, function()
if source == tp then
	local target = guiComboBoxGetItemText (box, guiComboBoxGetSelected(box))
	local text = tonumber(guiGetText (edit))
	local veh = getPedOccupiedVehicle (getPlayerFromName(target))
	setElementData (veh, "fuel", text)
elseif source == close then
	open = false
	guiSetVisible (window, false)
	showCursor (false)
elseif source == box then
	if guiComboBoxGetItemText (box, guiComboBoxGetSelected(box)) ~= "Игроки" then
		local veh = getPedOccupiedVehicle (getPlayerFromName(guiComboBoxGetItemText (box, guiComboBoxGetSelected(box))))
		if veh then
		guiSetText (label, "Бензин: "..math.floor(getElementData (veh, "fuel")))
		end
	end
end
end)

addEventHandler ("onClientElementDataChange", root, function(data)
if open ~= false then
if data == "fuel" then
	if guiComboBoxGetItemText (box, guiComboBoxGetSelected(box)) ~= "Игроки" then
	local veh = getPedOccupiedVehicle (getPlayerFromName(guiComboBoxGetItemText (box, guiComboBoxGetSelected(box))))
	if veh then
	guiSetText (label, "Бензин: "..math.floor(getElementData (veh, "fuel")))
	end
	end
end
end
end)