local sx, sy = guiGetScreenSize()
open = false

window = guiCreateWindow(300, 270.5, 249, 194, "Панель телепортации", false)
guiWindowSetSizable(window, false)
guiSetVisible (window, false)

box = guiCreateComboBox(9, 30, 230, 154, "Выберите место", false, window)
guiComboBoxAddItem(box, "Автошкола")
guiComboBoxAddItem(box, "Угон LV")
guiComboBoxAddItem(box, "Салон LV")
guiComboBoxAddItem(box, "Номера LV")
guiComboBoxAddItem(box, "База TCM")
guiComboBoxAddItem(box, "Угон LS")
guiComboBoxAddItem(box, "Номера SF")
guiComboBoxAddItem(box, "Салон SF")
guiComboBoxAddItem(box, "Номера LS")
tp = guiCreateButton(9, 63, 230, 43, "Телепортироваться", false, window)
guiSetProperty(tp, "NormalTextColour", "FFAAAAAA")
close = guiCreateButton(9, 116, 230, 43, "Закрыть", false, window)
guiSetProperty(close, "NormalTextColour", "FFAAAAAA")
label = guiCreateLabel(9, 165, 230, 19, "Anti Social Motion", false, window)
guiLabelSetHorizontalAlign(label, "center", false)

addCommandHandler ("teleportPanel", function()
if open == false then
open = true
guiSetVisible (window, true)
showCursor (true)
end
end)

 
ash = {-2024.15967, -97.07376, 34.98545} 
ugonLV = {1961.66248, 2171.81958, 10.68222}
salonLV = {1036.26270, 1767.23413, 10.62034} 
nomeraLV = {2225.92090, 2451.06689, 10.67827} 

ugonLS = {1042.32605, -1044.43799, 31.63122} 
tcm = {2486.76099, -1667.65161, 13.33351}   
nomeraSF = {-1629.96899, 655.93030, 7.01462}   
salonSF = {-1693.30676, 1306.20313, 6.85956}  
nomeraLS = {1582.95007, -1625.30725, 13.14035}
    

addEventHandler ("onClientGUIClick", root, function()
if source == tp then
	veh = getPedOccupiedVehicle (localPlayer)
	if guiComboBoxGetItemText (box, guiComboBoxGetSelected(box)) == "Угон LV" then
		fadeCamera (false, 1, 0, 0, 0)
		setTimer (function()
		if veh then
		setElementPosition (veh, unpack(ugonLV))
		else
		setElementPosition (localPlayer, unpack(ugonLV))	
		end
		fadeCamera (true, 1) 
		end, 2000, 1)
	elseif guiComboBoxGetItemText (box, guiComboBoxGetSelected(box)) == "Салон LV" then
		fadeCamera (false, 1, 0, 0, 0)
		setTimer (function()
		if veh then
		setElementPosition (veh, unpack(salonLV))
		else
		setElementPosition (localPlayer, unpack(salonLV))	
		end
		fadeCamera (true, 1) 
		end, 2000, 1)
	elseif guiComboBoxGetItemText (box, guiComboBoxGetSelected(box)) == "Номера LV" then
		fadeCamera (false, 1, 0, 0, 0)
		setTimer (function()
		if veh then
		setElementPosition (veh, unpack(nomeraLV))
		else
		setElementPosition (localPlayer, unpack(nomeraLV))	
		end
		fadeCamera (true, 1) 
		end, 2000, 1)
	elseif guiComboBoxGetItemText (box, guiComboBoxGetSelected(box)) == "База TCM" then
		fadeCamera (false, 1, 0, 0, 0)
		setTimer (function()
		if veh then
		setElementPosition (veh, unpack(tcm))
		else
		setElementPosition (localPlayer, unpack(tcm))	
		end
		fadeCamera (true, 1) 
		end, 2000, 1)
	elseif guiComboBoxGetItemText (box, guiComboBoxGetSelected(box)) == "Автошкола" then
		fadeCamera (false, 1, 0, 0, 0)
		setTimer (function()
		if veh then
		setElementPosition (veh, unpack(ash))
		else
		setElementPosition (localPlayer, unpack(ash))	
		end
		fadeCamera (true, 1) 
		end, 2000, 1)
	elseif guiComboBoxGetItemText (box, guiComboBoxGetSelected(box)) == "Угон LS" then
		fadeCamera (false, 1, 0, 0, 0)
		setTimer (function()
		if veh then
		setElementPosition (veh, unpack(ugonLS))
		else
		setElementPosition (localPlayer, unpack(ugonLS))	
		end
		fadeCamera (true, 1) 
		end, 2000, 1)
	elseif guiComboBoxGetItemText (box, guiComboBoxGetSelected(box)) == "Номера SF" then
		fadeCamera (false, 1, 0, 0, 0)
		setTimer (function()
		if veh then
		setElementPosition (veh, unpack(nomeraSF))
		else
		setElementPosition (localPlayer, unpack(nomeraSF))	
		end
		fadeCamera (true, 1) 
		end, 2000, 1)
	elseif guiComboBoxGetItemText (box, guiComboBoxGetSelected(box)) == "Салон SF" then
		fadeCamera (false, 1, 0, 0, 0)
		setTimer (function()
		if veh then
		setElementPosition (veh, unpack(salonSF))
		else
		setElementPosition (localPlayer, unpack(salonSF))	
		end
		fadeCamera (true, 1) 
		end, 2000, 1)
	elseif guiComboBoxGetItemText (box, guiComboBoxGetSelected(box)) == "Номера LS" then
		fadeCamera (false, 1, 0, 0, 0)
		setTimer (function()
		if veh then
		setElementPosition (veh, unpack(nomeraLS))
		else
		setElementPosition (localPlayer, unpack(nomeraLS))	
		end
		fadeCamera (true, 1) 
		end, 2000, 1)
	end
elseif source == close then
	open = false
	guiSetVisible (window, false)
	showCursor (false)
end
end)

function getOriginalProcentOfText (x, y, sx, sy)
    local x, sx = (x / 14.4) * scx, (sx / 14.4) * scx
	local y, sy = (y / 9) * scy, (sy / 9) * scy
	return x, y, sx, sy
end    