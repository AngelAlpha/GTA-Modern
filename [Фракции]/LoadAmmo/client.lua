addEventHandler ("onClientRender", root, function()
for i, v in ipairs (getElementsByType ("marker")) do
	if getElementData (v, "LVAAmmo:VehMarker") then
		local barracks = getElementAttachedTo(v)
		dxDrawTextOnElement (v, "Загружено "..(getElementData (barracks, "LVAAmmo:Load") or 0).."/"..maxSlots, 1, 20, 0, 0, 255, 255, 2, "arial", true)
	end
end
end)

function JobGruzCallCheck(player, state)
    if state then
        setPedAnimation(player, "CARRY", "liftup", -1, false, true, false)
		setElementData (player, "load:job", true)
		setTimer(function () 
			setPedAnimation (player, "CARRY", "crry_prtial", 1, true, true, false)
			setElementData (player, "load:job", false)
			end, 1000, 1)
    else
        if getAttachedElements(player) then
            setPedAnimation(player, "CARRY", "putdwn", -1, false, true, false)
			setElementData (player, "load:job", true)
            setTimer(function () 
			setPedAnimation (player, false)
			setElementData (player, "load:job", false)
			end, 1800, 1)
        end
    end
end
addEvent("loadammo:CallCheck", true)
addEventHandler("loadammo:CallCheck", getRootElement(), JobGruzCallCheck)