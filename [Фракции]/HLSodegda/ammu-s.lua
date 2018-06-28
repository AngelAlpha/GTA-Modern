function servetime ()
  servertime = getRealTime ()
  hours = servertime.hour
  minutes = string.format("%02d", servertime.minute)
  second = string.format("%02d", servertime.second)
end
setTimer (servetime, 1000, 0)

function PlayerWasted( )
outputDebugString (tostring(getAccountData(getPlayerAccount(source), "Jailtime")))
if getAccountData(getPlayerAccount(source), "Jailtime") ~= false then		
	setTimer( 
		function( source, PlayerWasted)
		spawnPlayer ( source, 264.20001220703, 77.599998474121, 1001)
		takeAllWeapons(source)
		setElementModel ( source,62 );
		setPlayerWantedLevel(source,0)
		setElementInterior (source , 6)
		setElementDimension (source , 1)
		end,
		2000,1, source)
else
	local Data2 = fromJSON( getAccountData( getPlayerAccount( source ), "Job.Pereodevalka" ) );
	setAccountData( getPlayerAccount( source ), "Job.Pereodevalka", toJSON( { skin = getElementModel( source ), bState = true } ) );
	outputChatBox("Вы потеряли сознание!",source,255,100,100);
	outputChatBox("Через некоторое время за вами приедет скорая!",source,255,100,100);
	setTimer( 
		function( source, PlayerWasted)
		spawnPlayer ( source, 1151.3924560547, -1315.9254150391, 1559.2277832031 );
		setElementHealth(source,5);
		setElementModel ( source,62 ); 
		setElementDimension ( source, 1 );
		setElementData (source, "больной", true)
		triggerClientEvent (source, "checkHLS", source)
		outputChatBox("Вы сильно пострадали, ложитесь в койку и выздоравливаете!",source,255,100,100);
		outputChatBox("Через некоторое время к вам должен подойти лечащий врач!",source,255,100,100);
		outputChatBox("Вас одели в пижаму и перебинтовали поломанные места!",source,255,100,100);
		outputChatBox("Свою одежду вы сможете забрать в шкафу своей палаты!",source,255,100,100);
		end,
		6000,1, source)
end
end 
addEventHandler( "onPlayerWasted", root,PlayerWasted)

local tollblip31 = createBlip (1173.0255126953, -1323.3587646484, 15.397415161133, 22)  
setBlipVisibleDistance (tollblip31, 200)
function addMarkers ( res )
    	marker = createPickup ( 1183.302734375,-1330.4443359375,1559.2355957031, 3, 1275, 1, 1 )
    	addEventHandler( "onPickupHit", marker, showAmmoGUI )
    	setElementDimension(marker, 1)
		setElementInterior(marker,0)
    end
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), addMarkers )

function addMarkers1 ( res )
    	marker1 = createPickup ( 1150.4010009766,-1326.3513183594,1559.2355957031, 3, 1275, 1, 1 )
    	addEventHandler( "onPickupHit", marker1, showAmmoGUI1 )
    	setElementDimension(marker1, 1)
		setElementInterior(marker1,0)
    end
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), addMarkers1 )

function addMarkers2 ( res )
    	marker2 = createPickup ( 1144.8944091797,-1326.5750732422,1559.2355957031, 3, 1275, 1, 1 )
    	addEventHandler( "onPickupHit", marker2, showAmmoGUI2 )
    	setElementDimension(marker2, 1)
		setElementInterior(marker2,0)
    end
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), addMarkers2 )

function showAmmoGUI( hitPlayer, matchingDimension )
		if source == marker then
	if getElementData (hitPlayer, "frac") == "HLS" then
		triggerClientEvent( hitPlayer, "showAmmoGUIHLSodegda", getRootElement(), hitPlayer, marker )
				else
		outputChatBox("Вы не состоите в этой организации!",hitPlayer,255,100,100)
		end
	end
end

function showAmmoGUI2( hitPlayer, matchingDimension )
		if source == marker2 then
		triggerClientEvent( hitPlayer, "showAmmoGUIHLSodegdaBolynoy", getRootElement(), hitPlayer, marker2 )
	end
end

function showAmmoGUI1( hitPlayer, matchingDimension )
		if source == marker1 then
		triggerClientEvent( hitPlayer, "showAmmoGUIHLSodegdaBolynoy", getRootElement(), hitPlayer, marker1 )
		end
	end


----------------------------------------------------------

function VodAvtobus ( money, gunID, ammu )
if not getAccountData( getPlayerAccount( client ), "Job.HLS" ) then return end
local Data = fromJSON( getAccountData( getPlayerAccount( client ), "Job.HLS" ) );
if not Data or Data.bState == false then
if getElementData(client, "Должность") == "Интерн" then
setAccountData( getPlayerAccount( client ), "Job.HLS", toJSON( { skin = getElementModel( client ), bState = true } ) );
  setElementModel ( client, 274 )
  elseif getElementData(client, "Должность") == "Санитар" then
  setAccountData( getPlayerAccount( client ), "Job.HLS", toJSON( { skin = getElementModel( client ), bState = true } ) );
  setElementModel ( client, 274 )
  elseif getElementData(client, "Должность") == "Медбрат" then
  setAccountData( getPlayerAccount( client ), "Job.HLS", toJSON( { skin = getElementModel( client ), bState = true } ) );
  setElementModel ( client, 275 )
  elseif getElementData(client, "Должность") == "Спасатель" then
  setAccountData( getPlayerAccount( client ), "Job.HLS", toJSON( { skin = getElementModel( client ), bState = true } ) );
  setElementModel ( client, 275 )
  elseif getElementData(client, "Должность") == "Нарколог" then
  setAccountData( getPlayerAccount( client ), "Job.HLS", toJSON( { skin = getElementModel( client ), bState = true } ) );
  setElementModel ( client, 275 )
  elseif getElementData(client, "Должность") == "Доктор" then
  setAccountData( getPlayerAccount( client ), "Job.HLS", toJSON( { skin = getElementModel( client ), bState = true } ) );
  setElementModel ( client, 276 )
  elseif getElementData(client, "Должность") == "Психолог" then
  setAccountData( getPlayerAccount( client ), "Job.HLS", toJSON( { skin = getElementModel( client ), bState = true } ) );
  setElementModel ( client, 276 )
  elseif getElementData(client, "Должность") == "Хирург" then
  setAccountData( getPlayerAccount( client ), "Job.HLS", toJSON( { skin = getElementModel( client ), bState = true } ) );
  setElementModel ( client, 276 )
  elseif getElementData(client, "Должность") == "Заместитель Главного Врача" then
  setAccountData( getPlayerAccount( client ), "Job.HLS", toJSON( { skin = getElementModel( client ), bState = true } ) );
  setElementModel ( client, 70 ) 
  elseif getElementData(client, "Должность") == "Главный Врач" then
  setAccountData( getPlayerAccount( client ), "Job.HLS", toJSON( { skin = getElementModel( client ), bState = true } ) );
  setElementModel ( client, 70 )
end
end
end
addEvent("HLSodeg",true)
addEventHandler("HLSodeg",getRootElement(),VodAvtobus)

function Meinodeg ( money, gunID, ammu )
if getAccountData( getPlayerAccount( client ), "Job.HLS" ) then
local Data = fromJSON( getAccountData( getPlayerAccount( client ), "Job.HLS" ) );
end
if Data and Data.bState == true then				
local iSkinID = Data.skin;					
setElementModel( client, iSkinID );
setAccountData( getPlayerAccount( client ), "Job.HLS", toJSON( { skin = nil, bState = false } ) );	
end
end
addEvent("Meinodeg1",true)
addEventHandler("Meinodeg1",getRootElement(),Meinodeg)

function Pizhama ( money, gunID, ammu )
local Data2 = fromJSON( getAccountData( getPlayerAccount( client ), "Job.Pereodevalka" ) );
if not Data2 or Data2.bState == false then
setAccountData( getPlayerAccount( client ), "Job.Pereodevalka", toJSON( { skin = getElementModel( client ), bState = true } ) );
  setElementModel ( client, 62 )
else
outputChatBox("На вас уже одета пижама пациента!",client,255,100,100)
end
end
addEvent("Pizhama",true)
addEventHandler("Pizhama",getRootElement(),Pizhama)

function Meinodeg2 ( money, gunID, ammu )
local Data2 = fromJSON( getAccountData( getPlayerAccount( client ), "Job.Pereodevalka" ) );
if Data2 and Data2.bState == true then				
local iSkinID = Data2.skin;					
setElementModel( client, iSkinID );
setAccountData( getPlayerAccount( client ), "Job.Pereodevalka", toJSON( { skin = nil, bState = false } ) );	
else
outputChatBox("Ваших вещей не было найдено в шкафчике!",client,255,100,100)
end
end
addEvent("Meinodeg2",true)
addEventHandler("Meinodeg2",getRootElement(),Meinodeg2)

function getPlayerFromID ( id )
        for k, player in ipairs ( getElementsByType ( "player" ) ) do
                local p_id = getElementData ( player, "ID" )
                if ( p_id == tonumber(id) ) then
                        player_n = getPlayerName ( player )
                        return player, player_n
                end
        end
                return false, "No player has been found with the ID " .. id .. "."
end

function removeHex(text, digits)
    assert(type(text) == "string", "Bad argument 1 @ removeHex [String expected, got " .. tostring(text) .. "]")
    --assert(digits == nil or (type(digits) == "number" and digits > 0), "Bad argument 2 @ removeHex [Number greater than zero expected, got " .. tostring(digits) .. "]")
    return string.gsub(text, "#" .. (6 and string.rep("%x", 6) or "%x+"), "")
end

local tableWSkin = {23,52,62}
addCommandHandler ("changeskin", function(pl, _, id, skin)
if isPlayerHLS (pl) then
	if getHLSRank (pl) > 7 then
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



function isPlayerHLS (pl)
if getElementData (pl, "frac") == "HLS" then
	return true
else
	return false
end
end

function getHLSRank (pl)
local rank = 0
if isPlayerHLS (pl) then
	if getElementData(pl, "Должность") == "Интерн" then
	rank = 1
	elseif getElementData(pl, "Должность") == "Санитар" then
	rank = 2
	elseif getElementData(pl, "Должность") == "Медбрат" then
	rank = 3
	elseif getElementData(pl, "Должность") == "Спасатель" then
	rank = 4
	elseif getElementData(pl, "Должность") == "Нарколог" then
	rank = 5
	elseif getElementData(pl, "Должность") == "Доктор" then
	rank = 6
	elseif getElementData(pl, "Должность") == "Психолог" then
	rank = 7
	elseif getElementData(pl, "Должность") == "Хирург" then
	rank = 8
	elseif getElementData(pl, "Должность") == "Заместитель Главного Врача" then
	rank = 9
	elseif getElementData(pl, "Должность") == "Главный Врач" then
	rank = 10
	end
end
return rank
end

addEvent ("attache", true)
addEventHandler ("attache", root, function(type, pl, el)
if type == "1" then
	attachElements (pl, el, 0.2, 2.4, 1.7)
	setPedAnimation (pl, "crack", "crckidle2")
elseif type == "2" then
	detachElements (pl)
	setPedAnimation (pl)
end
end)

addEventHandler ("onPlayerDamage", root, function()
if getElementHealth (source) < 20 then
setPedAnimation (source, "crack", "crckdeth2")
end
end)