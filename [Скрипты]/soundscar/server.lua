local vehicleEngine = {}

function updateVehicleDoorSirens ()
    local vehicles = {}
    for i, veh in ipairs (getElementsByType("vehicle")) do
	    local isDoorOpen = getVehicleDoorOpen (veh)
		table.insert(vehicles, {veh, isDoorOpen})
	end
	triggerClientEvent("updateVehicleSiren", getRootElement(), vehicles)
end
setTimer(updateVehicleDoorSirens, 500, 0)

function getVehicleDoorOpen (veh)
    local isDoorOpenResult = false
    for i = 2, 5 do
	    local isVehicleDoorOpen = getVehicleDoorOpenRatio ( veh, i )
		if isVehicleDoorOpen == 1 then
		    isDoorOpenResult = true
			break
		end
	end
	return isDoorOpenResult
end

function changeEngineState (player)
    local vehicle = getPedOccupiedVehicle(player)
	if getPedOccupiedVehicleSeat (player) ~= 0 then return end
	if not isTimer(vehicleEngine[vehicle]) then
	    setVehicleEngineState(vehicle, not getVehicleEngineState(vehicle))
		if getVehicleEngineState(vehicle) == true then
		    triggerClientEvent("onEngineChangeStatus", getRootElement(), vehicle)
			outputChatBox("Двигатель включен!", player, 0, 255, 0)
		else
			outputChatBox("Двигатель выключен!", player, 255, 0, 0)
		end
		vehicleEngine[vehicle] = setTimer(
		    function (vehicle)
			    if isTimer(vehicleEngine[vehicle]) then
				    killTimer(vehicleEngine[vehicle])
					if isElement(vehicleEngine[vehicle]) then
						destroyElement(vehicleEngine[vehicle])
					end
				end
			end, 2000, 1, vehicle
		)
	end
end

function onPlayerLogin ()
    bindKey(source, "lctrl", "down", changeEngineState)
end
addEventHandler("onPlayerLogin", getRootElement(), onPlayerLogin)

function onResourceStart ()
    for i, player in ipairs (getElementsByType("player")) do
	    bindKey(player, "lctrl", "down", changeEngineState)
	end
end
addEventHandler("onResourceStart", getResourceRootElement( getThisResource() ), onResourceStart)