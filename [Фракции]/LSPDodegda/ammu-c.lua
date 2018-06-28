local GUIEditor_Window = {}
local GUIEditor_Button = {}
local GUIEditor_Label = {}

local x,y = guiGetScreenSize() 
GUIEditor_Window[1] = guiCreateWindow((x-410)/2, (y-180)/2, 410, 180, "Переодевалка", false )
guiWindowSetSizable(GUIEditor_Window[1],false)
guiSetVisible(GUIEditor_Window[1],false)
GUIEditor_Button[1] = guiCreateButton(5,105,400,40,"Закрыть",false,GUIEditor_Window[1])
GUIEditor_Button[2] = guiCreateButton(5,62,195,40, "Рабочая форма",false,GUIEditor_Window[1])
GUIEditor_Button[3] = guiCreateButton(205,62,195,40, "Моя одежда",false,GUIEditor_Window[1])
img1 = guiCreateStaticImage(5,22,195,40, "img/HOTSMALL.png", false, GUIEditor_Window[1])


GUIEditor_Label[1] = guiCreateLabel(30,300,400,20, 
	"", false, GUIEditor_Window[1])
GUIEditor_Label[2] = guiCreateLabel(30,30,190,20, 
	"", false, GUIEditor_Window[1])
GUIEditor_Label[3] = guiCreateLabel(30,190,190,20, 
	"", false, GUIEditor_Window[1])
GUIEditor_Label[4] = guiCreateLabel(220,30,190,20, 
	"", false, GUIEditor_Window[1])
GUIEditor_Label[5] = guiCreateLabel(220,190,190,20, 
	"", false, GUIEditor_Window[1])
GUIEditor_Label[6] = guiCreateLabel(410,30,190,20, 
	"", false, GUIEditor_Window[1])
GUIEditor_Label[7] = guiCreateLabel(410,190,190,20, 
	"", false, GUIEditor_Window[1])
	
	function initialize_menu_choices(r_type)

	-- Destroy current images if any
	if img1 and isElement(img1) then destroyElement(img1) end

	-- Make new images, (load from files when needed)
	img1 = guiCreateStaticImage(5,22,195,40, "img/CLUHEAL.png", false,GUIEditor_Window[1])
end

function showAmmoGUI( hitPlayer, type )
	guiSetVisible ( GUIEditor_Window[1], true )
	showCursor( true )
	initialize_menu_choices(r_type)
end
addEvent("showAmmoGUILSPDodegda",true)
addEventHandler("showAmmoGUILSPDodegda",getRootElement(),showAmmoGUI)

addEventHandler("onClientGUIClick",getRootElement(),
function ( player )
	local player2 = getLocalPlayer()
   	if (source == GUIEditor_Button[1]) then
   		guiSetVisible (GUIEditor_Window[1],false)
   		showCursor (false)
   	elseif (source == GUIEditor_Button[2]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "LSPDodeg", getLocalPlayer(), 0, 24, 35 )
   			cooldown = setTimer (function () end, 800, 1)
  		end
   	elseif (source == GUIEditor_Button[3]) then
   		if  not isTimer (cooldown) then
   			triggerServerEvent( "Meinodeg1", getLocalPlayer(), 0, 24, 35 )
   			cooldown = setTimer (function () end, 800, 1)
  		end
  	end
end)