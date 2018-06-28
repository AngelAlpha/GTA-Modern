local GUIEditor_Window = {}
local GUIEditor_Button = {}
local GUIEditor_Label = {}

local x,y = guiGetScreenSize() 
GUIEditor_Window[1] = guiCreateWindow((x-410)/2, (y-450)/2, 410, 550, "Выберите ключ от автомобиля", false )
guiWindowSetSizable(GUIEditor_Window[1],false)
guiSetVisible(GUIEditor_Window[1],false)
GUIEditor_Button[1] = guiCreateButton(5,500,400,40,"Закрыть",false,GUIEditor_Window[1])
GUIEditor_Button[2] = guiCreateButton(5,25,400,30, "Ключи от Barracks[LVA001] (3 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[3] = guiCreateButton(5,58,400,30, "Ключи от Barracks[LVA002] (3 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[4] = guiCreateButton(5,91,400,30, "Ключи от Barracks[LVA003] (3 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[5] = guiCreateButton(5,124,400,30, "Ключи от Barracks[LVA004] (3 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[6] = guiCreateButton(5,157,400,30, "Ключи от Barracks[LVA005] (3 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[7] = guiCreateButton(5,190,400,30, "Ключи от Barracks[LVA006] (3 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[8] = guiCreateButton(5,223,400,30, "Ключи от Patriot[LVA007] (4 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[9] = guiCreateButton(5,256,400,30, "Ключи от Patriot[LVA008] (4 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[10] = guiCreateButton(5,289,400,30, "Ключи от Patriot[LVA009] (4 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[11] = guiCreateButton(5,322,400,30, "Ключи от Patriot[LVA0010] (4 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[12] = guiCreateButton(5,355,400,30, "Ключи от Mesa[LVA0011] (9 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[13] = guiCreateButton(5,388,400,30, "Ключи от Mesa[LVA0012] (9 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[14] = guiCreateButton(5,421,400,30, "Ключи от Maverick[LVA0013] (10 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[15] = guiCreateButton(5,454,400,30, "Ключи от Maverick[LVA0014] (10 ранг)",false,GUIEditor_Window[1])
	
function showAmmoGUI( hitPlayer, type, num )
	guiSetVisible ( GUIEditor_Window[1], true )
	showCursor( true )
	for i = 2, 7 do
		guiSetText (GUIEditor_Button[i], "Ключи от Barracks ["..positionVeh[i-1][8].."|77] (3 ранг)")
	end
	for i = 8, 11 do
		guiSetText (GUIEditor_Button[i], "Ключи от Patriot ["..positionVeh[i-1][8].."|77] (6 ранг)")
	end
	for i = 12, 13 do
		guiSetText (GUIEditor_Button[i], "Ключи от Mesa ["..positionVeh[i-1][8].."|77] (9 ранг)")
	end
	for i = 14, 15 do
		guiSetText (GUIEditor_Button[i], "Ключи от Maverick (9 ранг)")
	end
end
addEvent("showAmmoLVAKluch",true)
addEventHandler("showAmmoLVAKluch",getRootElement(),showAmmoGUI)

function UbratyAutoLVA001( hitPlayer, type, num )
triggerServerEvent( "DestroyvehicleLVA003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLVA001",true)
addEventHandler("UbratyAutoLVA001",getRootElement(),UbratyAutoLVA001)

function UbratyAutoLVA002( hitPlayer, type, num )
triggerServerEvent( "DestroyvehicleLVA003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLVA002",true)
addEventHandler("UbratyAutoLVA002",getRootElement(),UbratyAutoLVA002)

function UbratyAutoLVA003( hitPlayer, type, num )
triggerServerEvent( "DestroyvehicleLVA003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLVA003",true)
addEventHandler("UbratyAutoLVA003",getRootElement(),UbratyAutoLVA003)

function UbratyAutoLVA004( hitPlayer, type, num )
triggerServerEvent( "DestroyvehicleLVA003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLVA004",true)
addEventHandler("UbratyAutoLVA004",getRootElement(),UbratyAutoLVA004)

function UbratyAutoLVA005( hitPlayer, type, num )
triggerServerEvent( "DestroyvehicleLVA003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLVA005",true)
addEventHandler("UbratyAutoLVA005",getRootElement(),UbratyAutoLVA005)

function UbratyAutoLVA006( hitPlayer, type, num )
triggerServerEvent( "DestroyvehicleLVA003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLVA006",true)
addEventHandler("UbratyAutoLVA006",getRootElement(),UbratyAutoLVA006)

function UbratyAutoLVA007( hitPlayer, type, num )
triggerServerEvent( "DestroyvehicleLVA003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLVA007",true)
addEventHandler("UbratyAutoLVA007",getRootElement(),UbratyAutoLVA007)

function UbratyAutoLVA008( hitPlayer, type, num )
triggerServerEvent( "DestroyvehicleLVA003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLVA008",true)
addEventHandler("UbratyAutoLVA008",getRootElement(),UbratyAutoLVA008)

function UbratyAutoLVA009( hitPlayer, type, num )
triggerServerEvent( "DestroyvehicleLVA003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLVA009",true)
addEventHandler("UbratyAutoLVA009",getRootElement(),UbratyAutoLVA009)

function UbratyAutoLVA0010( hitPlayer, type, num )
triggerServerEvent( "DestroyvehicleLVA003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLVA0010",true)
addEventHandler("UbratyAutoLVA0010",getRootElement(),UbratyAutoLVA0010)

function UbratyAutoLVA0011( hitPlayer, type, num )
triggerServerEvent( "DestroyvehicleLVA003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLVA0011",true)
addEventHandler("UbratyAutoLVA0011",getRootElement(),UbratyAutoLVA0011)

function UbratyAutoLVA0012( hitPlayer, type, num )
triggerServerEvent( "DestroyvehicleLVA003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLVA0012",true)
addEventHandler("UbratyAutoLVA0012",getRootElement(),UbratyAutoLVA0012)

function UbratyAutoLVA0013( hitPlayer, type, num )
triggerServerEvent( "DestroyvehicleLVA003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLVA0013",true)
addEventHandler("UbratyAutoLVA0013",getRootElement(),UbratyAutoLVA0013)

function UbratyAutoLVA0014( hitPlayer, type, num )
triggerServerEvent( "DestroyvehicleLVA003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLVA0014",true)
addEventHandler("UbratyAutoLVA0014",getRootElement(),UbratyAutoLVA0014)

addEventHandler("onClientGUIClick",getRootElement(),
function ( player )
	local player2 = getLocalPlayer()
	local money = getPlayerMoney ( player2 )
   	if (source == GUIEditor_Button[1]) then
   		guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
   	elseif (source == GUIEditor_Button[2]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLVA001", getLocalPlayer(), 0, 24, 35 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  		end
  	elseif (source == GUIEditor_Button[3]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLVA002", getLocalPlayer(), 0, 31, 100 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  		end
  	elseif (source == GUIEditor_Button[4]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLVA003", getLocalPlayer(), 0, 34, 10 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  		end
  	elseif (source == GUIEditor_Button[5]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLVA004", getLocalPlayer(), 0, 28, 100 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  	end
  	elseif (source == GUIEditor_Button[6]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLVA005", getLocalPlayer(), 0, 28, 100 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  	end
  	elseif (source == GUIEditor_Button[7]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLVA006", getLocalPlayer(), 0, 28, 100 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  	end
  	elseif (source == GUIEditor_Button[8]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLVA007", getLocalPlayer(), 0, 28, 100 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  	end
  	elseif (source == GUIEditor_Button[9]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLVA008", getLocalPlayer(), 0, 28, 100 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  	end
  	elseif (source == GUIEditor_Button[10]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLVA009", getLocalPlayer(), 0, 28, 100 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  	end
  	elseif (source == GUIEditor_Button[11]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLVA0010", getLocalPlayer(), 0, 28, 100 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  	end
  	elseif (source == GUIEditor_Button[12]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLVA0011", getLocalPlayer(), 0, 28, 100 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  	end
  	elseif (source == GUIEditor_Button[13]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLVA0012", getLocalPlayer(), 0, 28, 100 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  	end
  	elseif (source == GUIEditor_Button[14]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLVA0013", getLocalPlayer(), 0, 28, 100 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  	end
  	elseif (source == GUIEditor_Button[15]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLVA0014", getLocalPlayer(), 0, 28, 100 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  	end
	end
end)