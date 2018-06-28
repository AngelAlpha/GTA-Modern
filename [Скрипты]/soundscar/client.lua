local sirenDoor = {}
local vehicleSound = {}

function updateVehicleSiren (table)
    sirenDoor = table
end
addEvent("updateVehicleSiren", true)
addEventHandler("updateVehicleSiren", getRootElement(), updateVehicleSiren)

function updateVehicleSoundSiren ()
    for i, data in ipairs (sirenDoor) do
	    local veh, state = unpack(data)
		
		if veh and isElement(veh) then
		    local x, y, z = getElementPosition(veh)
		    local isSound = vehicleSound[veh]
		
		    if not veh then
		        if isElement(isSound) then
			        destroyElement(isSound)
			    end
		    end
		
		    if state == true then
			    if not isElement(isSound) then
				    vehicleSound[veh] = playSound3D("sounds/door.mp3", x, y, z)
					attachElements (vehicleSound[veh], veh)
				end
				if isElement(isSound) then
				    if isSoundFinished(isSound) then
					    vehicleSound[veh] = playSound3D("sounds/door.mp3", x, y, z)
						attachElements (vehicleSound[veh], veh)
					end
				end
			elseif state == false then
			    if isElement(isSound) then
					destroyElement(isSound)
				end
			end
		end
	end
end
addEventHandler("onClientRender", getRootElement(), updateVehicleSoundSiren)

addEventHandler("onClientElementDestroy", getRootElement(), function ()
	if getElementType(source) == "vehicle" then
		local isSound = vehicleSound[source]
		if isElement(isSound) then
			destroyElement(isSound)
		end
	end
end)

function onEngineChangeStatus (vehicle)
    local x, y, z = getElementPosition(vehicle)
	local sound = playSound3D("sounds/engine.mp3", x, y, z)
	attachElements (sound, vehicle)
end
addEvent("onEngineChangeStatus", true)
addEventHandler("onEngineChangeStatus", getRootElement(), onEngineChangeStatus)

function isSoundFinished(theSound)
    return ( getSoundPosition(theSound) == getSoundLength(theSound) )
end