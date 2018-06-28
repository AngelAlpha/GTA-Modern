local GUIEditor_Window = {}
local GUIEditor_Button = {}
local GUIEditor_Label = {}

local x,y = guiGetScreenSize() 
GUIEditor_Window[1] = guiCreateWindow((x-410)/2, (y-450)/2, 410, 550, "Выберите ключ от автомобиля", false )
guiWindowSetSizable(GUIEditor_Window[1],false)
guiSetVisible(GUIEditor_Window[1],false)
GUIEditor_Button[1] = guiCreateButton(5,500,400,40,"Закрыть",false,GUIEditor_Window[1])
GUIEditor_Button[2] = guiCreateButton(5,25,400,30, "Ключи от Police Car[] (2 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[3] = guiCreateButton(5,58,400,30, "Ключи от Police Car[] (2 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[4] = guiCreateButton(5,91,400,30, "Ключи от Police Car[] (2 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[5] = guiCreateButton(5,124,400,30, "Ключи от Police Car[] (2 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[6] = guiCreateButton(5,157,400,30, "Ключи от Police Car] (2 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[7] = guiCreateButton(5,190,400,30, "Ключи от Police Car[] (10 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[8] = guiCreateButton(5,223,400,30, "Ключи от Police Car] (10 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[9] = guiCreateButton(5,256,400,30, "Ключи от Police Ranger[] (6 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[10] = guiCreateButton(5,289,400,30, "Ключи от Police Ranger[] (6 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[11] = guiCreateButton(5,322,400,30, "Ключи от Police Ranger[] (3 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[12] = guiCreateButton(5,355,400,30, "Ключи от Police Ranger[] (3 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[13] = guiCreateButton(5,388,400,30, "Ключи от Police Ranger[] (3 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[14] = guiCreateButton(5,421,400,30, "Ключи от Enforcer[] (3 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[15] = guiCreateButton(5,454,400,30, "Ключи от Enforcer[] (9 ранг)",false,GUIEditor_Window[1])
	
function showAmmoGUI( hitPlayer, type, num )
	guiSetVisible ( GUIEditor_Window[1], true )
	showCursor( true )
	for i = 2, 8 do
		guiSetText (GUIEditor_Button[i], "Ключи от Police Car ["..positionVeh[i-1][8].."|77] (3 ранг)")
	end
	for i = 9, 13 do
		guiSetText (GUIEditor_Button[i], "Ключи от Police Ranger ["..positionVeh[i-1][8].."|77] (6 ранг)")
	end
	for i = 14, 15 do
		guiSetText (GUIEditor_Button[i], "Ключи от Enforcer ["..positionVeh[i-1][8].."|77] (9 ранг)")
	end
end
addEvent("showAmmoLSPDKluch",true)
addEventHandler("showAmmoLSPDKluch",getRootElement(),showAmmoGUI)

function UbratyAutoLSPD001( hitPlayer, type, num )
triggerServerEvent( "DestroyvehicleLSPD003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLSPD001",true)
addEventHandler("UbratyAutoLSPD001",getRootElement(),UbratyAutoLSPD001)

function UbratyAutoLSPD002( hitPlayer, type, num )
triggerServerEvent( "DestroyvehicleLSPD003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLSPD002",true)
addEventHandler("UbratyAutoLSPD002",getRootElement(),UbratyAutoLSPD002)

function UbratyAutoLSPD003( hitPlayer, type, num )
triggerServerEvent( "DestroyvehicleLSPD003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLSPD003",true)
addEventHandler("UbratyAutoLSPD003",getRootElement(),UbratyAutoLSPD003)

function UbratyAutoLSPD004( hitPlayer, type, num )
triggerServerEvent( "DestroyvehicleLSPD003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLSPD004",true)
addEventHandler("UbratyAutoLSPD004",getRootElement(),UbratyAutoLSPD004)

function UbratyAutoLSPD005( hitPlayer, type, num )
triggerServerEvent( "DestroyvehicleLSPD003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLSPD005",true)
addEventHandler("UbratyAutoLSPD005",getRootElement(),UbratyAutoLSPD005)

function UbratyAutoLSPD006( hitPlayer, type, num )
triggerServerEvent( "DestroyvehicleLSPD003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLSPD006",true)
addEventHandler("UbratyAutoLSPD006",getRootElement(),UbratyAutoLSPD006)

function UbratyAutoLSPD007( hitPlayer, type, num )
triggerServerEvent( "DestroyvehicleLSPD003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLSPD007",true)
addEventHandler("UbratyAutoLSPD007",getRootElement(),UbratyAutoLSPD007)

function UbratyAutoLSPD008( hitPlayer, type, num )
triggerServerEvent( "DestroyvehicleLSPD003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLSPD008",true)
addEventHandler("UbratyAutoLSPD008",getRootElement(),UbratyAutoLSPD008)

function UbratyAutoLSPD009( hitPlayer, type, num )
triggerServerEvent( "DestroyvehicleLSPD003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLSPD009",true)
addEventHandler("UbratyAutoLSPD009",getRootElement(),UbratyAutoLSPD009)

function UbratyAutoLSPD0010( hitPlayer, type, num )
triggerServerEvent( "DestroyvehicleLSPD003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLSPD0010",true)
addEventHandler("UbratyAutoLSPD0010",getRootElement(),UbratyAutoLSPD0010)

function UbratyAutoLSPD0011( hitPlayer, type, num )
triggerServerEvent( "DestroyvehicleLSPD003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLSPD0011",true)
addEventHandler("UbratyAutoLSPD0011",getRootElement(),UbratyAutoLSPD0011)

function UbratyAutoLSPD0012( hitPlayer, type, num )
triggerServerEvent( "DestroyvehicleLSPD003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLSPD0012",true)
addEventHandler("UbratyAutoLSPD0012",getRootElement(),UbratyAutoLSPD0012)

function UbratyAutoLSPD0013( hitPlayer, type, num )
triggerServerEvent( "DestroyvehicleLSPD003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLSPD0013",true)
addEventHandler("UbratyAutoLSPD0013",getRootElement(),UbratyAutoLSPD0013)

function UbratyAutoLSPD0014( hitPlayer, type)
triggerServerEvent( "DestroyvehicleLSPD003", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoLSPD0014",true)
addEventHandler("UbratyAutoLSPD0014",getRootElement(),UbratyAutoLSPD0014)

addEventHandler("onClientGUIClick",getRootElement(),
function ( player )
	local player2 = getLocalPlayer()
	local money = getPlayerMoney ( player2 )
   	if (source == GUIEditor_Button[1]) then
   		guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
   	elseif (source == GUIEditor_Button[2]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLSPD001", getLocalPlayer(), 0, 24, 35 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  		end
  	elseif (source == GUIEditor_Button[3]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLSPD002", getLocalPlayer(), 0, 31, 100 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  		end
  	elseif (source == GUIEditor_Button[4]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLSPD003", getLocalPlayer(), 0, 34, 10 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  		end
  	elseif (source == GUIEditor_Button[5]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLSPD004", getLocalPlayer(), 0, 28, 100 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  	end
  	elseif (source == GUIEditor_Button[6]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLSPD005", getLocalPlayer(), 0, 28, 100 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  	end
  	elseif (source == GUIEditor_Button[7]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLSPD006", getLocalPlayer(), 0, 28, 100 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  	end
  	elseif (source == GUIEditor_Button[8]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLSPD007", getLocalPlayer(), 0, 28, 100 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  	end
  	elseif (source == GUIEditor_Button[9]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLSPD008", getLocalPlayer(), 0, 28, 100 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  	end
  	elseif (source == GUIEditor_Button[10]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLSPD009", getLocalPlayer(), 0, 28, 100 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  	end
  	elseif (source == GUIEditor_Button[11]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLSPD0010", getLocalPlayer(), 0, 28, 100 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  	end
  	elseif (source == GUIEditor_Button[12]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLSPD0011", getLocalPlayer(), 0, 28, 100 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  	end
  	elseif (source == GUIEditor_Button[13]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLSPD0012", getLocalPlayer(), 0, 28, 100 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  	end
  	elseif (source == GUIEditor_Button[14]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLSPD0013", getLocalPlayer(), 0, 28, 100 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  	end
  	elseif (source == GUIEditor_Button[15]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchLSPD0014", getLocalPlayer(), 0, 28, 100 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  	end
	end
end)