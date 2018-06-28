local screenWidth,screenHeight = guiGetScreenSize()
--[[local screen = dxCreateScreenSource ( screenWidth, screenHeight )
	
function image()
	dxDrawImage( screenWidth/2, -1, 377, 181, "fon.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)	
end	
	
function cleanmyscreen()
	dxUpdateScreenSource(screen) 
	dxDrawImage( screenWidth - screenWidth,  screenHeight - screenHeight,  screenWidth, screenHeight, screen, 0, 0, 0, tocolor (255, 255, 255, 255), true)	
end


function tooglecleanmyscreen ()
enabled = not enabled
if enabled then
	addEventHandler( "onClientPreRender", root, image)
	addEventHandler( "onClientRender", root, cleanmyscreen)
	else
	removeEventHandler( "onClientPreRender", root, image)
	removeEventHandler( "onClientRender", root, cleanmyscreen)
end
end
bindKey ("f6", "down", tooglecleanmyscreen)]]--

function tooglecleanmyscreen ()
enabled = not enabled
if enabled then
	addEventHandler( "onClientRender", root, image)
	exports.hud:setVisible(false)
	exports.radar:setVisible(false)
	exports.niki:setVisible(false)
	exports.speedometr:setVisible(false)
	showChat (false)
	else
	removeEventHandler( "onClientRender", root, image)
	exports.hud:setVisible(true)
	exports.radar:setVisible(true)
	exports.niki:setVisible(true)
	exports.speedometr:setVisible(true)
	showChat (true)
end
end
bindKey ("f6", "down", tooglecleanmyscreen)

function image()
	dxDrawImage( screenWidth-371, -1, 377, 181, "fon.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)	
end	
