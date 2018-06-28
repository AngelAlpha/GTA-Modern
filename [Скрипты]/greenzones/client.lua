function onPDamage()
	if getElementData (source, "greenzone") then
		cancelEvent()
	end
end
addEventHandler ("onClientPlayerDamage", localPlayer, onPDamage)

function onPSKill(target)
	if getElementData (target, "greenzone") then
		cancelEvent()
	end
end
addEventHandler ("onClientPlayerStealthKill", localPlayer, onPSKill)