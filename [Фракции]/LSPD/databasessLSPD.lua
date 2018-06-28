function servetime ()
  servertime = getRealTime ()
  hours = servertime.hour
  minutes = string.format("%02d", servertime.minute)
  second = string.format("%02d", servertime.second)
end
setTimer (servetime, 1000, 0)

LSPDblip = createBlip (1555.0294189453,-1675.6441650391,30,30)
local Grovels1 = createPickup ( 1555.0294189453,-1675.6441650391,16.1953125, 3, 1318, 1 ) --с улицу централка
local Grovels2 = createPickup ( 242.24963378906,66.331809997559,1003.640625,3, 1318, 1 ) --с отдела на крышу
local Grovels3 = createPickup ( 246.73748779297,62.641819000244,1003.640625,3, 1318, 1 ) -- на улицу централка
local Grovels4 = createPickup ( 246.40419006348,88.009063720703,1003.640625,3, 1318, 1 ) -- в гараж
local Grovels5 = createPickup ( 1564.9627685547,-1666.6695556641,28.395606994629,3, 1318, 1 ) -- с крыши в отдел
local Grovels6 = createPickup ( 1524.5151367188,-1677.8375244141,6.295606994629,3, 1318, 1 ) -- с гаража в отдел
setElementInterior ( Grovels2, 6 ) --интерьер телепорт 
setElementDimension(Grovels2, 1)
setElementInterior ( Grovels3, 6 ) --интерьер телепорт 
setElementDimension(Grovels3, 1)
setElementInterior ( Grovels4, 6 ) --интерьер телепорт 
setElementDimension(Grovels4, 1)
function onPickupHitEnter ( hitElement )
if getPedOccupiedVehicle ( hitElement ) then
        return 
		end
    setElementPosition ( hitElement, 246.38911437988,65.810501098633,1003.640625) --позиция в интерьере 
	setPedRotation ( hitElement, 0 ) 
	setElementInterior ( hitElement, 6 )--интерьер телепорт
    setElementDimension(hitElement, 1)	
	playSoundFrontEnd ( hitElement, 32 ) --звук стандарт при входе и выходе
	outputChatBox ( "Вы вошли в отделение Los Santos Police Department", hitElement, 0, 200, 0 ) --текст при входе в интерьер 
    toggleControl ( hitElement, "fire", false ) 
end
addEventHandler ( "onPickupHit", Grovels1, onPickupHitEnter )

function onPickupHitLeave ( hitElement )
if getTeamName (getPlayerTeam ( hitElement )) == "Los Santos Police Department" then
    setElementPosition ( hitElement, 1564.2432861328,-1663.4809570313,28.346875 ) --позиция на улице 
	setPedRotation ( hitElement, 270 )
	setElementInterior ( hitElement, 0 )
	setElementDimension(hitElement, 0)
	playSoundFrontEnd ( hitElement, 32 )
    toggleControl ( hitElement, "fire", true )
	end
end
addEventHandler ( "onPickupHit", Grovels2, onPickupHitLeave )

function onPickupHitEnter1 ( hitElement )
if getPedOccupiedVehicle ( hitElement ) then
        return 
		end
    setElementPosition ( hitElement, 246.38911437988,65.810501098633,1003.640625) --позиция в интерьере 
	setPedRotation ( hitElement, 0 ) 
	setElementInterior ( hitElement, 6 )--интерьер телепорт
    setElementDimension(hitElement, 1)	
	playSoundFrontEnd ( hitElement, 32 ) --звук стандарт при входе и выходе
	outputChatBox ( "Вы вошли в отделение Los Santos Police Department", hitElement, 0, 200, 0 ) --текст при входе в интерьер 
    toggleControl ( hitElement, "fire", false ) 
end
addEventHandler ( "onPickupHit", Grovels5, onPickupHitEnter1 )

function onPickupHitLeave1 ( hitElement )
    setElementPosition ( hitElement, 1552.4583740234,-1675.7065429688,16.195606994629 ) --позиция на улице 
	setPedRotation ( hitElement, 270 )
	setElementInterior ( hitElement, 0 )
	setElementDimension(hitElement, 0)
	playSoundFrontEnd ( hitElement, 32 )
    toggleControl ( hitElement, "fire", true )
end
addEventHandler ( "onPickupHit", Grovels3, onPickupHitLeave1 )

function onPickupHitEnter2 ( hitElement )
if getPedOccupiedVehicle ( hitElement ) then
        return 
		end
    setElementPosition ( hitElement, 246.95433044434,86.500900268555,1003.640625) --позиция в интерьере 
	setPedRotation ( hitElement, 0 ) 
	setElementInterior ( hitElement, 6 )--интерьер телепорт
    setElementDimension(hitElement, 1)	
	playSoundFrontEnd ( hitElement, 32 ) --звук стандарт при входе и выходе
	outputChatBox ( "Вы вошли в отделение Los Santos Police Department", hitElement, 0, 200, 0 ) --текст при входе в интерьер 
    toggleControl ( hitElement, "fire", false ) 
end
addEventHandler ( "onPickupHit", Grovels6, onPickupHitEnter2)

function onPickupHitLeave2 ( hitElement )
    setElementPosition ( hitElement, 1527.9426269531,-1678.3474121094,6.246875 ) --позиция на улице 
	setPedRotation ( hitElement, 90 )
	setElementInterior ( hitElement, 0 )
	setElementDimension(hitElement, 0)
	playSoundFrontEnd ( hitElement, 32 )
    toggleControl ( hitElement, "fire", true )
end
addEventHandler ( "onPickupHit", Grovels4, onPickupHitLeave2 )




------------




markerls2 = createPickup ( 218.01466369629,69.9536132813,1005.084012031555, 2, 2079, 1 )
setElementInterior ( markerls2, 6 )
setElementDimension ( markerls2, 1 )
function login1 ( hitElement, matchingDimension )
if getElementData(hitElement, "Должность") == "Кадет" then
  giveWeapon ( hitElement, 3,1 )
  elseif getElementData(hitElement, "Должность") == "Офицер Полиции" then
  giveWeapon ( hitElement, 3,1 )
  giveWeapon ( hitElement, 23,17 )
  setPedArmor(hitElement,100)
  elseif getElementData(hitElement, "Должность") == "Детектив" then
  giveWeapon ( hitElement, 3,1 )
  giveWeapon ( hitElement, 23,17 )
  setPedArmor(hitElement,100)
  elseif getElementData(hitElement, "Должность") == "Младший Сержант Полиции" then
  giveWeapon ( hitElement, 3,1 )
  giveWeapon ( hitElement, 23,17 )
  setPedArmor(hitElement,100)
  elseif getElementData(hitElement, "Должность") == "Сержант Полиции" then
  giveWeapon ( hitElement, 3,1 )
  giveWeapon ( hitElement, 23,17 )
  setPedArmor(hitElement,100)
  elseif getElementData(hitElement, "Должность") == "Старший Сержант Полиции" then
  giveWeapon ( hitElement, 3,1 )
  giveWeapon ( hitElement, 23,17 )
  giveWeapon ( hitElement, 29,30 )
  setPedArmor(hitElement,100)
  elseif getElementData(hitElement, "Должность") == "Лейтенант Полиции" then
  giveWeapon ( hitElement, 3,1 )
  giveWeapon ( hitElement, 23,17 )
  giveWeapon ( hitElement, 29,30 )
  giveWeapon ( hitElement, 27,10 )
  setPedArmor(hitElement,100)
  elseif getElementData(hitElement, "Должность") == "Капитан Полиции" then
  giveWeapon ( hitElement, 3,1 )
  giveWeapon ( hitElement, 23,17 )
  giveWeapon ( hitElement, 29,30 )
  giveWeapon ( hitElement, 27,10 )
  setPedArmor(hitElement,100)
  elseif getElementData(hitElement, "Должность") == "Инспектор" then
  giveWeapon ( hitElement, 3,1 )
  giveWeapon ( hitElement, 23,17 )
  giveWeapon ( hitElement, 29,30 )
  giveWeapon ( hitElement, 27,10 )
  giveWeapon ( hitElement, 31,50 )
  setPedArmor(hitElement,100)
  elseif getElementData(hitElement, "Должность") == "Майор Полиции" then
  giveWeapon ( hitElement, 3,1 )
  giveWeapon ( hitElement, 23,17 )
  giveWeapon ( hitElement, 29,30 )
  giveWeapon ( hitElement, 27,10 )
  giveWeapon ( hitElement, 31,50 )
  setPedArmor(hitElement,100)
  elseif getElementData(hitElement, "Должность") == "Комиссар Полиции" then
  giveWeapon ( hitElement, 3,1 )
  giveWeapon ( hitElement, 23,17 )
  giveWeapon ( hitElement, 29,30 )
  giveWeapon ( hitElement, 27,10 )
  giveWeapon ( hitElement, 31,50 )
  setPedArmor(hitElement,100)
  elseif getElementData(hitElement, "Должность") == "Шеф Полиции" then
  giveWeapon ( hitElement, 3,1 )
  giveWeapon ( hitElement, 23,17 )
  giveWeapon ( hitElement, 29,30 )
  giveWeapon ( hitElement, 27,10 )
  giveWeapon ( hitElement, 31,50 )
  setPedArmor(hitElement,100)
  elseif getElementData(hitElement, "Должность") == "Помощник Полиции" then
  giveWeapon ( hitElement, 3,1 )
  giveWeapon ( hitElement, 23,17 )
  giveWeapon ( hitElement, 29,30 )
  giveWeapon ( hitElement, 27,10 )
  giveWeapon ( hitElement, 31,50 )
  giveWeapon ( hitElement, 34,10 )
  setPedArmor(hitElement,100)
  elseif getElementData(hitElement, "Должность") == "Шериф" then
  giveWeapon ( hitElement, 3,1 )
  giveWeapon ( hitElement, 23,17 )
  giveWeapon ( hitElement, 29,30 )
  giveWeapon ( hitElement, 27,10 )
  giveWeapon ( hitElement, 31,50 )
  giveWeapon ( hitElement, 34,10 )
  setPedArmor(hitElement,100)
else
outputChatBox  ( "Вы не состоите в этой организации!", hitElement, 255, 100 ,100)
end
end
addEventHandler ( "onPickupHit", markerls2, login1 )
