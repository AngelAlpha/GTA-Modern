function servetime ()
  servertime = getRealTime ()
  hours = servertime.hour
  minutes = string.format("%02d", servertime.minute)
  second = string.format("%02d", servertime.second)
end
setTimer (servetime, 1000, 0)

function addmarker1s ( res )
    	marker1 = createMarker ( 1185.7911376953,-1337.2908935547, 1558.2355957031, "cylinder", 1.5, 255, 255, 0, 170 )
    	addEventHandler( "onMarkerHit", marker1, showAmmoGUI )
    	setElementDimension(marker1, 1)
		--setElementInterior(marker1,5)
		setElementData(marker1, "KluchHLS001", true)
		setElementData(marker1, "KluchHLS002", true)
		setElementData(marker1, "KluchHLS003", true)
		setElementData(marker1, "KluchHLS004", true)
		setElementData(marker1, "KluchHLS005", true)
    end
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), addmarker1s )

addEventHandler ("onPlayerQuit", root, function()
if getPlayerKluch (source) then
	respawn (source, getElementData (getVehFromKluch (getPlayerKluch(source)), "hospital"))
	setElementData (marker1, getPlayerKluch (source), true)
	removeElementData (source, getPlayerKluch (source))
end
end)

function showAmmoGUI( hitPlayer, matchingDimension )
		if source == marker1 and getElementData (hitPlayer, "frac") == "HLS" then
		if (getElementData(hitPlayer, "KluchHLS001") == true) then
		setElementData(marker1, "KluchHLS001", true)
		triggerClientEvent( hitPlayer, "UbratyAutoHLS001", getRootElement(), hitPlayer, marker1, 1 )
		outputChatBox("Вы положили ключи от Ambulance на склад",hitPlayer)
		setElementData(hitPlayer, "KluchHLS001", false)
		elseif (getElementData(hitPlayer, "KluchHLS002") == true) then
		setElementData(marker1, "KluchHLS002", true)
		outputChatBox("Вы положили ключи от Ambulance на склад",hitPlayer)
		setElementData(hitPlayer, "KluchHLS002", false)
		triggerClientEvent( hitPlayer, "UbratyAutoHLS002", getRootElement(), hitPlayer, marker1, 2 )
		elseif (getElementData(hitPlayer, "KluchHLS003") == true) then
		setElementData(marker1, "KluchHLS003", true)
		setElementData(hitPlayer, "KluchHLS003", false)
		outputChatBox("Вы положили ключи от Ambulance на склад",hitPlayer)
		triggerClientEvent( hitPlayer, "UbratyAutoHLS003", getRootElement(), hitPlayer, marker1, 3 )
		elseif (getElementData(hitPlayer, "KluchHLS004") == true) then
		setElementData(marker1, "KluchHLS004", true)
		setElementData(hitPlayer, "KluchHLS004", false)
		outputChatBox("Вы положили ключи от Ambulance на склад",hitPlayer)
		triggerClientEvent( hitPlayer, "UbratyAutoHLS004", getRootElement(), hitPlayer, marker1, 4 )
		elseif (getElementData(hitPlayer, "KluchHLS005") == true) then
		setElementData(marker1, "KluchHLS005", true)
		setElementData(hitPlayer, "KluchHLS005", false)
		outputChatBox("Вы положили ключи от Ambulance на склад",hitPlayer)
		triggerClientEvent( hitPlayer, "UbratyAutoHLS005", getRootElement(), hitPlayer, marker1, 5 )
		else
		triggerClientEvent( hitPlayer, "showAmmoHLSKluch", getRootElement(), hitPlayer, marker1 )
		end
		else
		outputChatBox("Вам запрещено брать от сюда ключи",hitPlayer,200,0,0)
end
end

function buyHamburger0 ( money, gunID, ammu )
if   getElementData(marker1, "KluchHLS001") == true then
 if   getElementData(client, "Должность") == "Медбрат" 
 or getElementData(client, "Должность") == "Спасатель" 
 or getElementData(client, "Должность") == "Нарколог" 
 or getElementData(client, "Должность") == "Доктор" 
 or getElementData(client, "Должность") == "Психолог" 
 or getElementData(client, "Должность") == "Хирург" 
 or getElementData(client, "Должность") == "Заместитель Главного Врача" 
 or getElementData(client, "Должность") == "Главный Врач" then
 if   getElementData(client, "KluchHLS001") == false then
 setElementData(client, "KluchHLS001", true)
 setElementData(marker1, "KluchHLS001", false)
   outputChatBox ("Вы взяли ключи от Ambulance с номером "..positionVeh[1][8].."|77", client)
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
addEvent("VzyatKluchHLS001",true)
addEventHandler("VzyatKluchHLS001",getRootElement(),buyHamburger0)

function buyHamburger ( money, gunID, ammu )
if   getElementData(marker1, "KluchHLS002") == true then
  if   getElementData(client, "Должность") == "Медбрат" 
 or getElementData(client, "Должность") == "Спасатель" 
 or getElementData(client, "Должность") == "Нарколог" 
 or getElementData(client, "Должность") == "Доктор" 
 or getElementData(client, "Должность") == "Психолог" 
 or getElementData(client, "Должность") == "Хирург" 
 or getElementData(client, "Должность") == "Заместитель Главного Врача" 
 or getElementData(client, "Должность") == "Главный Врач" then
 if   getElementData(client, "KluchHLS002") == false then
 setElementData(client, "KluchHLS002", true)
   outputChatBox ("Вы взяли ключи от Ambulance с номером "..positionVeh[2][8].."|77", client)
   setElementData(marker1, "KluchHLS002", false)
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
addEvent("VzyatKluchHLS002",true)
addEventHandler("VzyatKluchHLS002",getRootElement(),buyHamburger)

function buyHamburger1 ( money, gunID, ammu )
if   getElementData(marker1, "KluchHLS003") == true then
 if getElementData (client, "frac") == "HLS" then
 if   getElementData(client, "Должность") == "Медбрат" 
 or getElementData(client, "Должность") == "Спасатель" 
 or getElementData(client, "Должность") == "Нарколог" 
 or getElementData(client, "Должность") == "Доктор" 
 or getElementData(client, "Должность") == "Психолог" 
 or getElementData(client, "Должность") == "Хирург" 
 or getElementData(client, "Должность") == "Заместитель Главного Врача" 
 or getElementData(client, "Должность") == "Главный Врач" then
 if   getElementData(client, "KluchHLS003") == false then
 setElementData(client, "KluchHLS003", true)
   outputChatBox ("Вы взяли ключи от Ambulance с номером "..positionVeh[3][8].."|77", client)
   setElementData(marker1, "KluchHLS003", false)
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
addEvent("VzyatKluchHLS003",true)
addEventHandler("VzyatKluchHLS003",getRootElement(),buyHamburger1)

function buyHamburger2 ( money, gunID, ammu )
if   getElementData(marker1, "KluchHLS004") == true then
 if getElementData (client, "frac") == "HLS" then
 if   getElementData(client, "Должность") == "Медбрат" 
 or getElementData(client, "Должность") == "Спасатель" 
 or getElementData(client, "Должность") == "Нарколог" 
 or getElementData(client, "Должность") == "Доктор" 
 or getElementData(client, "Должность") == "Психолог" 
 or getElementData(client, "Должность") == "Хирург" 
 or getElementData(client, "Должность") == "Заместитель Главного Врача" 
 or getElementData(client, "Должность") == "Главный Врач" then
 if   getElementData(client, "KluchHLS004") == false then
 setElementData(client, "KluchHLS004", true)
   outputChatBox ("Вы взяли ключи от Ambulance с номером "..positionVeh[4][8].."|77", client)
   setElementData(marker1, "KluchHLS004", false)
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
addEvent("VzyatKluchHLS004",true)
addEventHandler("VzyatKluchHLS004",getRootElement(),buyHamburger2)

function buyHamburger3 ( money, gunID, ammu )
if   getElementData(marker1, "KluchHLS005") == true then
 if getElementData (client, "frac") == "HLS" then
  if   getElementData(client, "Должность") == "Медбрат" 
 or getElementData(client, "Должность") == "Спасатель" 
 or getElementData(client, "Должность") == "Нарколог" 
 or getElementData(client, "Должность") == "Доктор" 
 or getElementData(client, "Должность") == "Психолог" 
 or getElementData(client, "Должность") == "Хирург" 
 or getElementData(client, "Должность") == "Заместитель Главного Врача" 
 or getElementData(client, "Должность") == "Главный Врач" then
 if   getElementData(client, "KluchHLS005") == false then
 setElementData(client, "KluchHLS005", true)
   outputChatBox ("Вы взяли ключи от Ambulance с номером "..positionVeh[5][8].."|77", client)
   setElementData(marker1, "KluchHLS005", false)
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
addEvent("VzyatKluchHLS005",true)
addEventHandler("VzyatKluchHLS005",getRootElement(),buyHamburger3)
