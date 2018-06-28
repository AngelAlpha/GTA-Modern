local scx,scy = guiGetScreenSize()
local px = scx/1920
local sizeX, sizeY = 400*px,600*px
local posX,posY = 10*px,scy-sizeY-100*px
local font = dxCreateFont("11710.ttf", 10)
local font2 = dxCreateFont("11710.ttf", 25)
local hud = 1

function hou_circle( x, y, width, height, color, angleStart, angleSweep, borderWidth )
	height = height or width
	color = color or tocolor(255,255,255)
	borderWidth = borderWidth or 1e9
	angleStart = angleStart or 0
	angleSweep = angleSweep or 360 - angleStart
	if ( angleSweep < 360 ) then
		angleEnd = math.fmod( angleStart + angleSweep, 360 ) + 0
	else
		angleStart = 0
		angleEnd = 360
	end
	x = x - width / 2
	y = y - height / 2
	if not circleShader then
		circleShader = dxCreateShader ( "hou_circle.fx" )
	end
	dxSetShaderValue ( circleShader, "sCircleWidthInPixel", width );
	dxSetShaderValue ( circleShader, "sCircleHeightInPixel", height );
	dxSetShaderValue ( circleShader, "sBorderWidthInPixel", borderWidth );
	dxSetShaderValue ( circleShader, "sAngleStart", math.rad( angleStart ) - math.pi );
	dxSetShaderValue ( circleShader, "sAngleEnd", math.rad( angleEnd ) - math.pi );
	dxDrawImage( x, y, width, height, circleShader, 0, 0, 0, color )
end


function math.lerp(a, b, k)
	local result = a * (1-k) + b * k
	if result >= b then
		result = b
	elseif result <= a then
		result = a
	end
	return result
end

function drawMenu ()
if hud == 1 then
	local veh = getPedOccupiedVehicle (localPlayer)
	if veh then
	local speedx, speedy, speedz = getElementVelocity ( veh )
	local actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5)
	local kmh = math.floor(actualspeed * 180)
	local rotation = math.lerp(-140,140,kmh/220)
	if rotation >= 150 then rotation = math.random(158,162) end
	local fuelmax = 100
	local fuel = math.floor(getElementData (getPedOccupiedVehicle(localPlayer), "vehicle:fuel") or 100)
	local rotation2 = math.lerp(-72,80,fuel/fuelmax)
	local propeg =  math.floor(getElementData(getPedOccupiedVehicle(localPlayer), "vehicle:mileage") or 0)
	local flashing = false
	local timer
	
	if getElementData (veh, "flashing:rightflash") ~= false then
		dxDrawImage(posX+1790*px, posY+500*px, 39*px, 30*px, "right.png", 0, 0, 0, tocolor(0, 255, 0, 255))
	else
		dxDrawImage(posX+1790*px, posY+500*px, 39*px, 30*px, "right.png", 0, 0, 0, tocolor(255, 255, 255, 255))
	end
	
	if getElementData (veh, "flashing:leftflash") ~= false then
		dxDrawImage(posX+1710*px, posY+500*px, 39*px, 30*px, "left.png", 0, 0, 0, tocolor(0, 255, 0, 255))
	else
		dxDrawImage(posX+1710*px, posY+500*px, 39*px, 30*px, "left.png", 0, 0, 0, tocolor(255, 255, 255, 255))
	end
	
	if getElementData (veh, "flashing:allflash") ~= false then
		dxDrawImage(posX+1710*px, posY+500*px, 39*px, 30*px, "left.png", 0, 0, 0, tocolor(0, 255, 0, 255))
		dxDrawImage(posX+1790*px, posY+500*px, 39*px, 30*px, "right.png", 0, 0, 0, tocolor(0, 255, 0, 255))
	end
	
	dxDrawImage(posX+1585*px, posY+540*px, 116*px, 105*px, "strfuel.png", rotation2)  -- dxDrawImage(X, Y, Ширины, Высота, Картинка)
	dxDrawImage(posX+1585*px, posY+540*px, 116*px, 105*px, "fuel.png")
	dxDrawImage(posX+1650*px, posY+420*px, 249*px, 227*px, "speedo.png")
	dxDrawImage(posX+1650*px, posY+420*px, 249*px, 227*px, "strspeedo.png", rotation)
	
	dxDrawImage(posX+1602*px, posY+640*px, 247*px, 12*px, "speedolinia.png")
	
	if getVehicleEngineState(getPedOccupiedVehicle(localPlayer)) == false then
		dxDrawImage(posX+1795*px, posY+655*px, 39*px, 30*px, "engine.png", 0, 0, 0, tocolor(255, 255, 255, 255))
	else
		dxDrawImage(posX+1795*px, posY+655*px, 39*px, 30*px, "engine.png", 0, 0, 0, tocolor(255, 200, 0, 255))
	end
	
	if isElementFrozen(getPedOccupiedVehicle(localPlayer)) then
		dxDrawImage(posX+1750*px, posY+655*px, 39*px, 30*px, "brake.png", 0, 0, 0, tocolor(255, 200, 0, 255))
	else
		dxDrawImage(posX+1750*px, posY+655*px, 39*px, 30*px, "brake.png", 0, 0, 0, tocolor(255, 255, 255, 255))
	end
	
	if isVehicleLocked(getPedOccupiedVehicle(localPlayer)) then
		dxDrawImage(posX+1705*px, posY+655*px, 39*px, 30*px, "lock.png", 0, 0, 0, tocolor(255, 0, 0, 255))
	else
		dxDrawImage(posX+1705*px, posY+655*px, 39*px, 30*px, "lock.png", 0, 0, 0, tocolor(255, 255, 255, 255))
	end
	
	if getVehicleOverrideLights(getPedOccupiedVehicle(localPlayer)) == 2 then
		dxDrawImage(posX+1660*px, posY+655*px, 36*px, 27*px, "light.png", 0, 0, 0, tocolor(0, 255, 0, 255))
	else
		dxDrawImage(posX+1660*px, posY+655*px, 36*px, 27*px, "light.png", 0, 0, 0, tocolor(255, 255, 255, 255))
	end
	
	if getElementData (getPedOccupiedVehicle(localPlayer), "fari") == true then
		dxDrawImage(posX+1660*px, posY+655*px, 36*px, 27*px, "light.png", 0, 0, 0, tocolor(0, 191, 255))
	end
	
	if getElementData (getPedOccupiedVehicle(localPlayer), "vehicle:belt") ~= true then
		dxDrawImage(posX+1615*px, posY+655*px, 36*px, 27*px, "belt.png", 0, 0, 0, tocolor(255, 255, 255, 255))
	else
		dxDrawImage(posX+1615*px, posY+655*px, 36*px, 27*px, "belt.png", 0, 0, 0, tocolor(0, 255, 0, 255))
	end
	
	if kmh == 0 then
	dxDrawText ("00"..kmh, posX+1510*px,posY+600*px,posX+1510*px + 300*px,posY+600*px + 40*px, tocolor(150, 150, 150, 200), 1*px, font2, "right")
	elseif kmh < 10 and kmh > 0 then
	dxDrawText ("00"..kmh, posX+1510*px,posY+600*px,posX+1510*px + 300*px,posY+600*px + 40*px, tocolor(150, 150, 150, 200), 1*px, font2, "right")
	elseif kmh < 100 and kmh > 10 then
	dxDrawText ("0"..kmh, posX+1510*px,posY+600*px,posX+1510*px + 300*px,posY+600*px + 40*px, tocolor(150, 150, 150, 200), 1*px, font2, "right")
	elseif kmh < 1000 and kmh > 100 then
	dxDrawText (""..kmh, posX+1510*px,posY+600*px,posX+1510*px + 300*px,posY+600*px + 40*px, tocolor(150, 150, 150, 200), 1*px, font2, "right")
	end
	
	if kmh < 160 then
	dxDrawText (kmh,posX+1510*px,posY+600*px,posX+1510*px + 300*px,posY+600*px + 40*px, tocolor(255, 255, 255, 200), 1*px, font2, "right")
	elseif kmh > 159 and kmh < 180 then
	dxDrawText (kmh, posX+1510*px,posY+600*px,posX+1510*px + 300*px,posY+600*px + 40*px, tocolor(255, 211, 0, 200), 1*px, font2, "right")
	elseif kmh > 179 and kmh < 200 then
	dxDrawText (kmh, posX+1510*px,posY+600*px,posX+1510*px + 300*px,posY+600*px + 40*px, tocolor(255, 162, 0, 200), 1*px, font2, "right")
	elseif kmh > 199 and kmh < 10000 then
	dxDrawText (kmh, posX+1510*px,posY+600*px,posX+1510*px + 300*px,posY+600*px + 40*px, tocolor(255, 0, 0, 200), 1*px, font2, "right")
	end
	
	if propeg < 10 and propeg >= 0 then
	dxDrawText ("000"..propeg, posX+1500*px,posY+566*px,posX+1500*px + 300*px,posY+566*px + 40*px, tocolor(255, 255, 255, 200), 1.2*px, font, "right")
	elseif propeg < 100 and propeg > 9 then
	dxDrawText ("00"..propeg, posX+1500*px,posY+566*px,posX+1500*px + 300*px,posY+566*px + 40*px, tocolor(255, 255, 255, 200), 1.2*px, font, "right")
	elseif propeg < 1000 and propeg > 99 then
	dxDrawText ("0"..propeg, posX+1500*px,posY+566*px,posX+1500*px + 300*px,posY+566*px + 40*px, tocolor(255, 255, 255, 200), 1.2*px, font, "right")
	elseif propeg < 10000 and propeg > 999 then
	dxDrawText (propeg, posX+1500*px,posY+566*px,posX+1500*px + 300*px,posY+566*px + 40*px, tocolor(255, 255, 255, 200), 1.2*px, font, "right")
	end
	end
end
end
addEventHandler("onClientRender", getRootElement(), drawMenu)

function setVisible (bool) 
if bool == true then
	hud = 1
elseif bool == false then
	hud = 0
end
end

function show()
if hud == 1 then
hud = 0
else
hud = 1 
end
end
addCommandHandler ("speed", show)

bindKey("j","down",function()
	local veh = getPedOccupiedVehicle(localPlayer)
	if veh then
	if math.floor(getElementHealth (veh)) > 300 then
		triggerServerEvent( "triggerVehicleSystem", localPlayer, "engine" )
		else
		outputChatBox ("Посетите СТО!", 255, 0, 0)
	end
	end
end)

bindKey("k","down",function()
	triggerServerEvent( "triggerVehicleSystem", localPlayer, "lock" )
end)

bindKey("z","down",function()
	triggerServerEvent( "triggerVehicleSystem", localPlayer, "belt" )
end)

bindKey("l","down",function()
	triggerServerEvent( "triggerVehicleSystem", localPlayer, "lights" )
end)