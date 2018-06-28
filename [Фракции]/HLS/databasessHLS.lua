function servetime ()
  servertime = getRealTime ()
  hours = servertime.hour
  minutes = string.format("%02d", servertime.minute)
  second = string.format("%02d", servertime.second)
end
setTimer (servetime, 1000, 0)

HLSblip = createBlip (1173.0255126953, -1323.3587646484, 15.397415161133,22)
local Grovels1 = createPickup ( 1173.0255126953, -1323.3587646484, 15.397415161133, 3, 1318, 1 ) --с улицы в ХЛС
local Grovels2 = createPickup ( 1150.1599121094,-1362.1813964844,1559.2355957031,3, 1318, 1 ) --с Хлс на улицу
local Grovels3 = createPickup ( 1174.2789306641,-1359.9205322266,1559.2355957031,3, 1318, 1 ) -- в ординаторскую
local Grovels4 = createPickup ( 1176.0150146484,-1359.9509277344,1559.2355957031,3, 1318, 1 ) -- с ординаторской в ХЛС
local Grovels5 = createPickup ( 1172.2174072266,-1329.4204101563,1559.2277832031,3, 1318, 1 ) -- в операционную
local Grovels6 = createPickup ( 1172.2174072266,-1326.4204101563,1559.2277832031,3, 1318, 1 ) -- с операционной в ХЛС
setElementInterior ( Grovels2, 0 ) --интерьер телепорт 
setElementDimension(Grovels2, 1)
setElementInterior ( Grovels3, 0 ) --интерьер телепорт 
setElementDimension(Grovels3, 1)
setElementInterior ( Grovels4, 0 ) --интерьер телепорт 
setElementDimension(Grovels4, 1)
setElementInterior ( Grovels5, 0 ) --интерьер телепорт 
setElementDimension(Grovels5, 1)
setElementInterior ( Grovels6, 0 ) --интерьер телепорт 
setElementDimension(Grovels6, 1)
function onPickupHitEnter ( hitElement )
if getPedOccupiedVehicle ( hitElement ) then
        return 
		end
    setElementPosition ( hitElement, 1154.3640136719,-1360.5997314453,1559.2355957031) --позиция в интерьере 
	setPedRotation ( hitElement, 180 ) 
	setElementInterior ( hitElement, 0 )--интерьер телепорт
    setElementDimension(hitElement, 1)	
	playSoundFrontEnd ( hitElement, 32 ) --звук стандарт при входе и выходе
	outputChatBox ( "Вы вошли в отделение Hospital Los Santos", hitElement, 0, 200, 0 ) --текст при входе в интерьер 
    toggleControl ( hitElement, "fire", false ) 
end
addEventHandler ( "onPickupHit", Grovels1, onPickupHitEnter )

function onPickupHitLeave ( hitElement )
if getAccountData( getPlayerAccount( hitElement ), "Job.Pereodevalka" ) then
local Data2 = fromJSON( getAccountData( getPlayerAccount( hitElement ), "Job.Pereodevalka" ) );
end
if not Data2 or Data2.bState == false then	
    setElementPosition ( hitElement, 1183.9071044922,-1324.2133789063,13.575923919678 ) --позиция на улице 
	setPedRotation ( hitElement, 90 )
	setElementInterior ( hitElement, 0 )
	setElementDimension(hitElement, 0)
	playSoundFrontEnd ( hitElement, 32 )
    toggleControl ( hitElement, "fire", true )
	else
outputChatBox("Вас никуда не выпустят в этой одежде!",hitElement,255,100,100)
end
end
addEventHandler ( "onPickupHit", Grovels2, onPickupHitLeave )

function onPickupHitEnter1 ( hitElement )
if getElementData (hitElement, "frac") == "HLS" or (getElementData(hitElement, "PropuskOper") or 0) >= 1 then
if getPedOccupiedVehicle ( hitElement ) then
        return 
		end
    setElementPosition ( hitElement, 1172.2158203125,-1324.1627197266,1559.2355957031) --позиция в интерьере 
	setPedRotation ( hitElement, 0 ) 
	setElementInterior ( hitElement, 0 )--интерьер телепорт
    setElementDimension(hitElement, 1)	
	playSoundFrontEnd ( hitElement, 32 ) --звук стандарт при входе и выходе
    toggleControl ( hitElement, "fire", false ) 
				else
		outputChatBox("Вам запрещено заходить в этот кабинет!",hitElement,255,100,100)
		end
end
addEventHandler ( "onPickupHit", Grovels5, onPickupHitEnter1 )

function onPickupHitLeave1 ( hitElement )
if getElementData (hitElement, "frac") == "HLS" then
    setElementPosition ( hitElement, 1179.1923828125,-1359.0897216797,1559.2355957031 ) --позиция на улице 
	setPedRotation ( hitElement, 270 )
	setElementInterior ( hitElement, 0 )
	setElementDimension(hitElement, 1)
	playSoundFrontEnd ( hitElement, 32 )
    toggleControl ( hitElement, "fire", true )
				else
		outputChatBox("Вам запрещено заходить в этот кабинет!",hitElement,255,100,100)
		end
end
addEventHandler ( "onPickupHit", Grovels3, onPickupHitLeave1 )

function onPickupHitEnter2 ( hitElement )
if getPedOccupiedVehicle ( hitElement ) then
        return 
		end
    setElementPosition ( hitElement, 1170.2309570313,-1331.7896728516,1559.2355957031) --позиция в интерьере 
	setPedRotation ( hitElement, 0 ) 
	setElementInterior ( hitElement, 0 )--интерьер телепорт
    setElementDimension(hitElement, 1)	
	playSoundFrontEnd ( hitElement, 32 ) --звук стандарт при входе и выходе 
    toggleControl ( hitElement, "fire", false ) 
end
addEventHandler ( "onPickupHit", Grovels6, onPickupHitEnter2)

function onPickupHitLeave2 ( hitElement )
if getElementData (hitElement, "frac") == "HLS" then
    setElementPosition ( hitElement, 1170.6081542969,-1359.8731689453,1559.2355957031 ) --позиция на улице 
	setPedRotation ( hitElement, 90 )
	setElementInterior ( hitElement, 0 )
	setElementDimension(hitElement, 1)
	playSoundFrontEnd ( hitElement, 32 )
    toggleControl ( hitElement, "fire", true )
	end
end
addEventHandler ( "onPickupHit", Grovels4, onPickupHitLeave2 )
