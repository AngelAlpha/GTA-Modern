local sx, sy = guiGetScreenSize()
local scx, scy = (sx / 100), (sy / 100)
local font = dxCreateFont("test.otf", 28)

function getOriginalProcentOfText (x, y, sx, sy)
    local x, sx = (x / 14.4) * scx, (sx / 14.4) * scx
	local y, sy = (y / 9) * scy, (sy / 9) * scy
	return x, y, sx, sy
end

bindKey ("x", "both", function (key, keyState)
local p = localPlayer
local veh = getPedOccupiedVehicle (p)
if getElementData (p, "tegS") == true or getElementData (p, "tegO") == true then 
	if keyState == "down" then
		if veh then
			addEventHandler ("onClientRender", root, setSpeed)
		end
	else
		if veh then
			removeEventHandler ("onClientRender", root, setSpeed)
		end
	end
	end
end)



function setSpeed ()
local p = localPlayer
local veh = getPedOccupiedVehicle (p)
if getElementSpeed(veh, 1) <= maxSpeed and getElementSpeed(veh, 1) ~= 0 then
	local x, y, sx, sy = getOriginalProcentOfText(posx, posy, possx, possy)
	dxDrawText("TURBO", x, y, sx, sy, tocolor (255, 255, 255), 1,  font, "center", "center")
	setElementSpeed(veh, 1, getElementSpeed(veh, 1)+acceleration)
end
end

function setElementSpeed(element, unit, speed)
	if (unit == nil) then unit = 0 end
	if (speed == nil) then speed = 0 end
	speed = tonumber(speed)
	local acSpeed = getElementSpeed(element, unit)
	if (acSpeed~=false) then -- if true - element is valid, no need to check again
		local diff = speed/acSpeed
		if diff ~= diff then return end -- if the number is a 'NaN' return end.
		local x,y,z = getElementVelocity(element)
		setElementVelocity(element,x*diff,y*diff,z*diff)
		return true
	end

	return false
end

function getElementSpeed(theElement, unit)
    -- Check arguments for errors
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    -- Default to m/s if no unit specified and 'ignore' argument type if the string contains a number
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    -- Setup our multiplier to convert the velocity to the specified unit
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    -- Return the speed by calculating the length of the velocity vector, after converting the velocity to the specified unit
    return (Vector3(getElementVelocity(theElement)) * mult).length
end

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

local attachedEffects = {}

-- Taken from https://wiki.multitheftauto.com/wiki/GetElementMatrix example
function getPositionFromElementOffset(element,offX,offY,offZ)
	local m = getElementMatrix ( element )  -- Get the matrix
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
	return x, y, z  -- Return the transformed point
end

function attachEffect(effect, element, pos)
	attachedEffects[effect] = { effect = effect, element = element, pos = pos }
	addEventHandler("onClientElementDestroy", effect, function() attachedEffects[effect] = nil end)
	addEventHandler("onClientElementDestroy", element, function() attachedEffects[effect] = nil end)
	return true
end

addEventHandler("onClientPreRender", root, 	
	function()
		for fx, info in pairs(attachedEffects) do
			local x, y, z = getPositionFromElementOffset(info.element, info.pos.x, info.pos.y, info.pos.z)
			setElementPosition(fx, x, y, z)
		end
	end
)