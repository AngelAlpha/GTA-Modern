function move ()
for i, v in pairs (getElementsByType ("vehicle")) do
if i == 0 or i == nil then return end
local rx, ry, rz = getVehicleComponentRotation (v, "spoiler123")
local x, y, z = getVehicleComponentPosition (v, "spoiler123")
if rx == false then rx = 0 end
	if getElementModel(v) == 429 then
		if getElementData (v, "spoiler123") == true then
			if math.round (y, 2) ~= -0.30 then
				setVehicleComponentPosition (v, "spoiler123", x, y - 0.01, z + 0.01)
			else
				removeEventHandler ("onClientRender", root, move)
			end
		else
			if math.round (y, 2) ~= 0 then
				setVehicleComponentPosition (v, "spoiler123", x, y + 0.01, z - 0.01)
			else
				removeEventHandler ("onClientRender", root, move)
			end
		end
	elseif getElementModel(v) == 558 then
		if getElementData (v, "spoiler123") == true then
			if math.round (rx, 2) ~= 355.5 then
				setVehicleComponentRotation (v, "spoiler123", rx - 0.1, ry, rz)
			else
				removeEventHandler ("onClientRender", root, move)
			end
		else
			if math.round (rx, 2) ~= 0 then
				setVehicleComponentRotation (v, "spoiler123", rx + 0.1, ry, rz)
			else
				removeEventHandler ("onClientRender", root, move)
			end
		end
	elseif getElementModel(v) == 502 then
		if getElementData (v, "spoiler123") == true then
			if math.round (rx, 2) ~= 340 then
				setVehicleComponentRotation (v, "spoiler123", rx - 0.5, ry, rz)
			else
				removeEventHandler ("onClientRender", root, move)
			end
		else
			if math.round (rx, 2) ~= 0 then
				setVehicleComponentRotation (v, "spoiler123", rx + 0.5, ry, rz)
			else
				removeEventHandler ("onClientRender", root, move)
			end
		end
	elseif getElementModel(v) == 589 then
		if getElementData (v, "spoiler123") == true then
			if math.round (y, 2) ~= -0.14 then
				setVehicleComponentPosition (v, "spoiler123", x, y - 0.005, z + 0.005)
			else
				removeEventHandler ("onClientRender", root, move)
			end
		else
			if math.round (y, 2) ~= 0 then
				setVehicleComponentPosition (v, "spoiler123", x, y + 0.005, z - 0.005)
			else
				removeEventHandler ("onClientRender", root, move)
			end
		end
	elseif getElementModel(v) == 527 then
		if getElementData (v, "spoiler123") == true then
			if math.round (rx, 2) ~= 347 then
				setVehicleComponentRotation (v, "spoiler123", rx - 0.1, ry, rz)
			else
				removeEventHandler ("onClientRender", root, move)
			end
		else
			if math.round (rx, 2) ~= 0 then
				setVehicleComponentRotation (v, "spoiler123", rx + 0.1, ry, rz)
			else
				removeEventHandler ("onClientRender", root, move)
			end
		end
	end
end
end

addEventHandler ("onClientRender", root, function()
if getPedOccupiedVehicle (localPlayer) and getElementData (localPlayer, "spoiler123") then
	local v = getPedOccupiedVehicle (localPlayer)
	local rx, ry, rz = getVehicleComponentRotation (v, "spoiler123")
	local x, y, z = getVehicleComponentPosition (v, "spoiler123")
	if getElementModel(v) == 429 then
		if math.round (y, 2) < -0.30 then
			setVehicleComponentPosition (v, "spoiler123", 0, -0.30, 0)
		elseif math.round (y, 2) > 0 then
			setVehicleComponentPosition (v, "spoiler123", 0, 0, 0)
		end
	elseif getElementModel(v) == 558 then
		if math.round (rx, 2) > 355.5 then
			setVehicleComponentRotation (v, "spoiler123", 355.5, 0, 0)
		elseif math.round (rx, 2) < 0 then
			setVehicleComponentRotation (v, "spoiler123", 0, 0, 0)
		end
	elseif getElementModel(v) == 506 then
		if rx > 348.5 then
			setVehicleComponentRotation (v, "spoiler123", 348.5, 0, 0)
		elseif rx < 0 then
			setVehicleComponentRotation (v, "spoiler123", 0, 0, 0)
		end
	elseif getElementModel(v) == 502 then
		if math.round (rx, 2) > 340 then
			setVehicleComponentRotation (v, "spoiler123", 340, 0, 0)
		elseif math.round (rx, 2) < 0 then
			setVehicleComponentRotation (v, "spoiler123", 0, 0, 0)
		end
	elseif getElementModel(v) == 589 then
		if math.round (y, 2) < -0.14 then
			setVehicleComponentPosition (v, "spoiler123", 0, -0.14, 0)
		elseif math.round (y, 2) < 0 then
			setVehicleComponentPosition (v, "spoiler123", 0, 0, 0)
		end
	elseif getElementModel(v) == 527 then
		if math.round (rx, 2) > 347 then
			setVehicleComponentRotation (v, "spoiler123", 347, 0, 0)
		elseif math.round (rx, 2) < 0 then
			setVehicleComponentPosition (v, "spoiler123", 0, 0, 0)
		end
	end
end
end)

addEventHandler ("onClientRender", root, function()
if getPedOccupiedVehicle (localPlayer) then
if getElementModel (getPedOccupiedVehicle (localPlayer)) ~= 429 and getElementModel (getPedOccupiedVehicle (localPlayer)) ~= 558 and getElementModel (getPedOccupiedVehicle (localPlayer)) ~= 502 and getElementModel (getPedOccupiedVehicle (localPlayer)) ~= 506 and getElementModel (getPedOccupiedVehicle (localPlayer)) ~= 558 and getElementModel (getPedOccupiedVehicle (localPlayer)) ~= 527 then return end
	if getElementSpeed (getPedOccupiedVehicle (localPlayer), 1) > 80 then
		if not isEventHandlerAdded ("onClientRender", root, move) then
			setElementData (getPedOccupiedVehicle(localPlayer), "spoiler123", true)
			addEventHandler ("onClientRender", root, move)
		end
	else
		if not isEventHandlerAdded ("onClientRender", root, move) then
			setElementData (getPedOccupiedVehicle(localPlayer), "spoiler123", false)
			addEventHandler ("onClientRender", root, move)
		end
	end
end
end)

addCommandHandler ("moveY", function()
local x, y, z = getVehicleComponentPosition (getPedOccupiedVehicle(localPlayer), "spoiler123")
setVehicleComponentPosition (getPedOccupiedVehicle(localPlayer), "spoiler123", x, y - 0.01, z)
end)

addCommandHandler ("moveZ", function()
local x, y, z = getVehicleComponentPosition (getPedOccupiedVehicle(localPlayer), "spoiler123")
setVehicleComponentPosition (getPedOccupiedVehicle(localPlayer), "spoiler123", x, y, z + 0.01)
end)

addCommandHandler ("rot", function()
local x, y, z = getVehicleComponentRotation (getPedOccupiedVehicle(localPlayer), "spoiler123")
setVehicleComponentRotation (getPedOccupiedVehicle(localPlayer), "spoiler123", x-0.2, y, z)
end)

addCommandHandler ("get", function()
local x, y, z = getVehicleComponentPosition (getPedOccupiedVehicle(localPlayer), "spoiler123")
local rx, ry, rz = getVehicleComponentRotation (getPedOccupiedVehicle(localPlayer), "spoiler123")
print (math.round (y, 1), math.round (z, 1), math.round (rx, 1))
end)

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
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