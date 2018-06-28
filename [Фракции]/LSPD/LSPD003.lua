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
    
local pVeh = {}

function spawnVeh ()
for i, v in ipairs (positionVeh) do
	pVeh[i] = createVehicle (v[1], v[2], v[3], v[4], v[5], v[6], v[7])
	setVehicleLocked (pVeh[i], true)
	setElementData (pVeh[i], "numberType", "police")
	setElementData (pVeh[i], "police", i)
	setElementData (pVeh[i], "number:plate", v[8].."77")
	setVehicleColor (pVeh[i], 0,0,0,255,255,255)
	if i > 10 then
		setElementData (pVeh[i], "policeCar", "KluchLSPD00"..i)
	else
		setElementData (pVeh[i], "policeCar", "KluchLSPD00"..i)
	end
end
end
addEventHandler ("onResourceStart", getResourceRootElement(getThisResource()), spawnVeh)

function playerCarLock(source, cmd)
local x, y, z = getElementPosition(source)
local veh = getVehFromKluch (getPlayerKluch(source))
if not isElement(veh) then return end
if getDistanceBetweenPoints3D ( x, y, z, getElementPosition ( veh ) ) < 33 then
	if not (isVehicleLocked(veh)) then    
		setVehicleLocked(veh, true)
		outputChatBox ("#FFCC00Машина с номером #00AAFF'"..getElementData(veh, "number:plate").."' #FF0000закрыта", source, 0, 255, 0, true)
	else
		setVehicleLocked(veh, false)
		outputChatBox ("#FFCC00Машина с номером #00AAFF'"..getElementData(veh, "number:plate").."' #00FF00открыта", source, 0, 255, 0, true)					
	end				
end
end
addEventHandler("CommmandHandler", getRootElement(), playerCarLock )
addCommandHandler("lock", playerCarLock)

function engine(source, cmd)
local veh = getVehFromKluch (getPlayerKluch(source))
if not isElement(veh) then return end
if (getVehicleEngineState(veh) == false) then
	setVehicleEngineState(veh, true)
else
	setVehicleEngineState(veh, false)
end   
end
addEventHandler("CommmandHandler", getRootElement(), engine )
addCommandHandler("engine", engine)

setTimer(function ()
for i, v in ipairs (pVeh) do
	if isElementInWater (v) then
        setTimer(respawn, 3000, 1, _, i)
		setVehicleEngineState (v, false)
		setVehicleLocked (v, true)
		setVehicleOverrideLights (v,1)
    end
end	  
end, 30000, 0)

setTimer(function ()
for i, v in ipairs (pVeh) do
	--for _, p in ipairs (getElementsByType("player")) do
	if not getVehicleOccupant (v) then
        setTimer(respawn, 3000, 1, _, getElementData(v, "police"))
		setVehicleEngineState (v, false)
		setVehicleLocked (v, true)
		setVehicleOverrideLights (v,1)
   -- end
	end
end	   
end, 1000*10, 0)

addEventHandler ("onVehicleDamage", root, function()
if getElementData (source, "policeCar") then
	if getElementHealth (source) < 350 then
		setElementHealth (source, 350)
	end
end
end)

function respawn(source, num)
  respawnVehicle (pVeh[num])
  setVehicleEngineState(pVeh[num], false)
  setVehicleOverrideLights ( pVeh[num], 1 )
  setVehicleLocked (pVeh[num], true)
  end
addEvent("DestroyvehicleLSPD003",true)
addEventHandler("DestroyvehicleLSPD003",getRootElement(),respawn)

addEventHandler("onVehicleExplode", resourceRoot, function ()
setTimer(respawn, 3000, 1, source, getElementData(source, "police"))
end)