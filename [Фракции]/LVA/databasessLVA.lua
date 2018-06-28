
local Grovels1 = createPickup ( 237.42750549316,1872.4519042969,11.4609375, 3, 1318, 0.5 ) --создание пикапа 
local Grovels2 = createPickup ( 239.22750549316,1872.4519042969,11.4609375,3, 1318, 0.5 ) --создание пикапа в интерьере 
setElementInterior ( Grovels2, 0 ) --интерьер телепорт 
setElementDimension(Grovels2, 0)
function onPickupHitEnter ( hitElement )
if getPedOccupiedVehicle ( hitElement ) then
        return 
		end
	if getElementData (hitElement, "frac") == "LVA" then
    setElementPosition ( hitElement, 241.83938598633,1871.6993408203,11.4609375) --позиция в интерьере 
	setPedRotation ( hitElement, 0 ) 
	setElementInterior ( hitElement, 0 )--интерьер телепорт
    setElementDimension(hitElement, 0)	
	playSoundFrontEnd ( hitElement, 32 ) --звук стандарт при входе и выходе
	outputChatBox ( "Вы вошли в казарму Las Venturas Army", hitElement, 0, 200, 0 ) --текст при входе в интерьер 
    toggleControl ( hitElement, "fire", false ) 
	else
	outputChatBox ( "Вы не состоите в этой организации!", hitElement, 200, 0, 0 )
end
end
addEventHandler ( "onPickupHit", Grovels1, onPickupHitEnter )

function onPickupHitLeave ( hitElement )
    setElementPosition ( hitElement, 232.86103820801,1872.4519042969,11.4609375 ) --позиция на улице 
	setPedRotation ( hitElement, 270 )
	setElementInterior ( hitElement, 0 )
	setElementDimension(hitElement, 0)
	playSoundFrontEnd ( hitElement, 32 )
    toggleControl ( hitElement, "fire", true )
end
addEventHandler ( "onPickupHit", Grovels2, onPickupHitLeave )
