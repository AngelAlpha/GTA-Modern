function servetime ()
  servertime = getRealTime ()
  hours = servertime.hour
  minutes = string.format("%02d", servertime.minute)
  second = string.format("%02d", servertime.second)
end
setTimer (servetime, 1000, 0)

markerls2 = createPickup ( 240.01466369629,1858.9536132813,14.084012031555, 2, 2078, 1 )
setElementInterior ( markerls2, 0 )
setElementDimension ( markerls2, 0 )
function login1 ( hitElement, matchingDimension )
if getElementData(hitElement, "Должность") == "Рядовой" then
  giveWeapon ( hitElement, 24,35 )
  giveWeapon ( hitElement, 30,90 )
  elseif getElementData(hitElement, "Должность") == "Ефрейтор" then
  giveWeapon ( hitElement, 24,35 )
  giveWeapon ( hitElement, 30,90 )
  elseif getElementData(hitElement, "Должность") == "Младший Сержант" then
  giveWeapon ( hitElement, 24,35 )
  giveWeapon ( hitElement, 30,90 )
  setPedArmor(hitElement,100)
  elseif getElementData(hitElement, "Должность") == "Сержант" then
  giveWeapon ( hitElement, 24,35 )
  giveWeapon ( hitElement, 30,90 )
  setPedArmor(hitElement,100)
  elseif getElementData(hitElement, "Должность") == "Старший Сержант" then
  giveWeapon ( hitElement, 24,35 )
  giveWeapon ( hitElement, 31,100 )
  setPedArmor(hitElement,100)
  elseif getElementData(hitElement, "Должность") == "Старшина" then
  giveWeapon ( hitElement, 24,35 )
  giveWeapon ( hitElement, 31,100 )
  setPedArmor(hitElement,100)
  elseif getElementData(hitElement, "Должность") == "Прапорщик" then
  giveWeapon ( hitElement, 24,35 )
  giveWeapon ( hitElement, 31,100 )
  setPedArmor(hitElement,100)
  elseif getElementData(hitElement, "Должность") == "Младший Лейтенант" then
  giveWeapon ( hitElement, 24,35 )
  giveWeapon ( hitElement, 31,100 )
  setPedArmor(hitElement,100)
  elseif getElementData(hitElement, "Должность") == "Лейтенант" then
  giveWeapon ( hitElement, 24,35 )
  giveWeapon ( hitElement, 34,10 )
  giveWeapon ( hitElement, 31,100 )
  setPedArmor(hitElement,100)
  elseif getElementData(hitElement, "Должность") == "Старший Лейтенант" then
  giveWeapon ( hitElement, 31,100 )
  giveWeapon ( hitElement, 24,35 )
  setPedArmor(hitElement,100)
  elseif getElementData(hitElement, "Должность") == "Капитан" then
  giveWeapon ( hitElement, 31,100 )
  giveWeapon ( hitElement, 24,35 )
  giveWeapon ( hitElement, 34,10 )
  setPedArmor(hitElement,100)
  elseif getElementData(hitElement, "Должность") == "Майор" then
  giveWeapon ( hitElement, 31,100 )
  giveWeapon ( hitElement, 24,35 )
  giveWeapon ( hitElement, 34,10 )
  setPedArmor(hitElement,100)
  elseif getElementData(hitElement, "Должность") == "Подполковник" then
  giveWeapon ( hitElement, 31,100 )
  giveWeapon ( hitElement, 24,35 )
  giveWeapon ( hitElement, 34,10 )
  setPedArmor(hitElement,100)
  elseif getElementData(hitElement, "Должность") == "Полковник" then
  giveWeapon ( hitElement, 31,100 )
  giveWeapon ( hitElement, 24,35 )
  giveWeapon ( hitElement, 34,10 )
  setPedArmor(hitElement,100)
  elseif getElementData(hitElement, "Должность") == "Генерал" then
  giveWeapon ( hitElement, 31,100 )
  giveWeapon ( hitElement, 24,35 )
  giveWeapon ( hitElement, 34,10 )
  setPedArmor(hitElement,100)
else
outputChatBox  ( "Вы не состоите в этой организации!", hitElement, 255, 100 ,100)
end
end
addEventHandler ( "onPickupHit", markerls2, login1 )