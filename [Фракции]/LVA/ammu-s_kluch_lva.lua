function servetime ()
  servertime = getRealTime ()
  hours = servertime.hour
  minutes = string.format("%02d", servertime.minute)
  second = string.format("%02d", servertime.second)
end
setTimer (servetime, 1000, 0)

function addmarker1s ( res )
    	marker1 = createMarker (203.89266967773,1872.8107910156, 12, "cylinder", 1.5, 255, 255, 0, 170 )
    	addEventHandler( "onMarkerHit", marker1, showAmmoGUI )
    	--setElementDimension(marker1, 1)
		--setElementInterior(marker1,5)
		setElementData(marker1, "KluchLVA001", true)
		setElementData(marker1, "KluchLVA002", true)
		setElementData(marker1, "KluchLVA003", true)
		setElementData(marker1, "KluchLVA004", true)
		setElementData(marker1, "KluchLVA005", true)
		setElementData(marker1, "KluchLVA006", true)
		setElementData(marker1, "KluchLVA007", true)
		setElementData(marker1, "KluchLVA008", true)
		setElementData(marker1, "KluchLVA009", true)
		setElementData(marker1, "KluchLVA0010", true)
		setElementData(marker1, "KluchLVA0011", true)
		setElementData(marker1, "KluchLVA0012", true)
		setElementData(marker1, "KluchLVA0013", true)
		setElementData(marker1, "KluchLVA0014", true)
    end
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), addmarker1s )

function showAmmoGUI( hitPlayer, matchingDimension )
		if source == marker1 and getElementData (hitPlayer, "frac") == "LVA" then
		if (getElementData(hitPlayer, "KluchLVA001") == true) then
		setElementData(marker1, "KluchLVA001", true)
		triggerClientEvent( hitPlayer, "UbratyAutoLVA001", getRootElement(), hitPlayer, marker1, 1 )
		outputChatBox("Вы положили ключи от Barracks на склад",hitPlayer)
		setElementData(hitPlayer, "KluchLVA001", false)
		elseif (getElementData(hitPlayer, "KluchLVA002") == true) then
		setElementData(marker1, "KluchLVA002", true)
		outputChatBox("Вы положили ключи от Barracks на склад",hitPlayer)
		setElementData(hitPlayer, "KluchLVA002", false)
		triggerClientEvent( hitPlayer, "UbratyAutoLVA002", getRootElement(), hitPlayer, marker1, 2 )
		elseif (getElementData(hitPlayer, "KluchLVA003") == true) then
		setElementData(marker1, "KluchLVA003", true)
		setElementData(hitPlayer, "KluchLVA003", false)
		outputChatBox("Вы положили ключи от Barracks на склад",hitPlayer)
		triggerClientEvent( hitPlayer, "UbratyAutoLVA003", getRootElement(), hitPlayer, marker1, 3 )
		elseif (getElementData(hitPlayer, "KluchLVA004") == true) then
		setElementData(marker1, "KluchLVA004", true)
		setElementData(hitPlayer, "KluchLVA004", false)
		outputChatBox("Вы положили ключи от Barracks на склад",hitPlayer)
		triggerClientEvent( hitPlayer, "UbratyAutoLVA004", getRootElement(), hitPlayer, marker1, 4 )
		elseif (getElementData(hitPlayer, "KluchLVA005") == true) then
		setElementData(marker1, "KluchLVA005", true)
		setElementData(hitPlayer, "KluchLVA005", false)
		outputChatBox("Вы положили ключи от Rhino на склад",hitPlayer)
		triggerClientEvent( hitPlayer, "UbratyAutoLVA005", getRootElement(), hitPlayer, marker1, 5 )
		elseif (getElementData(hitPlayer, "KluchLVA006") == true) then
		setElementData(marker1, "KluchLVA006", true)
		setElementData(hitPlayer, "KluchLVA006", false)
		outputChatBox("Вы положили ключи от Rhino на склад",hitPlayer)
		triggerClientEvent( hitPlayer, "UbratyAutoLVA006", getRootElement(), hitPlayer, marker1, 6 )
		elseif (getElementData(hitPlayer, "KluchLVA007") == true) then
		setElementData(marker1, "KluchLVA007", true)
		setElementData(hitPlayer, "KluchLVA007", false)
		outputChatBox("Вы положили ключи от Patriot на склад",hitPlayer)
		triggerClientEvent( hitPlayer, "UbratyAutoLVA007", getRootElement(), hitPlayer, marker1, 7 )
		elseif (getElementData(hitPlayer, "KluchLVA008") == true) then
		setElementData(marker1, "KluchLVA008", true)
		setElementData(hitPlayer, "KluchLVA008", false)
		outputChatBox("Вы положили ключи от Patriot на склад",hitPlayer)
		triggerClientEvent( hitPlayer, "UbratyAutoLVA008", getRootElement(), hitPlayer, marker1, 8 )
		elseif (getElementData(hitPlayer, "KluchLVA009") == true) then
		setElementData(marker1, "KluchLVA009", true)
		setElementData(hitPlayer, "KluchLVA009", false)
		outputChatBox("Вы положили ключи от Patriot на склад",hitPlayer)
		triggerClientEvent( hitPlayer, "UbratyAutoLVA009", getRootElement(), hitPlayer, marker1, 9 )
		elseif (getElementData(hitPlayer, "KluchLVA0010") == true) then
		setElementData(marker1, "KluchLVA0010", true)
		setElementData(hitPlayer, "KluchLVA0010", false)
		outputChatBox("Вы положили ключи от Patriot на склад",hitPlayer)
		triggerClientEvent( hitPlayer, "UbratyAutoLVA0010", getRootElement(), hitPlayer, marker1, 10 )
		elseif (getElementData(hitPlayer, "KluchLVA0011") == true) then
		setElementData(marker1, "KluchLVA0011", true)
		setElementData(hitPlayer, "KluchLVA0011", false)
		outputChatBox("Вы положили ключи от Mesa на склад",hitPlayer)
		triggerClientEvent( hitPlayer, "UbratyAutoLVA0011", getRootElement(), hitPlayer, marker1, 11 )
		elseif (getElementData(hitPlayer, "KluchLVA0012") == true) then
		setElementData(marker1, "KluchLVA0012", true)
		setElementData(hitPlayer, "KluchLVA0012", false)
		outputChatBox("Вы положили ключи от Mesa на склад",hitPlayer)
		triggerClientEvent( hitPlayer, "UbratyAutoLVA0012", getRootElement(), hitPlayer, marker1, 12 )
		elseif (getElementData(hitPlayer, "KluchLVA0013") == true) then
		setElementData(marker1, "KluchLVA0013", true)
		setElementData(hitPlayer, "KluchLVA0013", false)
		outputChatBox("Вы положили ключи от Maverick на склад",hitPlayer)
		triggerClientEvent( hitPlayer, "UbratyAutoLVA0013", getRootElement(), hitPlayer, marker1, 13 )
		elseif (getElementData(hitPlayer, "KluchLVA0014") == true) then
		setElementData(marker1, "KluchLVA0014", true)
		setElementData(hitPlayer, "KluchLVA0014", false)
		outputChatBox("Вы положили ключи от Maverick на склад",hitPlayer)
		triggerClientEvent( hitPlayer, "UbratyAutoLVA0014", getRootElement(), hitPlayer, marker1, 14 )
		else
		triggerClientEvent( hitPlayer, "showAmmoLVAKluch", getRootElement(), hitPlayer, marker1 )
		end
		else
		outputChatBox("Вам запрещено брать от сюда ключи",hitPlayer,200,0,0)
end
end

addEventHandler ("onPlayerQuit", root, function()
if getPlayerKluch (source) then
	respawn (source, getElementData (getVehFromKluch (getPlayerKluch(source)), "LVA"))
	setElementData (marker1, getPlayerKluch (source), true)
	removeElementData (source, getPlayerKluch (source))
end
end)

function buyHamburger0 ( money, gunID, ammu )
if   getElementData(marker1, "KluchLVA001") == true then
 if   getElementData(client, "Должность") == "Младший Сержант" 
 or getElementData(client, "Должность") == "Сержант" 
 or getElementData(client, "Должность") == "Старший Сержант" 
 or getElementData(client, "Должность") == "Старшина" 
 or getElementData(client, "Должность") == "Прапорщик" 
 or getElementData(client, "Должность") == "Младший Лейтенант" 
 or getElementData(client, "Должность") == "Лейтенант" 
 or getElementData(client, "Должность") == "Старший Лейтенант" 
 or getElementData(client, "Должность") == "Капитан" 
 or getElementData(client, "Должность") == "Майор" 
 or getElementData(client, "Должность") == "Подполковник" 
 or getElementData(client, "Должность") == "Полковник" 
 or getElementData(client, "Должность") == "Генерал" then
 if   getElementData(client, "KluchLVA001") == false then
 setElementData(client, "KluchLVA001", true)
 setElementData(marker1, "KluchLVA001", false)
   outputChatBox ("Вы взяли ключи от Barracks с номером LVA001", client)
 else
  outputChatBox ("У вас есть этот ключ", client)
 end
 else
 outputChatBox ("Вам не разрешено пользоваться этим автомобилем", client)
 end
 else
 outputChatBox ("На складе отсутствует этот ключ", client)
 end
end
addEvent("VzyatKluchLVA001",true)
addEventHandler("VzyatKluchLVA001",getRootElement(),buyHamburger0)

function buyHamburger ( money, gunID, ammu )
if   getElementData(marker1, "KluchLVA002") == true then
 if   getElementData(client, "Должность") == "Младший Сержант" 
 or getElementData(client, "Должность") == "Сержант" 
 or getElementData(client, "Должность") == "Старший Сержант" 
 or getElementData(client, "Должность") == "Старшина" 
 or getElementData(client, "Должность") == "Прапорщик" 
 or getElementData(client, "Должность") == "Младший Лейтенант" 
 or getElementData(client, "Должность") == "Лейтенант" 
 or getElementData(client, "Должность") == "Старший Лейтенант" 
 or getElementData(client, "Должность") == "Капитан" 
 or getElementData(client, "Должность") == "Майор" 
 or getElementData(client, "Должность") == "Подполковник" 
 or getElementData(client, "Должность") == "Полковник" 
 or getElementData(client, "Должность") == "Генерал" then
 if   getElementData(client, "KluchLVA002") == false then
 setElementData(client, "KluchLVA002", true)
   outputChatBox ("Вы взяли ключи от Barracks с номером LVA002", client)
   setElementData(marker1, "KluchLVA002", false)
 else
  outputChatBox ("У вас есть этот ключ", client)
 end
 else
 outputChatBox ("Вам не разрешено пользоваться этим автомобилем", client)
 end
  else
 outputChatBox ("На складе отсутствует этот ключ", client)
 end
end
addEvent("VzyatKluchLVA002",true)
addEventHandler("VzyatKluchLVA002",getRootElement(),buyHamburger)

function buyHamburger1 ( money, gunID, ammu )
if   getElementData(marker1, "KluchLVA003") == true then
 if getElementData (client, "frac") == "LVA" then
 if   getElementData(client, "Должность") == "Младший Сержант" 
 or getElementData(client, "Должность") == "Сержант" 
 or getElementData(client, "Должность") == "Старший Сержант" 
 or getElementData(client, "Должность") == "Старшина" 
 or getElementData(client, "Должность") == "Прапорщик" 
 or getElementData(client, "Должность") == "Младший Лейтенант" 
 or getElementData(client, "Должность") == "Лейтенант" 
 or getElementData(client, "Должность") == "Старший Лейтенант" 
 or getElementData(client, "Должность") == "Капитан" 
 or getElementData(client, "Должность") == "Майор" 
 or getElementData(client, "Должность") == "Подполковник" 
 or getElementData(client, "Должность") == "Полковник" 
 or getElementData(client, "Должность") == "Генерал" then
 if   getElementData(client, "KluchLVA003") == false then
 setElementData(client, "KluchLVA003", true)
   outputChatBox ("Вы взяли ключи от Barracks с номером LVA003", client)
   setElementData(marker1, "KluchLVA003", false)
 else
  outputChatBox ("У вас есть этот ключ", client)
 end
  else
 outputChatBox ("Вам не разрешено пользоваться этим автомобилем", client)
 end
 else
 outputChatBox ("Вам не разрешено пользоваться этим автомобилем", client)
 end
  else
 outputChatBox ("На складе отсутствует этот ключ", client)
 end
end
addEvent("VzyatKluchLVA003",true)
addEventHandler("VzyatKluchLVA003",getRootElement(),buyHamburger1)

function buyHamburger2 ( money, gunID, ammu )
if   getElementData(marker1, "KluchLVA004") == true then
 if getElementData (client, "frac") == "LVA" then
 if   getElementData(client, "Должность") == "Младший Сержант" 
 or getElementData(client, "Должность") == "Сержант" 
 or getElementData(client, "Должность") == "Старший Сержант" 
 or getElementData(client, "Должность") == "Старшина" 
 or getElementData(client, "Должность") == "Прапорщик" 
 or getElementData(client, "Должность") == "Младший Лейтенант" 
 or getElementData(client, "Должность") == "Лейтенант" 
 or getElementData(client, "Должность") == "Старший Лейтенант" 
 or getElementData(client, "Должность") == "Капитан" 
 or getElementData(client, "Должность") == "Майор" 
 or getElementData(client, "Должность") == "Подполковник" 
 or getElementData(client, "Должность") == "Полковник" 
 or getElementData(client, "Должность") == "Генерал" then
 if   getElementData(client, "KluchLVA004") == false then
 setElementData(client, "KluchLVA004", true)
   outputChatBox ("Вы взяли ключи от Barracks с номером LVA004", client)
   setElementData(marker1, "KluchLVA004", false)
 else
  outputChatBox ("У вас есть этот ключ", client)
 end
  else
 outputChatBox ("Вам не разрешено пользоваться этим автомобилем", client)
 end
 else
 outputChatBox ("Вам не разрешено пользоваться этим автомобилем", client)
 end
  else
 outputChatBox ("На складе отсутствует этот ключ", client)
 end
end
addEvent("VzyatKluchLVA004",true)
addEventHandler("VzyatKluchLVA004",getRootElement(),buyHamburger2)

function buyHamburger3 ( money, gunID, ammu )
if   getElementData(marker1, "KluchLVA005") == true then
 if getElementData (client, "frac") == "LVA" then
 if getElementData(client, "Должность") == "Подполковник" 
 or getElementData(client, "Должность") == "Полковник" 
 or getElementData(client, "Должность") == "Генерал" then
 if   getElementData(client, "KluchLVA005") == false then
 setElementData(client, "KluchLVA005", true)
   outputChatBox ("Вы взяли ключи от Rhino с номером LVA005", client)
   setElementData(marker1, "KluchLVA005", false)
 else
  outputChatBox ("У вас есть этот ключ", client)
 end
  else
 outputChatBox ("Вам не разрешено пользоваться этим автомобилем", client)
 end
 else
 outputChatBox ("Вам не разрешено пользоваться этим автомобилем", client)
 end
  else
 outputChatBox ("На складе отсутствует этот ключ", client)
 end
end
addEvent("VzyatKluchLVA005",true)
addEventHandler("VzyatKluchLVA005",getRootElement(),buyHamburger3)


function buyHamburger4 ( money, gunID, ammu )
if   getElementData(marker1, "KluchLVA006") == true then
 if getElementData (client, "frac") == "LVA" then
  if getElementData(client, "Должность") == "Подполковник" 
 or getElementData(client, "Должность") == "Полковник" 
 or getElementData(client, "Должность") == "Генерал" then
 if   getElementData(client, "KluchLVA006") == false then
 setElementData(client, "KluchLVA006", true)
   outputChatBox ("Вы взяли ключи от Rhino с номером LVA007", client)
   setElementData(marker1, "KluchLVA006", false)
 else
  outputChatBox ("У вас есть этот ключ", client)
 end
  else
 outputChatBox ("Вам не разрешено пользоваться этим автомобилем", client)
 end
 else
 outputChatBox ("Вам не разрешено пользоваться этим автомобилем", client)
 end
 else
 outputChatBox ("На складе отсутствует этот ключ", client)
 end
end
addEvent("VzyatKluchLVA006",true)
addEventHandler("VzyatKluchLVA006",getRootElement(),buyHamburger4)

function buyHamburger5 ( money, gunID, ammu )
if   getElementData(marker1, "KluchLVA007") == true then
 if getElementData (client, "frac") == "LVA" then
  if getElementData(client, "Должность") == "Сержант" 
 or getElementData(client, "Должность") == "Старший Сержант" 
 or getElementData(client, "Должность") == "Старшина" 
 or getElementData(client, "Должность") == "Прапорщик" 
 or getElementData(client, "Должность") == "Младший Лейтенант" 
 or getElementData(client, "Должность") == "Лейтенант" 
 or getElementData(client, "Должность") == "Старший Лейтенант" 
 or getElementData(client, "Должность") == "Капитан" 
 or getElementData(client, "Должность") == "Майор" 
 or getElementData(client, "Должность") == "Подполковник" 
 or getElementData(client, "Должность") == "Полковник" 
 or getElementData(client, "Должность") == "Генерал" then
 if   getElementData(client, "KluchLVA007") == false then
 setElementData(client, "KluchLVA007", true)
   outputChatBox ("Вы взяли ключи от Patriot с номером LVA007", client)
   setElementData(marker1, "KluchLVA007", false)
 else
  outputChatBox ("У вас есть этот ключ", client)
 end
  else
 outputChatBox ("Вам не разрешено пользоваться этим автомобилем", client)
 end
 else
 outputChatBox ("Вам не разрешено пользоваться этим автомобилем", client)
 end
  else
 outputChatBox ("На складе отсутствует этот ключ", client)
 end
end
addEvent("VzyatKluchLVA007",true)
addEventHandler("VzyatKluchLVA007",getRootElement(),buyHamburger5)

function buyHamburger6 ( money, gunID, ammu )
if   getElementData(marker1, "KluchLVA008") == true then
 if getElementData (client, "frac") == "LVA" then
  if getElementData(client, "Должность") == "Сержант" 
 or getElementData(client, "Должность") == "Старший Сержант" 
 or getElementData(client, "Должность") == "Старшина" 
 or getElementData(client, "Должность") == "Прапорщик" 
 or getElementData(client, "Должность") == "Младший Лейтенант" 
 or getElementData(client, "Должность") == "Лейтенант" 
 or getElementData(client, "Должность") == "Старший Лейтенант" 
 or getElementData(client, "Должность") == "Капитан" 
 or getElementData(client, "Должность") == "Майор" 
 or getElementData(client, "Должность") == "Подполковник" 
 or getElementData(client, "Должность") == "Полковник" 
 or getElementData(client, "Должность") == "Генерал" then
 if   getElementData(client, "KluchLVA008") == false then
 setElementData(client, "KluchLVA008", true)
   outputChatBox ("Вы взяли ключи от Patriot с номером LVA008", client)
   setElementData(marker1, "KluchLVA008", false)
 else
  outputChatBox ("У вас есть этот ключ", client)
 end
  else
 outputChatBox ("Вам не разрешено пользоваться этим автомобилем", client)
 end
 else
 outputChatBox ("Вам не разрешено пользоваться этим автомобилем", client)
 end
  else
 outputChatBox ("На складе отсутствует этот ключ", client)
 end
end
addEvent("VzyatKluchLVA008",true)
addEventHandler("VzyatKluchLVA008",getRootElement(),buyHamburger6)

function buyHamburger7 ( money, gunID, ammu )
if   getElementData(marker1, "KluchLVA009") == true then
 if getElementData (client, "frac") == "LVA" then
 if getElementData(client, "Должность") == "Сержант" 
 or getElementData(client, "Должность") == "Старший Сержант" 
 or getElementData(client, "Должность") == "Старшина" 
 or getElementData(client, "Должность") == "Прапорщик" 
 or getElementData(client, "Должность") == "Младший Лейтенант" 
 or getElementData(client, "Должность") == "Лейтенант" 
 or getElementData(client, "Должность") == "Старший Лейтенант" 
 or getElementData(client, "Должность") == "Капитан" 
 or getElementData(client, "Должность") == "Майор" 
 or getElementData(client, "Должность") == "Подполковник" 
 or getElementData(client, "Должность") == "Полковник" 
 or getElementData(client, "Должность") == "Генерал" then
 if   getElementData(client, "KluchLVA009") == false then
 setElementData(client, "KluchLVA009", true)
   outputChatBox ("Вы взяли ключи от Patriot с номером LVA009", client)
   setElementData(marker1, "KluchLVA009", false)
 else
  outputChatBox ("У вас есть этот ключ", client)
 end
  else
 outputChatBox ("Вам не разрешено пользоваться этим автомобилем", client)
 end
 else
 outputChatBox ("Вам не разрешено пользоваться этим автомобилем", client)
 end
  else
 outputChatBox ("На складе отсутствует этот ключ", client)
 end
end
addEvent("VzyatKluchLVA009",true)
addEventHandler("VzyatKluchLVA009",getRootElement(),buyHamburger7)

function buyHamburger8 ( money, gunID, ammu )
if   getElementData(marker1, "KluchLVA0010") == true then
 if getElementData (client, "frac") == "LVA" then
 if getElementData(client, "Должность") == "Сержант" 
 or getElementData(client, "Должность") == "Старший Сержант" 
 or getElementData(client, "Должность") == "Старшина" 
 or getElementData(client, "Должность") == "Прапорщик" 
 or getElementData(client, "Должность") == "Младший Лейтенант" 
 or getElementData(client, "Должность") == "Лейтенант" 
 or getElementData(client, "Должность") == "Старший Лейтенант" 
 or getElementData(client, "Должность") == "Капитан" 
 or getElementData(client, "Должность") == "Майор" 
 or getElementData(client, "Должность") == "Подполковник" 
 or getElementData(client, "Должность") == "Полковник" 
 or getElementData(client, "Должность") == "Генерал" then
 if   getElementData(client, "KluchLVA0010") == false then
 setElementData(client, "KluchLVA0010", true)
   outputChatBox ("Вы взяли ключи от Patriot с номером LVA0010", client)
   setElementData(marker1, "KluchLVA0010", false)
 else
  outputChatBox ("У вас есть этот ключ", client)
 end
  else
 outputChatBox ("Вам не разрешено пользоваться этим автомобилем", client)
 end
 else
 outputChatBox ("Вам не разрешено пользоваться этим автомобилем", client)
 end
  else
 outputChatBox ("На складе отсутствует этот ключ", client)
 end
end
addEvent("VzyatKluchLVA0010",true)
addEventHandler("VzyatKluchLVA0010",getRootElement(),buyHamburger8)

function buyHamburger9 ( money, gunID, ammu )
if   getElementData(marker1, "KluchLVA0011") == true then
 if getElementData (client, "frac") == "LVA" then
 if  getElementData(client, "Должность") == "Лейтенант"
 or getElementData(client, "Должность") == "Старший Лейтенант" 
 or getElementData(client, "Должность") == "Капитан" 
 or getElementData(client, "Должность") == "Майор" 
 or getElementData(client, "Должность") == "Подполковник" 
 or getElementData(client, "Должность") == "Полковник" 
 or getElementData(client, "Должность") == "Генерал" then
 if   getElementData(client, "KluchLVA0011") == false then
 setElementData(client, "KluchLVA0011", true)
   outputChatBox ("Вы взяли ключи от Mesa с номером LVA0011", client)
   setElementData(marker1, "KluchLVA0011", false)
 else
  outputChatBox ("У вас есть этот ключ", client)
 end
  else
 outputChatBox ("Вам не разрешено пользоваться этим автомобилем", client)
 end
 else
 outputChatBox ("Вам не разрешено пользоваться этим автомобилем", client)
 end
  else
 outputChatBox ("На складе отсутствует этот ключ", client)
 end
end
addEvent("VzyatKluchLVA0011",true)
addEventHandler("VzyatKluchLVA0011",getRootElement(),buyHamburger9)

function buyHamburger19 ( money, gunID, ammu )
if   getElementData(marker1, "KluchLVA0012") == true then
 if getElementData (client, "frac") == "LVA" then
 if getElementData(client, "Должность") == "Лейтенант" 
 or getElementData(client, "Должность") == "Старший Лейтенант" 
 or getElementData(client, "Должность") == "Капитан" 
 or getElementData(client, "Должность") == "Майор" 
 or getElementData(client, "Должность") == "Подполковник" 
 or getElementData(client, "Должность") == "Полковник" 
 or getElementData(client, "Должность") == "Генерал" then
 if   getElementData(client, "KluchLVA0012") == false then
 setElementData(client, "KluchLVA0012", true)
   outputChatBox ("Вы взяли ключи от Mesa с номером LVA0012", client)
   setElementData(marker1, "KluchLVA0012", false)
 else
  outputChatBox ("У вас есть этот ключ", client)
 end
  else
 outputChatBox ("Вам не разрешено пользоваться этим автомобилем", client)
 end
 else
 outputChatBox ("Вам не разрешено пользоваться этим автомобилем", client)
 end
  else
 outputChatBox ("На складе отсутствует этот ключ", client)
 end
end
addEvent("VzyatKluchLVA0012",true)
addEventHandler("VzyatKluchLVA0012",getRootElement(),buyHamburger19)

function buyHamburger129 ( money, gunID, ammu )
if   getElementData(marker1, "KluchLVA0013") == true then
 if getElementData (client, "frac") == "LVA" then
 if getElementData(client, "Должность") == "Старший Лейтенант" 
 or getElementData(client, "Должность") == "Капитан" 
 or getElementData(client, "Должность") == "Майор" 
 or getElementData(client, "Должность") == "Подполковник" 
 or getElementData(client, "Должность") == "Полковник" 
 or getElementData(client, "Должность") == "Генерал" then
 if   getElementData(client, "KluchLVA0013") == false then
 setElementData(client, "KluchLVA0013", true)
   outputChatBox ("Вы взяли ключи от Maverick с номером LVA0013", client)
   setElementData(marker1, "KluchLVA0013", false)
 else
  outputChatBox ("У вас есть этот ключ", client)
 end
  else
 outputChatBox ("Вам не разрешено пользоваться этим автомобилем", client)
 end
 else
 outputChatBox ("Вам не разрешено пользоваться этим автомобилем", client)
 end
  else
 outputChatBox ("На складе отсутствует этот ключ", client)
 end
end
addEvent("VzyatKluchLVA0013",true)
addEventHandler("VzyatKluchLVA0013",getRootElement(),buyHamburger129)

function buyHamburger39 ( money, gunID, ammu )
if   getElementData(marker1, "KluchLVA0014") == true then
 if getElementData (client, "frac") == "LVA" then
if getElementData(client, "Должность") == "Старший Лейтенант" 
 or getElementData(client, "Должность") == "Капитан" 
 or getElementData(client, "Должность") == "Майор" 
 or getElementData(client, "Должность") == "Подполковник" 
 or getElementData(client, "Должность") == "Полковник" 
 or getElementData(client, "Должность") == "Генерал" then
 if   getElementData(client, "KluchLVA0014") == false then
 setElementData(client, "KluchLVA0014", true)
   outputChatBox ("Вы взяли ключи от Maverick с номером LVA0014", client)
   setElementData(marker1, "KluchLVA0014", false)
 else
  outputChatBox ("У вас есть этот ключ", client)
 end
  else
 outputChatBox ("Вам не разрешено пользоваться этим автомобилем", client)
 end
 else
 outputChatBox ("Вам не разрешено пользоваться этим автомобилем", client)
 end
  else
 outputChatBox ("На складе отсутствует этот ключ", client)
 end
end
addEvent("VzyatKluchLVA0014",true)
addEventHandler("VzyatKluchLVA0014",getRootElement(),buyHamburger39)





