local ping = getPlayerPing(getLocalPlayer())
local x, y = guiGetScreenSize ( )

r,g,b=0,0,0
alpha=200


local root = getRootElement()
local player = getLocalPlayer()
local counter = 0
local starttick
local currenttick

addEventHandler("onClientRender",root,
	function()
		if not starttick then
			starttick = getTickCount()
		end
		counter = counter + 1
		currenttick = getTickCount()
		if currenttick - starttick >= 1000 then
			setElementData(player,"FPS",counter)
			counter = 0
			starttick = false
		end
	end
)

function drawStates ()
if not isEventHandlerAdded ("onClientRender", root, fpsState) then
	addEventHandler ( "onClientRender", root, fpsState )
else
	removeEventHandler ( "onClientRender", root, fpsState )
end
end
addCommandHandler ("fps", drawStates)

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
     if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
          local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
          if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
               for i, v in ipairs( aAttachedFunctions ) do
                    if v == func then
        	         return true
        	    end
	       end
	  end
     end
     return false
end

function pingState()
    posx= x-30
    posy= 20

    dxDrawRectangle ( posx, posy, 4, 4, tocolor ( r, g, b, alpha ) )
	dxDrawRectangle ( posx+5, posy-4, 4,8, tocolor ( r, g, b, alpha ) )
	dxDrawRectangle ( posx+10, posy-8, 4,12, tocolor ( r, g, b, alpha ) )
	dxDrawRectangle ( posx+15, posy-12, 4,16, tocolor ( r, g, b, alpha ) )
	dxDrawRectangle ( posx+20, posy-16, 4,20, tocolor ( r, g, b, alpha ) )

	r2,g2,b2=255,255,255
    alpha2=255

if ping <= 100 then

    dxDrawRectangle ( posx, posy, 4, 4, tocolor ( r2, g2, b2, alpha2 ) )
	dxDrawRectangle ( posx+5, posy-4, 4,8, tocolor ( r2, g2, b2, alpha2 ) )
	dxDrawRectangle ( posx+10, posy-8, 4,12, tocolor ( r2, g2, b2, alpha2 ) )
	dxDrawRectangle ( posx+15, posy-12, 4,16, tocolor ( r2, g2, b2, alpha2 ) )
	dxDrawRectangle ( posx+20, posy-16, 4,20, tocolor ( r2, g2, b2, alpha2 ) )

elseif ping >=101 and ping <= 200 then

    dxDrawRectangle ( posx, posy, 4, 4, tocolor ( r2, g2, b2, alpha2 ) )
	dxDrawRectangle ( posx+5, posy-4, 4,8, tocolor ( r2, g2, b2, alpha2 ) )
	dxDrawRectangle ( posx+10, posy-8, 4,12, tocolor ( r2, g2, b2, alpha2 ) )
	dxDrawRectangle ( posx+15, posy-12, 4,16, tocolor ( r2, g2, b2, alpha2 ) )

elseif ping >=201 and ping <= 300 then

    dxDrawRectangle ( posx, posy, 4, 4, tocolor ( r2, g2, b2, alpha2 ) )
	dxDrawRectangle ( posx+5, posy-4, 4,8, tocolor ( r2, g2, b2, alpha2 ) )
	dxDrawRectangle ( posx+10, posy-8, 4,12, tocolor ( r2, g2, b2, alpha2 ) )

elseif ping >=301 and ping <= 400 then

    dxDrawRectangle ( posx, posy, 4, 4, tocolor ( r2, g2, b2, alpha2 ) )
	dxDrawRectangle ( posx+5, posy-4, 4,8, tocolor ( r2, g2, b2, alpha2 ) )

elseif ping >=401 and ping <= 500 then

    dxDrawRectangle ( posx, posy, 4, 4, tocolor ( r2, g2, b2, alpha2 ) )

end

end

function fpsState()
    posx2= x-55
    posy2= 13
	local x, y, sx, sy = getOriginalProcentOfText (10, 870, 1430, 86)
	dxDrawText ( "FPS: ", x, y, sx, sy, tocolor ( 255, 255, 255, 255 ), 1.4, "default-bold" )
	if tonumber(getElementData(localPlayer, "FPS")) >= 80 then
		dxDrawText (getElementData(localPlayer, "FPS"), x+45, y, sx, sy, tocolor ( 0, 255, 0, 255 ), 1.4, "default-bold" )
	elseif tonumber(getElementData(localPlayer, "FPS")) < 80 and tonumber(getElementData(localPlayer, "FPS")) >= 60 then 
		dxDrawText (getElementData(localPlayer, "FPS"), x+45, y, sx, sy, tocolor ( 255, 255, 0, 255 ), 1.4, "default-bold" )
	elseif tonumber(getElementData(localPlayer, "FPS")) < 60 and tonumber(getElementData(localPlayer, "FPS")) >= 30 then 
		dxDrawText (getElementData(localPlayer, "FPS"), x+45, y, sx, sy, tocolor ( 255, 165, 0, 255 ), 1.4, "default-bold" )
	elseif tonumber(getElementData(localPlayer, "FPS")) < 30 then
		dxDrawText (getElementData(localPlayer, "FPS"), x+45, y, sx, sy, tocolor ( 255, 0, 0, 255 ), 1.4, "default-bold" )
	end
end

function getOriginalProcentOfText (x, y, sx, sy)
	local sx, sy = guiGetScreenSize()
	local scx, scy = (sx / 100), (sy / 100)
    local x, sx = (x / 14.4) * scx, (sx / 14.4) * scx
	local y, sy = (y / 9) * scy, (sy / 9) * scy
	return x, y, sx, sy
end