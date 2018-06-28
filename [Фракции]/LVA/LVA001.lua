function servetime ()
  servertime = getRealTime ()
  hours = servertime.hour
  minutes = string.format("%02d", servertime.minute)
  second = string.format("%02d", servertime.second)
end
setTimer (servetime, 1000, 0)

function factionChatNews (thePlayer, cmd, ...)
if  getElementData(thePlayer, "Должность") == "Генерал" or getElementData(thePlayer, "Должность") == "Полковник" or getElementData(thePlayer, "Должность") == "Подполковник" then
    if ... then
	local message = table.concat({...}, " ")
		  outputChatBox ("[Новости] "..getPlayerName(thePlayer)..": "..message, root,0,205,0)
     end
	 end
end	 
addEventHandler("CommmandHandler", getRootElement(),factionChatNews )
addCommandHandler ("news", factionChatNews)

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
    
   
     
    function money ()
      for i, thePlayer in pairs (getElementsByType("player")) do
	  local playeraccount = getPlayerAccount ( thePlayer )
           if getElementData(thePlayer, "Должность") == "Рядовой" then  
                givePlayerMoney (thePlayer, 10000)
                outputChatBox ("Вам зачислена зарплата - 10000$", thePlayer)
            elseif getElementData(thePlayer, "Должность") == "Ефрейтор" then
                givePlayerMoney(thePlayer,100000)
                outputChatBox ("Вам зачислена зарплата - 100000$", thePlayer)
            elseif getElementData(thePlayer, "Должность") == "Младший Сержант" then  
                givePlayerMoney(thePlayer,150000)
                outputChatBox ("Вам зачислена зарплата - 150000$", thePlayer)
             elseif getElementData(thePlayer, "Должность") == "Сержант" then
                givePlayerMoney(thePlayer,200000)
                outputChatBox ("Вам зачислена зарплата - 200000$", thePlayer)
            elseif getElementData(thePlayer, "Должность") == "Старший Сержант" then  
                givePlayerMoney(thePlayer,250000)
                outputChatBox ("Вам зачислена зарплата - 250000$", thePlayer)
            elseif getElementData(thePlayer, "Должность") == "Старшина" then
                givePlayerMoney(thePlayer,300000)
                outputChatBox ("Вам зачислена зарплата - 300000$", thePlayer)
            elseif getElementData(thePlayer, "Должность") == "Прапорщик" then
                givePlayerMoney(thePlayer,350000)
                outputChatBox ("Вам зачислена зарплата - 350000$", thePlayer) 
            elseif getElementData(thePlayer, "Должность") == "Младший Лейтенант" then
                givePlayerMoney(thePlayer,400000)
                outputChatBox ("Вам зачислена зарплата - 400000$", thePlayer) 
            elseif getElementData(thePlayer, "Должность") == "Лейтенант" then
                givePlayerMoney(thePlayer,450000)
                outputChatBox ("Вам зачислена зарплата - 450000$", thePlayer) 
              elseif getElementData(thePlayer, "Должность") == "Старший Лейтенант" then
                givePlayerMoney(thePlayer,500000)
                outputChatBox ("Вам зачислена зарплата - 500000$", thePlayer) 	
               elseif getElementData(thePlayer, "Должность") == "Капитан" then
                givePlayerMoney(thePlayer,600000)
                outputChatBox ("Вам зачислена зарплата - 600000$", thePlayer)
              elseif getElementData(thePlayer, "Должность") == "Майор" then
                givePlayerMoney(thePlayer,650000)
                outputChatBox ("Вам зачислена зарплата - 650000$", thePlayer)
              elseif getElementData(thePlayer, "Должность") == "Подполковник" then
                givePlayerMoney(thePlayer,700000)
                outputChatBox ("Вам зачислена зарплата - 700000$", thePlayer)		
              elseif getElementData(thePlayer, "Должность") == "Полковник" then
                givePlayerMoney(thePlayer,800000)
                outputChatBox ("Вам зачислена зарплата - 800000$", thePlayer)
              elseif getElementData(thePlayer, "Должность") == "Генерал" then
                givePlayerMoney(thePlayer,900000)
                outputChatBox ("Вам зачислена зарплата - 900000$", thePlayer)					
            end
        end
	 end	
    setTimer (money, 1800000, 0)



local pVeh = {}

function spawnVeh ()
for i, v in ipairs (positionVeh) do
	pVeh[i] = createVehicle (v[1], v[2], v[3], v[4], v[5], v[6], v[7])
	if v[1] == 433 then
		setElementData (pVeh[i], "LVAAmmo:Load", 0)
	end
	setVehicleLocked (pVeh[i], true)
	setElementData (pVeh[i], "numberType", "army")
	--local num = generateNumbers (77)
	setElementData (pVeh[i], "LVA", i)
	setElementData (pVeh[i], "number:plate", v[8].."77")
	setVehicleColor (pVeh[i], 0,0,0,255,255,255)
	if i > 10 then
		setElementData (pVeh[i], "LVACar", "KluchLVA00"..i)
	else
		setElementData (pVeh[i], "LVACar", "KluchLVA00"..i)
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
        setTimer(respawn, 3000, 1, _, getElementData(v, "LVA"))
		setVehicleEngineState (v, false)
		setVehicleLocked (v, true)
		setVehicleOverrideLights (v,1)
   -- end
	end
end	   
end, 1000*60*5, 0)

function getVehicleOccupants (veh)
local counter = 0
for seat, player in ipairs(getVehicleOccupants(veh)) do
    counter = counter + 1
end
return counter
end

addEventHandler ("onVehicleDamage", root, function()
if getElementData (source, "LVACar") then
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
  if getElementModel(pVeh[num]) == 433 then
		setElementData (pVeh[num], "LVAAmmo:Load", 0)
	end
  end
addEvent("DestroyvehicleLVA003",true)
addEventHandler("DestroyvehicleLVA003",getRootElement(),respawn)

addEventHandler("onVehicleExplode", resourceRoot, function ()
setTimer(respawn, 3000, 1, source, getElementData(source, "LVA"))
end)
	
	
cop = {}
amount = {}


function invite (thePlayer, cmd, target, id)
if thePlayer and isElement(thePlayer) then 
		  local accountplayer = getPlayerAccount(thePlayer)
          local accName = getAccountName (accountplayer)
        if  getElementData(thePlayer, "Должность") == "Генерал" or getElementData(thePlayer, "Должность") == "Полковник" then
			   if target then
	               local player = getPlayerFromID(tonumber(target))		   
			         if player and isElement(player) then
					   local account = getPlayerAccount(player)
                       local oFaction = getAccountData(account, "Faction") or 0	
		                  if getElementData(player, "Должность") == "Генерал" or getElementData(player, "Должность") == "Полковник" then 
		                  outputChatBox ( "Вы не можете принять во фракцию самого себя", thePlayer, 255, 100 ,100 )
		                  return
		                  end					   
						     if not getElementData(player, "Job") or getElementData(player, "Job") == "Безработный" then	
                              if tonumber(oFaction) == nil or 0 then
								setElementData(player, "frac", "LVA")
							   setElementData (player, "Job", "Военный")
		                       setElementData(player, "Должность", "Рядовой")
							   setElementModel ( player, 287 )
							   setPlayerNametagColor(player, 105,139,34)
                               outputChatBox ("Вы приняли "..getPlayerName(player).." во фракцию LVA.", thePlayer)
						       outputChatBox ("Вас принял "..getPlayerName(thePlayer).." во фракцию LVA.", player)
							  end
							  							else
							  outputChatBox ("Этот игрок уже где-то работает.", thePlayer)
						   end
						   end
                     end
				end	 
          end
end
addEventHandler("CommmandHandler", getRootElement(), invite )			   
addCommandHandler( "invite", invite)

function uninvite (thePlayer, cmd, target, id)
if thePlayer and isElement(thePlayer) then 
		  local accountplayer = getPlayerAccount(thePlayer)
          local accName = getAccountName (accountplayer)
        if  getElementData(thePlayer, "Должность") == "Генерал" or getElementData(thePlayer, "Должность") == "Полковник" then
			   if target then
	               local player = getPlayerFromID(tonumber(target))		   
			         if player and isElement(player) then
					   local account = getPlayerAccount(player)
                       local oFaction = getAccountData(account, "Faction") or 0	
		                  if getElementData(player, "Должность") == "Генерал" then 
		                  outputChatBox ( "Вы не можете изгнать из фракции самого себя", thePlayer, 255, 100 ,100 )
		                  return
		                  end				
                   if getElementData (player, "frac") == "LVA" then							  
                              if tonumber(oFaction) == nil or 0 then
							   setElementData(player, "frac", "Безработный")
							   setElementData (player, "Job", "Безработный")
		                       setElementData(player, "Должность", "Безработный")
							   setPlayerNametagColor(player, 255,215,0)
							   setElementModel ( player, 0 )
                               outputChatBox ("Вы изгнали "..getPlayerName(player).." из фракции LVA.", thePlayer)
						       outputChatBox ("Вас изгнал "..getPlayerName(thePlayer).."из фракции LVA.", player)
							  end
							  else
							  outputChatBox ("Этот игрок не состоит в этой фракции.", thePlayer)
						   end
                     end
				end	 
          end
end
end
addEventHandler("CommmandHandler", getRootElement(), uninvite )			   
addCommandHandler( "uninvite", uninvite)

function rank(thePlayer, cmd, target, id)
if thePlayer and isElement(thePlayer) then 
		  local accountplayer = getPlayerAccount(thePlayer)
          local accName = getAccountName (accountplayer)
         if  getElementData(thePlayer, "Должность") == "Генерал" or getElementData(thePlayer, "Должность") == "Полковник" then
			   if target then
	               local player = getPlayerFromID(tonumber(target))		   
			         if player and isElement(player) then
					   local account = getPlayerAccount(player)
                       local oFaction = getAccountData(account, "Faction") or 0	
                          if getElementData(player, "Должность") == "Генерал" then 
		                  outputChatBox ( "Вы не можете изменить ранг самому себе", thePlayer, 255, 100 ,100 )
		                  return
		                  end		
                             if getElementData (player, "frac") == "LVA" then				  
                             if tonumber(id) == 1 then					   
							   ----local team = getTeamFromName("Las Venturas Army")
							   setElementModel ( player, 287 )
	                          -- --setPlayerTeam(player, team)
		                       setElementData(player, "Должность", "Рядовой")
                               outputChatBox ("Вы изменили ранг игрока "..getPlayerName(player).." на Рядового.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlayerName(thePlayer).." на Рядового.", player)
							 elseif tonumber(id) == 2 then	
							   --local team = getTeamFromName("Las Venturas Army")
							   setElementModel ( player, 287 )
	                           --setPlayerTeam(player, team)
		                       setElementData(player, "Должность", "Ефрейтор")
                               outputChatBox ("Вы изменили ранг игрока "..getPlayerName(player).." на Ефрейтора.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlayerName(thePlayer).." на Ефрейтора.", player)
							   elseif tonumber(id) == 3 then	
							   --local team = getTeamFromName("Las Venturas Army")
	                           --setPlayerTeam(player, team)
		                       setElementData(player, "Должность", "Младший Сержант")
							   setElementModel ( player, 287 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlayerName(player).." на Младшего Сержанта.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlayerName(thePlayer).." на Младшего Сержанта.", player)
							   elseif tonumber(id) == 4 then	
							   --local team = getTeamFromName("Las Venturas Army")
	                           --setPlayerTeam(player, team)
		                       setElementData(player, "Должность", "Сержант")
							   setElementModel ( player, 287 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlayerName(player).." на Сержанта.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlayerName(thePlayer).." на Сержанта.", player)
							   elseif tonumber(id) == 5 then	
							   --local team = getTeamFromName("Las Venturas Army")
	                           --setPlayerTeam(player, team)
		                       setElementData(player, "Должность", "Старший Сержант")
							   setElementModel ( player, 287 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlayerName(player).." на Старшего Сержанта.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlayerName(thePlayer).." на Старшего Сержанта.", player)
							   elseif tonumber(id) == 6 then	
							   --local team = getTeamFromName("Las Venturas Army")
	                           --setPlayerTeam(player, team)
		                       setElementData(player, "Должность", "Старшина")
							   setElementModel ( player, 312 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlayerName(player).." на Старшину.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlayerName(thePlayer).." на Старшину.", player)
							   elseif tonumber(id) == 7 then	
							   --local team = getTeamFromName("Las Venturas Army")
	                           --setPlayerTeam(player, team)
		                       setElementData(player, "Должность", "Прапорщик")
							   setElementModel ( player, 312 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlayerName(player).." на Прапорщика.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlayerName(thePlayer).." на Прапорщика.", player)
							   elseif tonumber(id) == 8 then	
							   --local team = getTeamFromName("Las Venturas Army")
	                           --setPlayerTeam(player, team)
		                       setElementData(player, "Должность", "Младший Лейтенант")
							   setElementModel ( player, 312 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlayerName(player).." на Младшего Лейтенанта.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlayerName(thePlayer).." на Младшего Лейтенанта.", player)
							   elseif tonumber(id) == 9 then	
							   --local team = getTeamFromName("Las Venturas Army")
	                           --setPlayerTeam(player, team)
		                       setElementData(player, "Должность", "Лейтенант")
							   setElementModel ( player, 312 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlayerName(player).." на Лейтенанта.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlayerName(thePlayer).." на Лейтенанта.", player)
							   elseif tonumber(id) == 10 then	
							   --local team = getTeamFromName("Las Venturas Army")
	                           --setPlayerTeam(player, team)
		                       setElementData(player, "Должность", "Старший Лейтенант")
							   setElementModel ( player, 179 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlayerName(player).." на Старшего Лейтенанта.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlayerName(thePlayer).." на Старшего Лейтенанта.", player)
							   elseif tonumber(id) == 11 then	
							   --local team = getTeamFromName("Las Venturas Army")
	                           --setPlayerTeam(player, team)
		                       setElementData(player, "Должность", "Капитан")
							   setElementModel ( player, 179 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlayerName(player).." на Капитана.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlayerName(thePlayer).." на Капитана.", player)
							   elseif tonumber(id) == 12 then	
							   --local team = getTeamFromName("Las Venturas Army")
	                           --setPlayerTeam(player, team)
		                       setElementData(player, "Должность", "Майор")
							   setElementModel ( player, 179 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlayerName(player).." на Майора.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlayerName(thePlayer).." на Майора.", player)
							   elseif tonumber(id) == 13 then	
							   --local team = getTeamFromName("Las Venturas Army")
	                           --setPlayerTeam(player, team)
		                       setElementData(player, "Должность", "Подполковник")
							   setElementModel ( player, 255 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlayerName(player).." на Подполковника.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlayerName(thePlayer).." на Подполковника.", player)
							   elseif tonumber(id) == 14 then	
							   --local team = getTeamFromName("Las Venturas Army")
	                           --setPlayerTeam(player, team)
		                       setElementData(player, "Должность", "Полковник")
							   setElementModel ( player, 255 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlayerName(player).." на Полковника.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlayerName(thePlayer).." на Полковника.", player)
							   else
							   outputChatBox ("Неправильный номер ранга", thePlayer)
						   end
						   else
						   outputChatBox ("Этот игрок не состоит в этой фракции.", thePlayer,255, 100 ,100)
                     end
				end	 
          end
end
end
end
addEventHandler("CommmandHandler", getRootElement(), rank )			   
addCommandHandler( "rank", rank)

local tableWSkin = {23,52,62}
addCommandHandler ("changeskin", function(pl, _, id, skin)
if isPlayerPolice (pl) then
	if getPoliceRank (pl) > 10 then
		if not tonumber (id) then return end
		if not tonumber (skin) then return end
		if tonumber(skin) < 0 or tonumber(skin) > #tableWSkin then return end
		local target = getPlayerFromID (tonumber(id))
		if getElementData (target, "Pol") ~= "Woman" then return end
		setElementModel (target, tableWSkin[tonumber(skin)])
		outputChatBox ("Вы поставили сотруднице "..getPlayerName(target).." скин", pl, 0, 255, 0)
	end
end
end)

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

function isPlayerPolice (pl)
if getElementData (pl, "frac") == "LVA" then
	return true
else
	return false
end
end

function getPoliceRank (pl)
local rank = 0
if isPlayerPolice (pl) then
	if getElementData(pl, "Должность") == "Рядовой" then
	rank = 1
	elseif getElementData(pl, "Должность") == "Ефрейтор" then
	rank = 2
	elseif getElementData(pl, "Должность") == "Младший Сержант" then
	rank = 3
	elseif getElementData(pl, "Должность") == "Сержант" then
	rank = 4
	elseif getElementData(pl, "Должность") == "Старший Сержант" then
	rank = 5
	elseif getElementData(pl, "Должность") == "Старшина" then
	rank = 6
	elseif getElementData(pl, "Должность") == "Прапорщик" then
	rank = 7
	elseif getElementData(pl, "Должность") == "Младший Лейтенант" then
	rank = 8
	elseif getElementData(pl, "Должность") == "Лейтенант" then
	rank = 9
	elseif getElementData(pl, "Должность") == "Старший Лейтенант" then
	rank = 10
	elseif getElementData(pl, "Должность") == "Капитан" then
	rank = 11
	elseif getElementData(pl, "Должность") == "Майор" then
	rank = 12
	elseif getElementData(pl, "Должность") == "Подполковник" then
	rank = 13
	elseif getElementData(pl, "Должность") == "Полковник" then
	rank = 14
	elseif getElementData(pl, "Должность") == "Генерал" then
	rank = 15
	end
end
return rank
end