local availableNeons = {
	["white"] = 5764,
	["blue"] = 5681,
	["green"] = 18448,
	["red"] = 18215,
	["yellow"] = 18214,
	["pink"] = 18213,
	["orange"] = 14399,
	["lightblue"] = 14400,
	["rasta"] = 14401,
	["ice"] = 14402
}

local vehicleNeon = {}
local neonCommandTimer

addEvent("tuning->Neon", true)

addEventHandler("onClientResourceStart", resourceRoot, function()
	for neonName, replaceModel in pairs(availableNeons) do
		local neonCOL = engineLoadCOL("files/neons/neonCollision.col")
		local neonDFF = engineLoadDFF("files/neons/" .. neonName .. ".dff")
		
		engineReplaceModel(neonDFF, replaceModel)
		engineReplaceCOL(neonCOL, replaceModel)
	end
	
	for _, vehicle in ipairs(getElementsByType("vehicle", root, true)) do
		if getElementData(vehicle, "tuning.neon") then
			if getElementData(vehicle, "vehicle.neon.active") then
				addNeon(vehicle, getElementData(vehicle, "tuning.neon"), true)
			end
		end
	end
end)

addCommandHandler("neon", function()
	if isTimer(neonCommandTimer) then
		return
	end
	
	neonCommandTimer = setTimer(function() end, 2000, 1)
	
	local vehicle = getPedOccupiedVehicle(localPlayer)
	
	if vehicle then
		if getVehicleOccupant(vehicle, 0) == localPlayer then
			local neonColor = getElementData(vehicle, "tuning.neon") or false
			
			if neonColor then
				local neonActive = getElementData(vehicle, "vehicle.neon.active") or false
				
				if not neonActive then
					triggerServerEvent("tuning->Neon", localPlayer, vehicle, neonColor)
					setElementData(vehicle, "vehicle.neon.active", true)
				else
					triggerServerEvent("tuning->Neon", localPlayer, vehicle, false)
					setElementData(vehicle, "vehicle.neon.active", false)
				end
			end
		end
	end
end)

addEventHandler("tuning->Neon", root, function(vehicle, neon)
	if isElementStreamedIn(vehicle) then
		if neon then
			addNeon(vehicle, neon, true)
		else
			if vehicleNeon[vehicle] then
				if vehicleNeon[vehicle]["object.1"] and vehicleNeon[vehicle]["object.2"] then
					destroyElement(vehicleNeon[vehicle]["object.1"])
					destroyElement(vehicleNeon[vehicle]["object.2"])
					vehicleNeon[vehicle] = nil
				end
			end
		end
	end
end)

addEventHandler("onClientElementStreamIn", root, function()
	if getElementType(source) == "vehicle" then
		if getElementData(source, "vehicle.neon.active") then
			local neonColor = getElementData(source, "tuning.neon") or false
			
			if neonColor then
				addNeon(source, neonColor, true)
			end
		end
	end
end)

addEventHandler("onClientElementStreamOut", root, function()
	if getElementType(source) == "vehicle" then
		if vehicleNeon[source] then
			if isElement(vehicleNeon[source]["object.1"]) then
				destroyElement(vehicleNeon[source]["object.1"])
			end
			
			if isElement(vehicleNeon[source]["object.2"]) then
				destroyElement(vehicleNeon[source]["object.2"])
			end
			
			vehicleNeon[source] = nil
		end
	end
end)

addEventHandler("onClientElementDestroy", root, function()
	if getElementType(source) == "vehicle" then
		if vehicleNeon[source] then
			if isElement(vehicleNeon[source]["object.1"]) then
				destroyElement(vehicleNeon[source]["object.1"])
			end
			
			if isElement(vehicleNeon[source]["object.2"]) then
				destroyElement(vehicleNeon[source]["object.2"])
			end
			
			vehicleNeon[source] = nil
		end
	end
end)

addEventHandler("onClientRender", root, function()
	for vehicle, neon in pairs(vehicleNeon) do
		if neon["object.1"] and neon["object.2"] then
			attachElements(neon["object.1"], vehicle, 0.8, 0, neon["object.zOffset"])
			attachElements(neon["object.2"], vehicle, -0.8, 0, neon["object.zOffset"])
		end
	end
end)

function addNeon(vehicle, neon, setDefault)
	if not vehicleNeon[vehicle] then
		vehicleNeon[vehicle] = {}
	end
	
	if setDefault then
		vehicleNeon[vehicle]["oldNeonID"] = availableNeons[neon]
	end

	vehicleNeon[vehicle]["neon"] = neon
	
	if vehicleNeon[vehicle]["object.1"] or vehicleNeon[vehicle]["object.2"] then
		if availableNeons[neon] then
			setElementModel(vehicleNeon[vehicle]["object.1"], availableNeons[neon])
			setElementModel(vehicleNeon[vehicle]["object.2"], availableNeons[neon])
		else
			destroyElement(vehicleNeon[vehicle]["object.1"])
			destroyElement(vehicleNeon[vehicle]["object.2"])
		end
	else
		local vehicleX, vehicleY, vehicleZ = getElementPosition(vehicle)

		vehicleNeon[vehicle]["object.1"] = createObject(availableNeons[neon], 0, 0, 0)
		vehicleNeon[vehicle]["object.2"] = createObject(availableNeons[neon], 0, 0, 0)
		
		setElementPosition(vehicleNeon[vehicle]["object.1"], vehicleX, vehicleY, vehicleZ)
		setElementPosition(vehicleNeon[vehicle]["object.2"], vehicleX, vehicleY, vehicleZ)
	end
	
	vehicleNeon[vehicle]["object.zOffset"] = -0.5
end

function removeNeon(vehicle, previewMode)
	if vehicleNeon[vehicle] then
		triggerServerEvent("tuning->Neon", localPlayer, vehicle, false)
	end
	
	if not previewMode then
		setElementData(vehicle, "tuning.neon", false)
		setElementData(vehicle, "vehicle.neon.active", false)
	end
end

function saveNeon(vehicle, neon)
	setElementData(vehicle, "tuning.neon", neon)
	setElementData(vehicle, "vehicle.neon.active", false)
	
	triggerServerEvent("tuning->Neon", localPlayer, vehicle, neon)
end

function restoreOldNeon(vehicle)
	if vehicle then
		local neonColor = getElementData(vehicle, "tuning.neon") or false
		local neonActivated = getElementData(vehicle, "vehicle.neon.active") or false
		
		if vehicleNeon[vehicle] then
			if vehicleNeon[vehicle]["object.1"] and vehicleNeon[vehicle]["object.2"] then
				local neonModel = availableNeons[vehicleNeon[vehicle]["oldNeonID"]]
				
				if neonModel then
					setElementModel(vehicleNeon[vehicle]["object.1"], neonModel)
					setElementModel(vehicleNeon[vehicle]["object.2"], neonModel)
				else
					destroyElement(vehicleNeon[vehicle]["object.1"])
					destroyElement(vehicleNeon[vehicle]["object.2"])
					vehicleNeon[vehicle] = nil
				end
			end
		end
		
		if neonColor then
			if neonActivated then
				triggerServerEvent("tuning->Neon", localPlayer, vehicle, neonColor)
			end
		end
	end
end