local scx,scy = guiGetScreenSize()
local px = scx/1920
local smothedRotation = 0

local sizeX,sizeY = 350*px,350*px
local posX,posY = scx-sizeX,scy-sizeY
local hud = 1

local font1 = dxCreateFont( "files/AEROMATICSBOLD.ttf",17*px )
local font2 = dxCreateFont( "files/AEROMATICSBOLDITALIC.ttf" )
local font3 = dxCreateFont( "files/AEROMATICSITALIC.ttf",50*px )
local font4 = dxCreateFont( "files/AEROMATICSITALIC.ttf",18*px )
local font5 = dxCreateFont( "files/AEROMATICSITALIC.ttf",30*px )
local font6 = dxCreateFont( "files/AEROMATICSITALIC.ttf",30*px )

function math.lerp(a, b, k)
	local result = a * (1-k) + b * k
	return result
end

local alpha = 255
local side = true
local pulsing = true
local veh = getPedOccupiedVehicle(localPlayer)

function drawSpeedometer()
	local veh = getPedOccupiedVehicle(localPlayer)
	if veh then
		if hud == 1 then
	    --dxDrawImage(posX+140*px,posY+283*px,150*px,50*px,"files/rpanel.png",0,0,0,tocolor(	252, 109, 181))
        local num = getElementData(veh,"mileage") or 0
		local mileage = ""..math.floor(num)
		repeat mileage = "0"..mileage until #mileage >= 7	
		local speedx, speedy, speedz = getElementVelocity ( veh )
		local actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5)
		local kmh = math.floor(actualspeed * 250)
		--[[local rotation = math.lerp(0,90,kmh/300)
		if rotation >= 90 then rotation = math.random(88,92) end]]--
		local rotation = math.floor(((170/8000)* getVehicleRPM(getPedOccupiedVehicle(getLocalPlayer()))) + 0.5)
	    if (smothedRotation < rotation) then
            smothedRotation = smothedRotation + 1.8
        end
        if (smothedRotation > rotation) then
            smothedRotation = smothedRotation - 1.8
        end
		if smothedRotation > 160 then
			smothedRotation = 160
		end
		if smothedRotation < -160 then
			smothedRotation = -160
		end
		
		local fuel = getElementData(veh,"fuel") or 50 -- Переменная топлива
		local fuelmax = 100
		local rotation2 = math.lerp(90,0, fuel/fuelmax)
		--local rotation2 = math.lerp(90,-0,fuel/fuelmax)
		--if rotation2 <= 0 then pulsing = true else pulsing = false end

		local gear = getVehicleCurrentGear( veh )
		if gear == 0 then
			if kmh <= 1 then
				gear = "N"
			else
				gear = "R"
			end 
		elseif gear == 1 then
			if kmh <= 2 then
				gear = "N"
			end
		end

		dxDrawText(gear,posX+250*px,posY-100*px,posX+sizeX,posY+sizeY,tocolor(0,100,100),1,font6,"center","center")
		dxDrawText(kmh,posX,posY+170*px,posX+sizeX,posY+250*px,tocolor(255,255,255),1,font5,"center","center")
		dxDrawText(mileage,posX,posY+100*px,posX+sizeX,posY+250*px,tocolor(255,255,255),1,font4,"center","center") 

		dxDrawImage(posX,posY,sizeX,sizeY,"files/Spedo.png")
		dxDrawImage(posX,posY,sizeX,sizeY,"files/strelkaspedo.png",smothedRotation) -- -150 to 90

		dxDrawImage(posX,posY,sizeX,sizeY,"files/move_fuel.png",rotation2)

		if getVehicleOverrideLights( veh ) == 2 then
			dxDrawImage(posX-70*px,posY-190*px,462*px,612*px,"files/light.png",0,0,0,tocolor(0,255,0))
		elseif getVehicleOverrideLights( veh ) == 1 then
			dxDrawImage(posX-70*px,posY-190*px,462*px,612*px,"files/light.png",0,0,0,tocolor(255,255,255))
		end

		if isVehicleLocked(veh) then
			dxDrawImage(posX+100*px,posY-185*px,400*px,400*px,"files/lock.png",0,0,0,tocolor(200,0,0))
		else
			dxDrawImage(posX+100*px,posY-185*px,400*px,400*px,"files/lock.png",0,0,0,tocolor(0,255,0))
		end
	end
	end
end
addEventHandler("onClientRender",root,drawSpeedometer)


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

function getVehicleRPM(vehicle)
local vehicleRPM = 0
    if (vehicle) then  
        if (getVehicleEngineState(vehicle) == true) then
            if getVehicleCurrentGear(vehicle) > 0 then             
                vehicleRPM = math.floor(((getElementSpeed(vehicle, "kmh")/getVehicleCurrentGear(vehicle))*150) + 0.5) 
                if (vehicleRPM < 650) then
                    vehicleRPM = math.random(650, 750)
                end
            else
                vehicleRPM = math.floor((getElementSpeed(vehicle, "kmh")*160) + 0.5)
                if (vehicleRPM < 650) then
                    vehicleRPM = math.random(650, 750)
                end
            end
        else
            vehicleRPM = 0
        end
        return tonumber(vehicleRPM)
    else
        return 0
    end
end

function getElementSpeed(theElement, unit)
    -- Check arguments for errors
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "kmh" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    -- Default to m/s if no unit specified and 'ignore' argument type if the string contains a number
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    -- Setup our multiplier to convert the velocity to the specified unit
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    -- Return the speed by calculating the length of the velocity vector, after converting the velocity to the specified unit
    return (Vector3(getElementVelocity(theElement)) * mult).length
end

bindKey("j","down",function()
	triggerServerEvent( "triggerVehicleSystem", localPlayer, "engine" )
end)

bindKey("l","down",function()
	triggerServerEvent( "triggerVehicleSystem", localPlayer, "lights" )
end)

bindKey("k","down",function()
	triggerServerEvent( "triggerVehicleSystem", localPlayer, "lock" )
end)
