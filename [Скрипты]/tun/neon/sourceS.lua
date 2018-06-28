addEvent("tuning->Neon", true)
addEventHandler("tuning->Neon", root, function(vehicle, neon)
	if vehicle then
		triggerClientEvent(root, "tuning->Neon", root, vehicle, neon)
	end
end)