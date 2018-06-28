button = {}

		window = guiCreateWindow(0.25, 0.28, 0.52, 0.49, "Окно розысков", true)
        guiWindowSetMovable(window, false)
        guiWindowSetSizable(window, false)
		guiSetVisible (window, false)
		
        grid = guiCreateGridList(0.01, 0.05, 0.98, 0.85, true, window)
		guiGridListAddColumn(grid, "ID", 0.1)
        guiGridListAddColumn(grid, "Игроки", 0.3)
        guiGridListAddColumn(grid, "Уровень розыска", 0.3)
        guiGridListAddColumn(grid, "Причина", 0.3)
        guiGridListAddColumn(grid, "Расстояние", 0.3)
        button[1] = guiCreateButton(0.85, 0.91, 0.14, 0.07, "Отметить", true, window)
        guiSetProperty(button[1], "NormalTextColour", "FFAAAAAA")
		button[2] = guiCreateButton(0.65, 0.91, 0.14, 0.07, "Cнять", true, window)
        guiSetProperty(button[2], "NormalTextColour", "FFAAAAAA")
        button[3] = guiCreateButton(0.01, 0.91, 0.14, 0.07, "Закрыть", true, window)
        guiSetProperty(button[3], "NormalTextColour", "FFAAAAAA")    
		guiSetEnabled (button[1], false)
		guiSetEnabled (button[2], false)
		
function open ()
if getElementData (localPlayer, "frac") == "LSPD" then
guiSetVisible (window, not guiGetVisible (window))
showCursor (guiGetVisible (window))
triggerServerEvent ("checkWanted", localPlayer)
end
end
addCommandHandler ("wanted", open)

function write (table)
if not guiGetVisible (window) then return end
guiGridListClear (grid)
for i, v in ipairs (table) do
		local name = v["acc"]
		local level = v["level"]
		local pos1 = Vector3(getElementPosition (localPlayer))
		local row = guiGridListAddRow (grid)
		guiGridListSetItemText ( grid, row, 1, v["id"], false, false )
		guiGridListSetItemText ( grid, row, 2, name, false, false )
		guiGridListSetItemData ( grid, row, 2, getPlayerFromName(name), false, false )
		guiGridListSetItemText ( grid, row, 3, level, false, false )
		guiGridListSetItemText ( grid, row, 4, v["reason"], false, false )
		if getPlayerFromName(v["acc"]) then
			local pos2 = Vector3(getElementPosition (getPlayerFromName(v["acc"])))
			local dist = getDistanceBetweenPoints3D (pos1, pos2)
			guiGridListSetItemText ( grid, row, 5, dist.."м.", false, false )
		else
			guiGridListSetItemText ( grid, row, 5, " - ", false, false )
		end
end
end
addEvent ("write", true)
addEventHandler ("write", root, write)

addEventHandler ("onClientGUIClick", root, function()
if not guiGetVisible (window) then return end
local row = guiGridListGetSelectedItem(grid)
	if row >= 0 then
		guiSetEnabled (button[1], true)
		guiSetEnabled (button[2], true)
	else
		guiSetEnabled (button[1], false)
		guiSetEnabled (button[2], false)
	end
if source == button[1] then
	local target = guiGridListGetItemData (grid, guiGridListGetSelectedItem(grid), 2)
	--setElementData (target, "police:blip", createBlipAttachedTo (target, 41, _, _, _, _, _, _, 200000))
	triggerServerEvent ("wantedLevel", localPlayer, target, "add")
elseif source == button[2] then
	local target = guiGridListGetItemData (grid, guiGridListGetSelectedItem(grid), 2)
	triggerServerEvent ("wantedLevel", localPlayer, target, "remove")
	--[[if getElementData (target, "police:blip") then
		destroyElement(getElementData (target, "police:blip"))
	end]]--
elseif source == button[3] then
	guiSetVisible (window, false)
	showCursor (guiGetVisible (window))
end
end)

function removeHex(text, digits)
    assert(type(text) == "string", "Bad argument 1 @ removeHex [String expected, got " .. tostring(text) .. "]")
    --assert(digits == nil or (type(digits) == "numer" and digits > 0), "Bad argument 2 @ removeHex [numer greater than zero expected, got " .. tostring(digits) .. "]")
    return string.gsub(text, "#" .. (6 and string.rep("%x", 6) or "%x+"), "")
end