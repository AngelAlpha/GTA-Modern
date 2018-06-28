local light = 0
function triggerVehicleSystem(sys)
	local veh = getPedOccupiedVehicle(source)
	if veh and getVehicleController(veh) == source then
		if sys == "engine" then
			if not getElementData(veh,"fuel") then setVehicleEngineState(veh, not getVehicleEngineState(veh))  return end
			if getElementData(veh,"fuel") > 0 then
				setVehicleEngineState(veh, not getVehicleEngineState(veh))
			else
				outputChatBox("Нет бензина!",source,200,0,0)
			end
		elseif sys == "lights" then
			if light == 0 then
				setVehicleOverrideLights( veh, 2 )
				setVehicleHeadLightColor (veh, 0, 0, 0)
				light = 1
			elseif light == 1 then
				setVehicleOverrideLights( veh, 2 )
				if getElementData (veh, "lights") ~= false then
				setVehicleHeadLightColor (veh, unpack(fromJSON(getElementData (veh, "lights"))))
				else
				setVehicleHeadLightColor (veh, 255, 255, 255)
				end
				light = 2
			elseif light == 2 then
				setVehicleOverrideLights( veh, 1 )
				light = 0
			end
		elseif sys == "lock" then
			setVehicleLocked(veh,not isVehicleLocked(veh))
		end
	end
end
addEvent("triggerVehicleSystem",true)
addEventHandler("triggerVehicleSystem",root,triggerVehicleSystem)

