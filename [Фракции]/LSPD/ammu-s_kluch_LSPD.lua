	function servetime ()
  servertime = getRealTime ()
  hours = servertime.hour
  minutes = string.format("%02d", servertime.minute)
  second = string.format("%02d", servertime.second)
end
setTimer (servetime, 1000, 0)


function addmarker1s ( res )
    	marker1 = createMarker (235.2166595459,71.8107910156, 1004.140625, "cylinder", 1.5, 255, 255, 0, 170 )
    	addEventHandler( "onMarkerHit", marker1, showAmmoGUI )
    	setElementDimension(marker1, 1)
		setElementInterior(marker1,6)
		setElementData(marker1, "KluchLSPD001", true)
		setElementData(marker1, "KluchLSPD002", true)
		setElementData(marker1, "KluchLSPD003", true)
		setElementData(marker1, "KluchLSPD004", true)
		setElementData(marker1, "KluchLSPD005", true)
		setElementData(marker1, "KluchLSPD006", true)
		setElementData(marker1, "KluchLSPD007", true)
		setElementData(marker1, "KluchLSPD008", true)
		setElementData(marker1, "KluchLSPD009", true)
		setElementData(marker1, "KluchLSPD0010", true)
		setElementData(marker1, "KluchLSPD0011", true)
		setElementData(marker1, "KluchLSPD0012", true)
		setElementData(marker1, "KluchLSPD0013", true)
		setElementData(marker1, "KluchLSPD0014", true)
    end
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), addmarker1s )

addEventHandler ("onPlayerQuit", root, function()
if getPlayerKluch (source) then
	respawn (source, getElementData (getVehFromKluch (getPlayerKluch(source)), "police"))
	setElementData (marker1, getPlayerKluch (source), true)
	removeElementData (source, getPlayerKluch (source))
end
end)
--LosPD = createTeam("Los Santos Police Department",0,0,200)
function showAmmoGUI( hitPlayer, matchingDimension )
		if source == marker1 and getElementData (hitPlayer, "frac") == "LSPD" then
		if (getElementData(hitPlayer, "KluchLSPD001") == true) then
		setElementData(marker1, "KluchLSPD001", true)
		triggerClientEvent( hitPlayer, "UbratyAutoLSPD001", getRootElement(), hitPlayer, marker1, 1 )
		outputChatBox("Вы положили ключи от Police Car на склад",hitPlayer)
		setElementData(hitPlayer, "KluchLSPD001", false)
		elseif (getElementData(hitPlayer, "KluchLSPD002") == true) then
		setElementData(marker1, "KluchLSPD002", true)
		outputChatBox("Вы положили ключи от Police Car на склад",hitPlayer)
		setElementData(hitPlayer, "KluchLSPD002", false)
		triggerClientEvent( hitPlayer, "UbratyAutoLSPD002", getRootElement(), hitPlayer, marker1, 2 )
		elseif (getElementData(hitPlayer, "KluchLSPD003") == true) then
		setElementData(marker1, "KluchLSPD003", true)
		setElementData(hitPlayer, "KluchLSPD003", false)
		outputChatBox("Вы положили ключи от Police Car на склад",hitPlayer)
		triggerClientEvent( hitPlayer, "UbratyAutoLSPD003", getRootElement(), hitPlayer, marker1, 3 )
		elseif (getElementData(hitPlayer, "KluchLSPD004") == true) then
		setElementData(marker1, "KluchLSPD004", true)
		setElementData(hitPlayer, "KluchLSPD004", false)
		outputChatBox("Вы положили ключи от Police Car на склад",hitPlayer)
		triggerClientEvent( hitPlayer, "UbratyAutoLSPD004", getRootElement(), hitPlayer, marker1, 4 )
		elseif (getElementData(hitPlayer, "KluchLSPD005") == true) then
		setElementData(marker1, "KluchLSPD005", true)
		setElementData(hitPlayer, "KluchLSPD005", false)
		outputChatBox("Вы положили ключи от Police Car на склад",hitPlayer)
		triggerClientEvent( hitPlayer, "UbratyAutoLSPD005", getRootElement(), hitPlayer,marker1, 5 )
		elseif (getElementData(hitPlayer, "KluchLSPD006") == true) then
		setElementData(marker1, "KluchLSPD006", true)
		setElementData(hitPlayer, "KluchLSPD006", false)
		outputChatBox("Вы положили ключи от Police Car на склад",hitPlayer)
		triggerClientEvent( hitPlayer, "UbratyAutoLSPD006", getRootElement(), hitPlayer,marker1, 6 )
		elseif (getElementData(hitPlayer, "KluchLSPD007") == true) then
		setElementData(marker1, "KluchLSPD007", true)
		setElementData(hitPlayer, "KluchLSPD007", false)
		outputChatBox("Вы положили ключи от Police Car на склад",hitPlayer)
		triggerClientEvent( hitPlayer, "UbratyAutoLSPD007", getRootElement(), hitPlayer,marker1, 7 )
		elseif (getElementData(hitPlayer, "KluchLSPD008") == true) then
		setElementData(marker1, "KluchLSPD008", true)
		setElementData(hitPlayer, "KluchLSPD008", false)
		outputChatBox("Вы положили ключи от Police Ranger на склад",hitPlayer)
		triggerClientEvent( hitPlayer, "UbratyAutoLSPD008", getRootElement(), hitPlayer,marker1, 8 )
		elseif (getElementData(hitPlayer, "KluchLSPD009") == true) then
		setElementData(marker1, "KluchLSPD009", true)
		setElementData(hitPlayer, "KluchLSPD009", false)
		outputChatBox("Вы положили ключи от Police Ranger на склад",hitPlayer)
		triggerClientEvent( hitPlayer, "UbratyAutoLSPD009", getRootElement(), hitPlayer,marker1, 9 )
		elseif (getElementData(hitPlayer, "KluchLSPD0010") == true) then
		setElementData(marker1, "KluchLSPD0010", true)
		setElementData(hitPlayer, "KluchLSPD0010", false)
		outputChatBox("Вы положили ключи от Police Ranger на склад",hitPlayer)
		triggerClientEvent( hitPlayer, "UbratyAutoLSPD0010", getRootElement(), hitPlayer,marker1, 10 )
		elseif (getElementData(hitPlayer, "KluchLSPD0011") == true) then
		setElementData(marker1, "KluchLSPD0011", true)
		setElementData(hitPlayer, "KluchLSPD0011", false)
		outputChatBox("Вы положили ключи от Police Ranger на склад",hitPlayer)
		triggerClientEvent( hitPlayer, "UbratyAutoLSPD0011", getRootElement(), hitPlayer,marker1, 11 )
		elseif (getElementData(hitPlayer, "KluchLSPD0012") == true) then
		setElementData(marker1, "KluchLSPD0012", true)
		setElementData(hitPlayer, "KluchLSPD0012", false)
		outputChatBox("Вы положили ключи от Police Ranger на склад",hitPlayer)
		triggerClientEvent( hitPlayer, "UbratyAutoLSPD0012", getRootElement(), hitPlayer,marker1, 12 )
		elseif (getElementData(hitPlayer, "KluchLSPD0013") == true) then
		setElementData(marker1, "KluchLSPD0013", true)
		setElementData(hitPlayer, "KluchLSPD0013", false)
		outputChatBox("Вы положили ключи от Enforcer на склад",hitPlayer)
		triggerClientEvent( hitPlayer, "UbratyAutoLSPD0013", getRootElement(), hitPlayer,marker1, 13 )
		elseif (getElementData(hitPlayer, "KluchLSPD0014") == true) then
		setElementData(marker1, "KluchLSPD0014", true)
		setElementData(hitPlayer, "KluchLSPD0014", false)
		outputChatBox("Вы положили ключи от Enforcer на склад",hitPlayer)
		triggerClientEvent( hitPlayer, "UbratyAutoLSPD0014", getRootElement(), hitPlayer,marker1, 14 )
		else
		triggerClientEvent( hitPlayer, "showAmmoLSPDKluch", getRootElement(), hitPlayer,marker1)
		end
		else
		outputChatBox("Вам запрещено брать от сюда ключи",hitPlayer,200,0,0)
end
end

function buyHamburger0 ( money, gunID, ammu )
if   getElementData(marker1, "KluchLSPD001") == true then
 if   getElementData(client, "Должность") == "Офицер Полиции" 
 or getElementData(client, "Должность") == "Детектив" 
 or getElementData(client, "Должность") == "Младший Сержант Полиции" 
 or getElementData(client, "Должность") == "Сержант Полиции" 
 or getElementData(client, "Должность") == "Старший Сержант Полиции" 
 or getElementData(client, "Должность") == "Лейтенант Полиции" 
 or getElementData(client, "Должность") == "Капитан Полиции" 
 or getElementData(client, "Должность") == "Инспектор" 
 or getElementData(client, "Должность") == "Майор Полиции" 
 or getElementData(client, "Должность") == "Комиссар Полиции" 
 or getElementData(client, "Должность") == "Шеф Полиции" 
 or getElementData(client, "Должность") == "Помощник Шерифа" 
 or getElementData(client, "Должность") == "Шериф" then
 if   getElementData(client, "KluchLSPD001") == false then
 setElementData(client, "KluchLSPD001", true)
 setElementData(marker1, "KluchLSPD001", false)
   outputChatBox ("Вы взяли ключи от Police Car с номером "..positionVeh[1][8].."|77", client)
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
addEvent("VzyatKluchLSPD001",true)
addEventHandler("VzyatKluchLSPD001",getRootElement(),buyHamburger0)

function buyHamburger ( money, gunID, ammu )
if   getElementData(marker1, "KluchLSPD002") == true then
 if   getElementData(client, "Должность") == "Офицер Полиции" 
 or getElementData(client, "Должность") == "Детектив" 
 or getElementData(client, "Должность") == "Младший Сержант Полиции" 
 or getElementData(client, "Должность") == "Сержант Полиции" 
 or getElementData(client, "Должность") == "Старший Сержант Полиции" 
 or getElementData(client, "Должность") == "Лейтенант Полиции" 
 or getElementData(client, "Должность") == "Капитан Полиции" 
 or getElementData(client, "Должность") == "Инспектор" 
 or getElementData(client, "Должность") == "Майор Полиции" 
 or getElementData(client, "Должность") == "Комиссар Полиции" 
 or getElementData(client, "Должность") == "Шеф Полиции" 
 or getElementData(client, "Должность") == "Помощник Шерифа" 
 or getElementData(client, "Должность") == "Шериф" then
 if   getElementData(client, "KluchLSPD002") == false then
 setElementData(client, "KluchLSPD002", true)
   outputChatBox ("Вы взяли ключи от Police Car с номером "..positionVeh[2][8].."|77", client)
   setElementData(marker1, "KluchLSPD002", false)
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
addEvent("VzyatKluchLSPD002",true)
addEventHandler("VzyatKluchLSPD002",getRootElement(),buyHamburger)

function buyHamburger1 ( money, gunID, ammu )
if   getElementData(marker1, "KluchLSPD003") == true then
 if getElementData (client, "frac") == "LSPD" then
  if   getElementData(client, "Должность") == "Офицер Полиции" 
 or getElementData(client, "Должность") == "Детектив" 
 or getElementData(client, "Должность") == "Младший Сержант Полиции" 
 or getElementData(client, "Должность") == "Сержант Полиции" 
 or getElementData(client, "Должность") == "Старший Сержант Полиции" 
 or getElementData(client, "Должность") == "Лейтенант Полиции" 
 or getElementData(client, "Должность") == "Капитан Полиции" 
 or getElementData(client, "Должность") == "Инспектор" 
 or getElementData(client, "Должность") == "Майор Полиции" 
 or getElementData(client, "Должность") == "Комиссар Полиции" 
 or getElementData(client, "Должность") == "Шеф Полиции" 
 or getElementData(client, "Должность") == "Помощник Шерифа" 
 or getElementData(client, "Должность") == "Шериф" then
 if   getElementData(client, "KluchLSPD003") == false then
 setElementData(client, "KluchLSPD003", true)
   outputChatBox ("Вы взяли ключи от Police Car с номером "..positionVeh[3][8].."|77", client)
   setElementData(marker1, "KluchLSPD003", false)
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
addEvent("VzyatKluchLSPD003",true)
addEventHandler("VzyatKluchLSPD003",getRootElement(),buyHamburger1)

function buyHamburger2 ( money, gunID, ammu )
if   getElementData(marker1, "KluchLSPD004") == true then
 if getElementData (client, "frac") == "LSPD" then
 if   getElementData(client, "Должность") == "Офицер Полиции" 
 or getElementData(client, "Должность") == "Детектив" 
 or getElementData(client, "Должность") == "Младший Сержант Полиции" 
 or getElementData(client, "Должность") == "Сержант Полиции" 
 or getElementData(client, "Должность") == "Старший Сержант Полиции" 
 or getElementData(client, "Должность") == "Лейтенант Полиции" 
 or getElementData(client, "Должность") == "Капитан Полиции" 
 or getElementData(client, "Должность") == "Инспектор" 
 or getElementData(client, "Должность") == "Майор Полиции" 
 or getElementData(client, "Должность") == "Комиссар Полиции" 
 or getElementData(client, "Должность") == "Шеф Полиции" 
 or getElementData(client, "Должность") == "Помощник Шерифа" 
 or getElementData(client, "Должность") == "Шериф" then
 if   getElementData(client, "KluchLSPD004") == false then
 setElementData(client, "KluchLSPD004", true)
   outputChatBox ("Вы взяли ключи от Police Car с номером "..positionVeh[4][8].."|77", client)
   setElementData(marker1, "KluchLSPD004", false)
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
addEvent("VzyatKluchLSPD004",true)
addEventHandler("VzyatKluchLSPD004",getRootElement(),buyHamburger2)

function buyHamburger3 ( money, gunID, ammu )
if   getElementData(marker1, "KluchLSPD005") == true then
 if getElementData (client, "frac") == "LSPD" then
  if   getElementData(client, "Должность") == "Офицер Полиции" 
 or getElementData(client, "Должность") == "Детектив" 
 or getElementData(client, "Должность") == "Младший Сержант Полиции" 
 or getElementData(client, "Должность") == "Сержант Полиции" 
 or getElementData(client, "Должность") == "Старший Сержант Полиции" 
 or getElementData(client, "Должность") == "Лейтенант Полиции" 
 or getElementData(client, "Должность") == "Капитан Полиции" 
 or getElementData(client, "Должность") == "Инспектор" 
 or getElementData(client, "Должность") == "Майор Полиции" 
 or getElementData(client, "Должность") == "Комиссар Полиции" 
 or getElementData(client, "Должность") == "Шеф Полиции" 
 or getElementData(client, "Должность") == "Помощник Шерифа" 
 or getElementData(client, "Должность") == "Шериф" then
 if   getElementData(client, "KluchLSPD005") == false then
 setElementData(client, "KluchLSPD005", true)
   outputChatBox ("Вы взяли ключи от Police Car с номером "..positionVeh[5][8].."|77", client)
   setElementData(marker1, "KluchLSPD005", false)
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
addEvent("VzyatKluchLSPD005",true)
addEventHandler("VzyatKluchLSPD005",getRootElement(),buyHamburger3)


function buyHamburger4 ( money, gunID, ammu )
if   getElementData(marker1, "KluchLSPD006") == true then
 if getElementData (client, "frac") == "LSPD" then
 if getElementData(client, "Должность") == "Майор Полиции" 
 or getElementData(client, "Должность") == "Комиссар Полиции" 
 or getElementData(client, "Должность") == "Шеф Полиции" 
 or getElementData(client, "Должность") == "Помощник Шерифа" 
 or getElementData(client, "Должность") == "Шериф" then
 if   getElementData(client, "KluchLSPD006") == false then
 setElementData(client, "KluchLSPD006", true)
   outputChatBox ("Вы взяли ключи от Police Car с номером "..positionVeh[6][8].."|77", client)
   setElementData(marker1, "KluchLSPD006", false)
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
addEvent("VzyatKluchLSPD006",true)
addEventHandler("VzyatKluchLSPD006",getRootElement(),buyHamburger4)

function buyHamburger5 ( money, gunID, ammu )
if   getElementData(marker1, "KluchLSPD007") == true then
 if getElementData (client, "frac") == "LSPD" then
 if getElementData(client, "Должность") == "Майор Полиции" 
 or getElementData(client, "Должность") == "Комиссар Полиции" 
 or getElementData(client, "Должность") == "Шеф Полиции" 
 or getElementData(client, "Должность") == "Помощник Шерифа" 
 or getElementData(client, "Должность") == "Шериф" then
 if   getElementData(client, "KluchLSPD007") == false then
 setElementData(client, "KluchLSPD007", true)
   outputChatBox ("Вы взяли ключи от Police Car с номером "..positionVeh[7][8].."|77", client)
   setElementData(marker1, "KluchLSPD007", false)
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
addEvent("VzyatKluchLSPD007",true)
addEventHandler("VzyatKluchLSPD007",getRootElement(),buyHamburger5)

function buyHamburger6 ( money, gunID, ammu )
if   getElementData(marker1, "KluchLSPD008") == true then
 if getElementData (client, "frac") == "LSPD" then
 if getElementData(client, "Должность") == "Старший Сержант Полиции" 
 or getElementData(client, "Должность") == "Лейтенант Полиции" 
 or getElementData(client, "Должность") == "Капитан Полиции" 
 or getElementData(client, "Должность") == "Инспектор" 
 or getElementData(client, "Должность") == "Майор Полиции" 
 or getElementData(client, "Должность") == "Комиссар Полиции" 
 or getElementData(client, "Должность") == "Шеф Полиции" 
 or getElementData(client, "Должность") == "Помощник Шерифа" 
 or getElementData(client, "Должность") == "Шериф" then
 if   getElementData(client, "KluchLSPD008") == false then
 setElementData(client, "KluchLSPD008", true)
   outputChatBox ("Вы взяли ключи от Police Ranger с номером "..positionVeh[8][8].."|77", client)
   setElementData(marker1, "KluchLSPD008", false)
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
addEvent("VzyatKluchLSPD008",true)
addEventHandler("VzyatKluchLSPD008",getRootElement(),buyHamburger6)

function buyHamburger7 ( money, gunID, ammu )
if   getElementData(marker1, "KluchLSPD009") == true then
 if getElementData (client, "frac") == "LSPD" then
 if getElementData(client, "Должность") == "Старший Сержант Полиции" 
 or getElementData(client, "Должность") == "Лейтенант Полиции" 
 or getElementData(client, "Должность") == "Капитан Полиции" 
 or getElementData(client, "Должность") == "Инспектор" 
 or getElementData(client, "Должность") == "Майор Полиции" 
 or getElementData(client, "Должность") == "Комиссар Полиции" 
 or getElementData(client, "Должность") == "Шеф Полиции" 
 or getElementData(client, "Должность") == "Помощник Шерифа" 
 or getElementData(client, "Должность") == "Шериф" then
 if   getElementData(client, "KluchLSPD009") == false then
 setElementData(client, "KluchLSPD009", true)
   outputChatBox ("Вы взяли ключи от Police Ranger с номером "..positionVeh[9][8].."|77", client)
   setElementData(marker1, "KluchLSPD009", false)
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
addEvent("VzyatKluchLSPD009",true)
addEventHandler("VzyatKluchLSPD009",getRootElement(),buyHamburger7)

function buyHamburger8 ( money, gunID, ammu )
if   getElementData(marker1, "KluchLSPD0010") == true then
 if getElementData (client, "frac") == "LSPD" then
 if getElementData(client, "Должность") == "Детектив" 
 or getElementData(client, "Должность") == "Младший Сержант Полиции" 
 or getElementData(client, "Должность") == "Сержант Полиции" 
 or getElementData(client, "Должность") == "Старший Сержант Полиции" 
 or getElementData(client, "Должность") == "Лейтенант Полиции" 
 or getElementData(client, "Должность") == "Капитан Полиции" 
 or getElementData(client, "Должность") == "Инспектор" 
 or getElementData(client, "Должность") == "Майор Полиции" 
 or getElementData(client, "Должность") == "Комиссар Полиции" 
 or getElementData(client, "Должность") == "Шеф Полиции" 
 or getElementData(client, "Должность") == "Помощник Шерифа" 
 or getElementData(client, "Должность") == "Шериф" then
 if   getElementData(client, "KluchLSPD0010") == false then
 setElementData(client, "KluchLSPD0010", true)
   outputChatBox ("Вы взяли ключи от Police Ranger с номером "..positionVeh[10][8].."|77", client)
   setElementData(marker1, "KluchLSPD0010", false)
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
addEvent("VzyatKluchLSPD0010",true)
addEventHandler("VzyatKluchLSPD0010",getRootElement(),buyHamburger8)

function buyHamburger9 ( money, gunID, ammu )
if   getElementData(marker1, "KluchLSPD0011") == true then
 if getElementData (client, "frac") == "LSPD" then
 if getElementData(client, "Должность") == "Детектив" 
 or getElementData(client, "Должность") == "Младший Сержант Полиции" 
 or getElementData(client, "Должность") == "Сержант Полиции" 
 or getElementData(client, "Должность") == "Старший Сержант Полиции" 
 or getElementData(client, "Должность") == "Лейтенант Полиции" 
 or getElementData(client, "Должность") == "Капитан Полиции" 
 or getElementData(client, "Должность") == "Инспектор" 
 or getElementData(client, "Должность") == "Майор Полиции" 
 or getElementData(client, "Должность") == "Комиссар Полиции" 
 or getElementData(client, "Должность") == "Шеф Полиции" 
 or getElementData(client, "Должность") == "Помощник Шерифа" 
 or getElementData(client, "Должность") == "Шериф" then
 if   getElementData(client, "KluchLSPD0011") == false then
 setElementData(client, "KluchLSPD0011", true)
   outputChatBox ("Вы взяли ключи от Police Ranger с номером "..positionVeh[11][8].."|77", client)
   setElementData(marker1, "KluchLSPD0011", false)
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
addEvent("VzyatKluchLSPD0011",true)
addEventHandler("VzyatKluchLSPD0011",getRootElement(),buyHamburger9)

function buyHamburger19 ( money, gunID, ammu )
if   getElementData(marker1, "KluchLSPD0012") == true then
 if getElementData (client, "frac") == "LSPD" then
 if getElementData(client, "Должность") == "Детектив" 
 or getElementData(client, "Должность") == "Младший Сержант Полиции" 
 or getElementData(client, "Должность") == "Сержант Полиции" 
 or getElementData(client, "Должность") == "Старший Сержант Полиции" 
 or getElementData(client, "Должность") == "Лейтенант Полиции" 
 or getElementData(client, "Должность") == "Капитан Полиции" 
 or getElementData(client, "Должность") == "Инспектор" 
 or getElementData(client, "Должность") == "Майор Полиции" 
 or getElementData(client, "Должность") == "Комиссар Полиции" 
 or getElementData(client, "Должность") == "Шеф Полиции" 
 or getElementData(client, "Должность") == "Помощник Шерифа" 
 or getElementData(client, "Должность") == "Шериф" then
 if   getElementData(client, "KluchLSPD0012") == false then
 setElementData(client, "KluchLSPD0012", true)
   outputChatBox ("Вы взяли ключи от Police Ranger с номером "..positionVeh[12][8].."|77", client)
   setElementData(marker1, "KluchLSPD0012", false)
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
addEvent("VzyatKluchLSPD0012",true)
addEventHandler("VzyatKluchLSPD0012",getRootElement(),buyHamburger19)

function buyHamburger129 ( money, gunID, ammu )
if   getElementData(marker1, "KluchLSPD0013") == true then
 if getElementData (client, "frac") == "LSPD" then
 if getElementData(client, "Должность") == "Детектив" 
 or getElementData(client, "Должность") == "Младший Сержант Полиции" 
 or getElementData(client, "Должность") == "Сержант Полиции" 
 or getElementData(client, "Должность") == "Старший Сержант Полиции" 
 or getElementData(client, "Должность") == "Лейтенант Полиции" 
 or getElementData(client, "Должность") == "Капитан Полиции" 
 or getElementData(client, "Должность") == "Инспектор" 
 or getElementData(client, "Должность") == "Майор Полиции" 
 or getElementData(client, "Должность") == "Комиссар Полиции" 
 or getElementData(client, "Должность") == "Шеф Полиции" 
 or getElementData(client, "Должность") == "Помощник Шерифа" 
 or getElementData(client, "Должность") == "Шериф" then
 if   getElementData(client, "KluchLSPD0013") == false then
 setElementData(client, "KluchLSPD0013", true)
   outputChatBox ("Вы взяли ключи от Enforcer с номером "..positionVeh[13][8].."|77", client)
   setElementData(marker1, "KluchLSPD0013", false)
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
addEvent("VzyatKluchLSPD0013",true)
addEventHandler("VzyatKluchLSPD0013",getRootElement(),buyHamburger129)

function buyHamburger39 ( money, gunID, ammu )
if   getElementData(marker1, "KluchLSPD0014") == true then
 if getElementData (client, "frac") == "LSPD" then
 if getElementData(client, "Должность") == "Инспектор" 
 or getElementData(client, "Должность") == "Майор Полиции" 
 or getElementData(client, "Должность") == "Комиссар Полиции" 
 or getElementData(client, "Должность") == "Шеф Полиции" 
 or getElementData(client, "Должность") == "Помощник Шерифа" 
 or getElementData(client, "Должность") == "Шериф" then
 if   getElementData(client, "KluchLSPD0014") == false then
 setElementData(client, "KluchLSPD0014", true)
   outputChatBox ("Вы взяли ключи от Enforcer с номером "..positionVeh[14][8].."|77", client)
   setElementData(marker1, "KluchLSPD0014", false)
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
addEvent("VzyatKluchLSPD0014",true)
addEventHandler("VzyatKluchLSPD0014",getRootElement(),buyHamburger39)
 
function cuff (pl, cmd, id)
if cmd == "cuff" then
	if not tonumber(id) then return end
	local id = tonumber(id)
	local target = getPlayerFromID (id)
	if not isElement (target) then return end
	if getPlayerWantedLevel (target) == 0 then return end
	local pos1 = Vector3(getElementPosition (pl))
	local pos2 = Vector3(getElementPosition (target))
	if getDistanceBetweenPoints3D (pos1, pos2) > 5 then outputChatBox ("Вы слишком далеко", pl, 255, 0, 0) return end
	setElementFrozen (target, true)
	setElementData (target, "cuff", true)
	for i, v in ipairs (controlTable) do
		toggleControl (target, v, false)
	end
	outputChatBox (string.format("Вы надели на игрока %s наручники", removeHex(getPlayerName (target))), pl, 255, 200, 0)
	outputChatBox (string.format("Сотрудник полиции %s надел на вас наручники", removeHex(getPlayerName (pl))), target, 255, 200, 0)
elseif cmd == "uncuff" then
	if not tonumber(id) then return end
	local id = tonumber(id)
	local target = getPlayerFromID (id)
	if not isElement (target) then outputChatBox ("Такого игрока нету", pl, 255, 0, 0) return end
	local pos1 = Vector3(getElementPosition (pl))
	local pos2 = Vector3(getElementPosition (target))
	if getDistanceBetweenPoints3D (pos1, pos2) > 5 then outputChatBox ("Вы слишком далеко", pl, 255, 0, 0) return end
	setElementFrozen (target, false)
	setElementData (target, "cuff", false)
	for i, v in ipairs (controlTable) do
		toggleControl (target, v, true)
	end
	outputChatBox (string.format("Вы сняли с игрока %s наручники", removeHex(getPlayerName (target))), pl, 255, 200, 0)
	outputChatBox (string.format("Сотрудник полиции %s снял с вас наручники", removeHex(getPlayerName (pl))), target, 255, 200, 0)
end
end
addCommandHandler ("cuff", cuff)
addCommandHandler ("uncuff", cuff)

function putincar (pl, _, id)
	if not isPedInVehicle (pl) then return end
	if not tonumber(id) then return end
	local id = tonumber(id)
	local target = getPlayerFromID (id)
	if not isElement (target) then return end
	if getPlayerWantedLevel (target) == 0 then return end
	local pos1 = Vector3(getElementPosition (pl))
	local pos2 = Vector3(getElementPosition (target))
	if getDistanceBetweenPoints3D (pos1, pos2) > 200 then outputChatBox ("Вы слишком далеко", pl, 255, 0, 0) return end
	if not getElementData (target, "cuff") then return end
	if getVehicleCountPl (getPedOccupiedVehicle(pl)) == getVehicleMaxPassengers (getPedOccupiedVehicle(pl)) then return end
	warpPedIntoVehicle (target, getPedOccupiedVehicle(pl))
end

function getPlayerFromID (id)
for i, v in ipairs (getElementsByType ("player")) do
	if getElementData (v, "ID") == id then
		return v
	end
end
end

function removeHex(text, digits)
    assert(type(text) == "string", "Bad argument 1 @ removeHex [String expected, got " .. tostring(text) .. "]")
    --assert(digits == nil or (type(digits) == "number" and digits > 0), "Bad argument 2 @ removeHex [Number greater than zero expected, got " .. tostring(digits) .. "]")
    return string.gsub(text, "#" .. (6 and string.rep("%x", 6) or "%x+"), "")
end

function getVehicleCountPl (veh)
local counter = 0
for seat, player in pairs(getVehicleOccupants(veh)) do
    counter = counter + 1
end
return counter
end

addCommandHandler ("setwanted", function(pl, _, id, level)
	if not tonumber(id) then return end
	local id = tonumber(id)
	local target = getPlayerFromID (id)
	if not isElement (target) then return end
	setPlayerWantedLevel (target, tonumber(level))
end)

local tableLic = {
["a"] = {"moto", "мотоциклов"},
["b"] = {"avto", "легковых ТС"},
["c"] = {"gruz", "грузовых ТС"},
["d"] = {"passangers", "пассажирских ТС"},
}

addCommandHandler ("takelic", function(pl, _, id, lic)
if getElementData (pl, "frac") == "LSPD" then
	if not tonumber (id) then return end
	if not lic then	outputChatBox ("Синтаксис: /takelic [ID] [Лицензия]", pl, 0, 255, 0) outputChatBox ("Лицензии:", pl, 0, 255, 0)
		outputChatBox ("	1) a - мотоциклы", pl, 0, 255, 0)
		outputChatBox ("	2) b - легковые", pl, 0, 255, 0)
		outputChatBox ("	3) c - грузовые", pl, 0, 255, 0)
		outputChatBox ("	4) d - пассажирские", pl, 0, 255, 0)
	return end
	if not tableLic[lic] then outputChatBox ("Синтаксис: /takelic [ID] [Лицензия]", pl, 0, 255, 0) outputChatBox ("Лицензии:", pl, 0, 255, 0)
		outputChatBox ("	1) a - мотоциклы", pl, 0, 255, 0)
		outputChatBox ("	2) b - легковые", pl, 0, 255, 0)
		outputChatBox ("	3) c - грузовые", pl, 0, 255, 0)
		outputChatBox ("	4) d - пассажирские", pl, 0, 255, 0)
	return end
	local target = getPlayerFromID (id)
	local lic = string.lower(lic)
	removeElementData (target, "prava:"..tableLic[lic][1], false)
	outputChatBox ("Cотрудник полиции "..removeHex(getPlayerName(pl)).." забрал у вас права на вождение "..tableLic[lic][2], target, 255, 0, 0)
	outputChatBox ("Вы забрали права на вождение "..tableLic[lic][2].." у "..removeHex(getPlayerName(target)), pl, 0, 255, 0)
end
end)

addCommandHandler ("clear", function(pl, _, id)
if isPlayerPolice (pl) then
	if not tonumber (id) then return end
	local target = getPlayerFromID (id)
	setPlayerWantedLevel (target, 0)
	outputChatBox ("Вы убрали уровень розыска у игрока "..removeHex(getPlayerName(target)), pl, 0, 255, 0)
end
end)

local tableWSkin = {23,52,62}
addCommandHandler ("changeskin", function(pl, _, id, skin)
if isPlayerPolice (pl) then
	if getPoliceRank (pl) > 10 then
		if not tonumber (id) then return end
		if not tonumber (skin) then return end
		if tonumber(skin) < 0 or tonumber(skin) > #tableWSkin then return end
		local target = getPlayerFromID (id)
		if getElementData (target, "Pol") ~= "Woman" then return end
		setElementModel (target, tableWSkin[tonumber(skin)])
		outputChatBox ("Вы поставили сотруднице "..removeHex(getPlayerName(target)).." скин", pl, 0, 255, 0)
	end
end
end)

function isPlayerPolice (pl)
if getElementData (pl, "frac") == "LSPD" then
	return true
else
	return false
end
end

function getPoliceRank (pl)
local rank = 0
if isPlayerPolice (pl) then
	if getElementData(pl, "Должность") == "Кадет" then
	rank = 1
	elseif getElementData(pl, "Должность") == "Офицер Полиции" then
	rank = 2
	elseif getElementData(pl, "Должность") == "Детектив" then
	rank = 3
	elseif getElementData(pl, "Должность") == "Младший Сержант Полиции" then
	rank = 4
	elseif getElementData(pl, "Должность") == "Сержант Полиции" then
	rank = 5
	elseif getElementData(pl, "Должность") == "Старший Сержант Полиции" then
	rank = 6
	elseif getElementData(pl, "Должность") == "Лейтенант Полиции" then
	rank = 7
	elseif getElementData(pl, "Должность") == "Капитан Полиции" then
	rank = 8
	elseif getElementData(pl, "Должность") == "Инспектор" then
	rank = 9
	elseif getElementData(pl, "Должность") == "Майор Полиции" then
	rank = 10
	elseif getElementData(pl, "Должность") == "Комиссар Полиции" then
	rank = 11
	elseif getElementData(pl, "Должность") == "Шеф Полиции" then
	rank = 12
	elseif getElementData(pl, "Должность") == "Помощник Шерифа" then
	rank = 13
	elseif getElementData(pl, "Должность") == "Шериф" then
	rank = 14
	end
end
return rank
end

function licence (pl, cmd, target)
if tonumber(target) then
target = getPlayerFromID (target)
else
target = pl
end
for i, v in pairs (tableLic) do
	setElementData (target, "prava:"..v[1], true)
end
outputChatBox ("Права были выданы игроку "..removeHex(getPlayerName(target)), pl, 0, 255, 0)
end
addCommandHandler ("givelicadmin", licence)

function ganelic (pl, cmd, target)
if tonumber(target) then
target = getPlayerFromID (target)
else
target = pl
end
if cmd == "ganelic" then
	setElementData (target, "prava:weapon", true)
	outputChatBox ("Лицензия на оружие была выдана игроку "..removeHex(getPlayerName(target)), pl, 0, 255, 0)
elseif cmd == "unganelic" then
	setElementData (target, "prava:weapon", false)
	outputChatBox ("Лицензия на оружие была отобрано у игрока "..removeHex(getPlayerName(target)), pl, 0, 255, 0)
end
end
addCommandHandler ("ganelic", ganelic)
addCommandHandler ("unganelic", ganelic)

addEventHandler ("onPlayerQuit", root, function()
if getElementData (source, "cuff") == true then
	portjail(source)
	local level = getPlayerWantedLevel (source)
	local knastzeit = level*5
	setAccountData(getPlayerAccount(source), "Jailtime", knastzeit)
	local x, y, z = getElementPosition(source)
	local dim = getElementDimension (source)
	local int = getElementInterior (source)
	setAccountData (getPlayerAccount(source), "Position", toJSON ({x, y, z, dim, int}))
	triggerEvent ("database", root, "remove", _, source)
end
end)

addEventHandler ("onPlayerWasted", root, function (_, attacker)
if isElement (attacker) then
	if getElementData (attacker, "frac") == "LSPD" or getElementData (attacker, "frac") == "LVA" then return end
	local level = getPlayerWantedLevel (attacker)
	if level <= 2 then
		outputChatBox ("Вы убили игрока, вам присвоен уровень розыска 2!", attacker, 255, 0, 0)
		setPlayerWantedLevel (attacker, 2)
	end
end
end)