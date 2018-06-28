function servetime ()
  servertime = getRealTime ()
  hours = servertime.hour
  minutes = string.format("%02d", servertime.minute)
  second = string.format("%02d", servertime.second)
end
setTimer (servetime, 1000, 0)


function addMarkers ( res )
    	marker = createPickup ( 257.98630, 79.25796, 1003.64063, 3, 1275, 1, 1 )
    	addEventHandler( "onPickupHit", marker, showAmmoGUI )
    	setElementDimension(marker, 1)
		setElementInterior(marker,6)
    end
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), addMarkers )

function showAmmoGUI( hitPlayer, matchingDimension )
		if source == marker then
	if getElementData (hitPlayer, "frac") == "LSPD" then
		triggerClientEvent( hitPlayer, "showAmmoGUILSPDodegda", getRootElement(), hitPlayer, marker )
				else
		outputChatBox("Вы не состоите в этой организации!",hitPlayer,255,100,100)
		end
	end
end


----------------------------------------------------------

function VodAvtobus ( money, gunID, ammu )
if getAccountData( getPlayerAccount( client ), "Job.LSPD" ) then
local Data = fromJSON( getAccountData( getPlayerAccount( client ), "Job.LSPD" ) );
end
if not Data or Data.bState == false then
if getElementData(client, "Должность") == "Кадет" then
	setAccountData( getPlayerAccount( client ), "Job.LSPD", toJSON( { skin = getElementModel( client ), bState = true } ) );
	setElementModel ( client, 265 )
	
elseif getElementData(client, "Должность") == "Офицер Полиции" then
	setAccountData( getPlayerAccount( client ), "Job.LSPD", toJSON( { skin = getElementModel( client ), bState = true } ) );
	setElementModel ( client, 280 )
	
elseif getElementData(client, "Должность") == "Детектив" then
	setAccountData( getPlayerAccount( client ), "Job.LSPD", toJSON( { skin = getElementModel( client ), bState = true } ) );
	setElementModel ( client, 281 )
	
elseif getElementData(client, "Должность") == "Младший Сержант Полиции" then
	setAccountData( getPlayerAccount( client ), "Job.LSPD", toJSON( { skin = getElementModel( client ), bState = true } ) );
	setElementModel ( client, 281 )
	
elseif getElementData(client, "Должность") == "Сержант Полиции" then
	setAccountData( getPlayerAccount( client ), "Job.LSPD", toJSON( { skin = getElementModel( client ), bState = true } ) );
	setElementModel ( client, 266 )
	
elseif getElementData(client, "Должность") == "Старший Сержант Полиции" then
	setAccountData( getPlayerAccount( client ), "Job.LSPD", toJSON( { skin = getElementModel( client ), bState = true } ) );
	setElementModel ( client, 266 )
	
elseif getElementData(client, "Должность") == "Лейтенант Полиции" then
	setAccountData( getPlayerAccount( client ), "Job.LSPD", toJSON( { skin = getElementModel( client ), bState = true } ) );
	setElementModel ( client, 267 )
	
elseif getElementData(client, "Должность") == "Капитан Полиции" then
	setAccountData( getPlayerAccount( client ), "Job.LSPD", toJSON( { skin = getElementModel( client ), bState = true } ) );
	setElementModel ( client, 267 )
	
elseif getElementData(client, "Должность") == "Инспектор" then
	setAccountData( getPlayerAccount( client ), "Job.LSPD", toJSON( { skin = getElementModel( client ), bState = true } ) );
	setElementModel ( client, 282 )
	
elseif getElementData(client, "Должность") == "Майор Полиции" then
	setAccountData( getPlayerAccount( client ), "Job.LSPD", toJSON( { skin = getElementModel( client ), bState = true } ) );
	setElementModel ( client, 282 )
	
elseif getElementData(client, "Должность") == "Комиссар Полиции" then
	setAccountData( getPlayerAccount( client ), "Job.LSPD", toJSON( { skin = getElementModel( client ), bState = true } ) );
	setElementModel ( client, 282 )
	
elseif getElementData(client, "Должность") == "Шеф Полиции" then
	setAccountData( getPlayerAccount( client ), "Job.LSPD", toJSON( { skin = getElementModel( client ), bState = true } ) );
	setElementModel ( client, 283 )

elseif getElementData(client, "Должность") == "Помощник Шерифа" then
	setAccountData( getPlayerAccount( client ), "Job.LSPD", toJSON( { skin = getElementModel( client ), bState = true } ) );
	setElementModel ( client, 283 )
	
elseif getElementData(client, "Должность") == "Шериф" then
	setAccountData( getPlayerAccount( client ), "Job.LSPD", toJSON( { skin = getElementModel( client ), bState = true } ) );
	setElementModel ( client, 283 )
end
end
end
addEvent("LSPDodeg",true)
addEventHandler("LSPDodeg",getRootElement(),VodAvtobus)

function Meinodeg ( money, gunID, ammu )
local Data = fromJSON( getAccountData( getPlayerAccount( client ), "Job.LSPD" ) );
if Data and Data.bState == true then				
local iSkinID = Data.skin;					
setElementModel( client, iSkinID );
setAccountData( getPlayerAccount( client ), "Job.LSPD", toJSON( { skin = nil, bState = false } ) );	
end
end
addEvent("Meinodeg1",true)
addEventHandler("Meinodeg1",getRootElement(),Meinodeg)