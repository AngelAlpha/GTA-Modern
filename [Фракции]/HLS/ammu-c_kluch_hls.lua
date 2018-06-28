local GUIEditor_Window = {}
local GUIEditor_Button = {}
local GUIEditor_Label = {}

local x,y = guiGetScreenSize() 
GUIEditor_Window[1] = guiCreateWindow((x-410)/2, (y-250)/2, 410, 250, "Выберите ключ от автомобиля", false )
guiWindowSetSizable(GUIEditor_Window[1],false)
guiSetVisible(GUIEditor_Window[1],false)
GUIEditor_Button[1] = guiCreateButton(5,200,400,40,"Закрыть",false,GUIEditor_Window[1])
GUIEditor_Button[2] = guiCreateButton(5,25,400,30, "Ключи от Ambulance[] (3 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[3] = guiCreateButton(5,58,400,30, "Ключи от Ambulance[] (3 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[4] = guiCreateButton(5,91,400,30, "Ключи от Ambulance[] (3 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[5] = guiCreateButton(5,124,400,30, "Ключи от Ambulance[] (3 ранг)",false,GUIEditor_Window[1])
GUIEditor_Button[6] = guiCreateButton(5,157,400,30, "Ключи от Ambulance[] (3 ранг)",false,GUIEditor_Window[1])
	
function showAmmoGUI( hitPlayer, type )
	guiSetVisible ( GUIEditor_Window[1], true )
	showCursor( true )
	for i = 2, 6 do
		guiSetText (GUIEditor_Button[i], "Ключи от Ambulance ["..positionVeh[i-1][8].."|77] (3 ранг)")
	end
end
addEvent("showAmmoHLSKluch",true)
addEventHandler("showAmmoHLSKluch",getRootElement(),showAmmoGUI)

function UbratyAutoHLS001( hitPlayer, type, num)
triggerServerEvent( "DestroyvehicleHLS", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoHLS001",true)
addEventHandler("UbratyAutoHLS001",getRootElement(),UbratyAutoHLS001)

function UbratyAutoHLS002( hitPlayer, type, num)
triggerServerEvent( "DestroyvehicleHLS", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoHLS002",true)
addEventHandler("UbratyAutoHLS002",getRootElement(),UbratyAutoHLS002)

function UbratyAutoHLS003( hitPlayer, type, num)
triggerServerEvent( "DestroyvehicleHLS", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoHLS003",true)
addEventHandler("UbratyAutoHLS003",getRootElement(),UbratyAutoHLS003)

function UbratyAutoHLS004( hitPlayer, type, num)
triggerServerEvent( "DestroyvehicleHLS", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoHLS004",true)
addEventHandler("UbratyAutoHLS004",getRootElement(),UbratyAutoHLS004)

function UbratyAutoHLS005( hitPlayer, type, num)
triggerServerEvent( "DestroyvehicleHLS", getLocalPlayer(), localPlayer, num)
end
addEvent("UbratyAutoHLS005",true)
addEventHandler("UbratyAutoHLS005",getRootElement(),UbratyAutoHLS005)


addEventHandler("onClientGUIClick",getRootElement(),
function ( player )
	local player2 = getLocalPlayer()
	local money = getPlayerMoney ( player2 )
   	if (source == GUIEditor_Button[1]) then
   		guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
   	elseif (source == GUIEditor_Button[2]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchHLS001", getLocalPlayer(), 0, 24, 35 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  		end
  	elseif (source == GUIEditor_Button[3]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchHLS002", getLocalPlayer(), 0, 31, 100 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  		end
  	elseif (source == GUIEditor_Button[4]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchHLS003", getLocalPlayer(), 0, 34, 10 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  		end
  	elseif (source == GUIEditor_Button[5]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "VzyatKluchHLS004", getLocalPlayer(), 0, 28, 100 )
   			cooldown = setTimer (function () end, 800, 1)
			guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
  	end
end
end)