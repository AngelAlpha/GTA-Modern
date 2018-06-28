local nitroSettings = {	["currentLevel"] = 0,	["nitroActivated"] = false,	["percentagePerSecond"] = 5, -- bigger value: faster usage, lower value: slower usage	
						["lastTick"] = 0,	    ["enteredVehicle"] = false,	["oldVehicle"] = false,}
addEventHandler("onClientResourceStart", resourceRoot, function()	
bindKey("lshift", "down", function() nitroSettings["nitroActivated"] = true end)	
bindKey("lshift", "up", function() nitroSettings["nitroActivated"] = false end)		
if getPedOccupiedVehicle(localPlayer) then		
	local vehicle = getPedOccupiedVehicle(localPlayer)				
	if getVehicleOccupant(vehicle) == localPlayer then			
		nitroSettings["currentLevel"] = getElementData(vehicle, "tuning.nitroLevel") or 0	
		nitroSettings["enteredVehicle"] = vehicle end 
	end 
end)

addEventHandler("onClientResourceStop", resourceRoot, function()	
if getPedOccupiedVehicle(localPlayer) then		
	local vehicle = getPedOccupiedVehicle(localPlayer)				
	if getVehicleOccupant(vehicle) == localPlayer then			
		setElementData(vehicle, "tuning.nitroLevel", nitroSettings["currentLevel"])		
	end	
end
end)

addEventHandler("onClientVehicleEnter", root, function(player, seat)	
if player == localPlayer and seat == 0 then	
nitroSettings["currentLevel"] = getElementData(source, "tuning.nitroLevel") or 0
nitroSettings["enteredVehicle"] = source	
end
end)
addEventHandler("onClientVehicleStartExit", root, function(player)	
if player == localPlayer then		
nitroSettings["oldVehicle"] = nitroSettings["enteredVehicle"]				
if nitroSettings["oldVehicle"] == nitroSettings["enteredVehicle"] then			
setElementData(source, "tuning.nitroLevel", nitroSettings["currentLevel"])			
nitroSettings["currentLevel"] = 0			nitroSettings["enteredVehicle"] = false		
end	
end
end)

addEventHandler("onClientRender", root, function()	
if isElement(nitroSettings["enteredVehicle"]) then		
if getVehicleUpgradeOnSlot(nitroSettings["enteredVehicle"], 8) == 1010 then			
local currentTick = getTickCount()			
local elapsedTime = currentTick - nitroSettings["lastTick"]						
nitroSettings["lastTick"] = currentTick			
if nitroSettings["nitroActivated"] then				
if nitroSettings["currentLevel"] > 0 then					
setVehicleNitroLevel(nitroSettings["enteredVehicle"], 1)					
setVehicleNitroActivated(nitroSettings["enteredVehicle"], true)										
nitroSettings["currentLevel"] = nitroSettings["currentLevel"] - ((elapsedTime / 1000) * nitroSettings["percentagePerSecond"])				
else					
setVehicleNitroActivated(nitroSettings["enteredVehicle"], false)				
end			
else				
setVehicleNitroActivated(nitroSettings["enteredVehicle"], false)			
end		
end	
end
end)

function refreshVehicleNitroLevel(vehicle, nitroLevel)	
if vehicle and nitroLevel then		
nitroSettings["currentLevel"] = nitroLevel		
nitroSettings["enteredVehicle"] = vehicle	
end
end