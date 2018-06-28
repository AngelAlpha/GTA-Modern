function servetime ()
  servertime = getRealTime ()
  hours = servertime.hour
  minutes = string.format("%02d", servertime.minute)
  second = string.format("%02d", servertime.second)
end
setTimer (servetime, 1000, 0)

function factionChatNews (thePlayer, cmd, ...)
if  getElementData(thePlayer, "Должность") == "Главный Врач" or getElementData(thePlayer, "Должность") == "Заместитель Главного Врача" then
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
           if getElementData(thePlayer, "Должность") == "Интерн" then  
                givePlayerMoney (thePlayer, 100)
                outputChatBox ("Вам зачислена зарплата - 100$", thePlayer)
            elseif getElementData(thePlayer, "Должность") == "Санитар" then
                givePlayerMoney(thePlayer,200)
                outputChatBox ("Вам зачислена зарплата - 200$", thePlayer)
            elseif getElementData(thePlayer, "Должность") == "Медбрат" then  
                givePlayerMoney(thePlayer,300)
                outputChatBox ("Вам зачислена зарплата - 300$", thePlayer)
             elseif getElementData(thePlayer, "Должность") == "Спасатель" then
                givePlayerMoney(thePlayer,400)
                outputChatBox ("Вам зачислена зарплата - 400$", thePlayer)
            elseif getElementData(thePlayer, "Должность") == "Нарколог" then  
                givePlayerMoney(thePlayer,500)
                outputChatBox ("Вам зачислена зарплата - 500$", thePlayer)
            elseif getElementData(thePlayer, "Должность") == "Доктор" then
                givePlayerMoney(thePlayer,600)
                outputChatBox ("Вам зачислена зарплата - 600$", thePlayer)
            elseif getElementData(thePlayer, "Должность") == "Психолог" then
                givePlayerMoney(thePlayer,700)
                outputChatBox ("Вам зачислена зарплата - 700$", thePlayer) 
            elseif getElementData(thePlayer, "Должность") == "Хирург" then
                givePlayerMoney(thePlayer,800)
                outputChatBox ("Вам зачислена зарплата - 800$", thePlayer) 
            elseif getElementData(thePlayer, "Должность") == "Заместитель Главного Врача" then
                givePlayerMoney(thePlayer,900)
                outputChatBox ("Вам зачислена зарплата - 900$", thePlayer) 
              elseif getElementData(thePlayer, "Должность") == "Главный Врач" then
                givePlayerMoney(thePlayer,1000)
                outputChatBox ("Вам зачислена зарплата - 1000$", thePlayer) 						
            end
        end
	 end	
    setTimer (money, 1800000, 0)



--[[function buildpVehCHOP001icle ()
  pVehCHOP001icle = createVehicle (416, 1180.0279541016, -1308.5598144531, 13.814081192017, 0, 0, 270, "HLS001")
  setVehicleLocked (pVehCHOP001icle, true)
  setVehicleColor (pVehCHOP001icle, 255,255,255,150,0,0)
end
addEventHandler ("onResourceStart", getResourceRootElement(getThisResource()), buildpVehCHOP001icle)

function playerCarLock(source, cmd)
		local x, y, z = getElementPosition(source)
			if getDistanceBetweenPoints3D ( x, y, z, getElementPosition ( pVehCHOP001icle ) ) < 3 then
			if getElementData(source, "KluchHLS001") == true then
                if not (isVehicleLocked(pVehCHOP001icle)) then    
                    setVehicleLocked(pVehCHOP001icle, true)
                else
                    setVehicleLocked(pVehCHOP001icle, false)
                end 			
								else
				     outputChatBox ("У вас нет ключей от этого автомобиля", source) 
            end
        end
    end
addEventHandler("CommmandHandler", getRootElement(), playerCarLock )
addCommandHandler("lock", playerCarLock)

function engine(source, cmd)
        if (getPedOccupiedVehicle(source) == pVehCHOP001icle) then
      if getElementData(source, "KluchHLS001") == true then
            if (getVehicleEngineState(pVehCHOP001icle) == false) then
                setVehicleEngineState(pVehCHOP001icle, true)
            else
                setVehicleEngineState(pVehCHOP001icle, false)
            end			
							else
				     outputChatBox ("У вас нет ключей от этого автомобиля", source) 
            end			
        end    
    end    

addEventHandler("CommmandHandler", getRootElement(), engine )
addCommandHandler("engine", engine)

setTimer(function ()
		if isElementInWater (pVehCHOP001icle) then
        setTimer(respawnVehicle, 3000, 1, pVehCHOP001icle)
		setVehicleEngineState (pVehCHOP001icle, false)
		setVehicleLocked (pVehCHOP001icle, true)
		setVehicleOverrideLights (pVehCHOP001icle,1)
        end	   
end, 30000, 0)
		 
		 
function engine001(source)
        if (getPedOccupiedVehicle(source) == pVehCHOP001icle) and getTeamName (getPlayerTeam (source)) == "Hospital Los Santos" then
		if getElementData(source, "KluchHLS001") == true then
            if (getVehicleEngineState(pVehCHOP001icle) == false) then
                setVehicleEngineState(pVehCHOP001icle, true)
            else
                setVehicleEngineState(pVehCHOP001icle, false)
            end
        end    
    end    	
end	

function bindENGINELSPD001()
bindKey (source, "2", "up", engine001)
bindKey (source, "N", "up", lock001)
end
addEventHandler ("onPlayerLogin", root, bindENGINELSPD001)

function lock001(source, cmd)
		local x, y, z = getElementPosition(source)
			if getDistanceBetweenPoints3D ( x, y, z, getElementPosition ( pVehCHOP001icle ) ) < 3 then
			if getElementData(source, "KluchHLS001") == true then
                if not (isVehicleLocked(pVehCHOP001icle)) then    
                    setVehicleLocked(pVehCHOP001icle, true)
                else
                    setVehicleLocked(pVehCHOP001icle, false)
                end 			
								else
				     outputChatBox ("У вас нет ключей от этого автомобиля", source) 
            end
        end
    end

iEngine = {}

function engineTimer ( )
	  if not getVehicleOccupant(pVehCHOP001icle) then
	   iEngine[pVehCHOP001icle] = getVehicleEngineState (pVehCHOP001icle)
		end
	end
setTimer (engineTimer, 500, 0)

function engineOnEnter ( )
      if pVehCHOP001icle == source then
	 setVehicleEngineState(pVehCHOP001icle,iEngine[pVehCHOP001icle])
		end
    end
addEventHandler ("onVehicleEnter", root, engineOnEnter)

function respawn(source)
  respawnVehicle (pVehCHOP001icle)
  setVehicleEngineState(pVehCHOP001icle, false)
  setVehicleOverrideLights ( pVehCHOP001icle, 1 )
  setVehicleLocked (pVehCHOP001icle, true)
  end
addEvent("DestroyvehicleHLS001",true)
addEventHandler("DestroyvehicleHLS001",getRootElement(),respawn)

   addEventHandler("onVehicleExplode", resourceRoot,
         function ()
              setTimer(respawnVehicle, 3000, 1, source)
         end
    )]]--
	
	
cop = {}
amount = {}


function invite (thePlayer, cmd, target, id)
if thePlayer and isElement(thePlayer) then 
		  local accountplayer = getPlayerAccount(thePlayer)
          local accName = getAccountName (accountplayer)
        if  getElementData(thePlayer, "Должность") == "Главный Врач" or getElementData(thePlayer, "Должность") == "Заместитель Главного Врача" then
			   if target then
	               local player = getPlayerFromID(tonumber(target))		   
			         if player and isElement(player) then
					   local account = getPlayerAccount(player)
                       local oFaction = getAccountData(account, "Faction") or 0	
		                  if getElementData(player, "Должность") == "Главный Врач" or getElementData(player, "Должность") == "Главный Врач" then 
		                  outputChatBox ( "Вы не можете принять во фракцию самого себя", thePlayer, 255, 100 ,100 )
		                  return
		                  end					   
						     if not getElementData(player, "Job") or getElementData(player, "Job") == "Безработный" then	
                              if tonumber(oFaction) == nil or 0 then
								setAccountData (getPlayerAccount (player), "prevSkin", getElementModel (player))
								setElementData (player, "frac", "HLS")
		                       setElementData(player, "Должность", "Интерн")
							   setElementData (player, "Job", "Медик")
							   setElementModel ( player, 274 )
							   setPlayerNametagColor(player, 105,139,34)
                               outputChatBox ("Вы приняли "..getPlayerName(player).." во фракцию Hospital Los Santos.", thePlayer)
						       outputChatBox ("Вас принял "..getPlayerName(thePlayer).." во фракцию Hospital Los Santos.", player)
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
        if  getElementData(thePlayer, "Должность") == "Главный Врач" or getElementData(thePlayer, "Должность") == "Заместитель Главного Врача" then
			   if target then
	               local player = getPlayerFromID(tonumber(target))		   
			         if player and isElement(player) then
					   local account = getPlayerAccount(player)
                       local oFaction = getAccountData(account, "Faction") or 0	
		                  if getElementData(player, "Должность") == "Главный Врач" then 
		                  outputChatBox ( "Вы не можете изгнать из фракции самого себя", thePlayer, 255, 100 ,100 )
		                  return
		                  end				
                   if getElementData (player, "frac") == "HLS" then							  
                              if tonumber(oFaction) == nil or 0 then
								setElementData(player, "frac", "Безработный")
		                       setElementData(player, "Должность", "Безработный")
							   setElementData (player, "Job", "Безработный")
							   setPlayerNametagColor(player, 255,215,0)
							   setElementModel ( player, getAccountData (getPlayerAccount (player), "prevSkin") or 0)
                               outputChatBox ("Вы изгнали "..getPlayerName(player).." из фракции Hospital Los Santos.", thePlayer)
						       outputChatBox ("Вас изгнал "..getPlayerName(thePlayer).."из фракции Hospital Los Santos.", player)
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
         if  getElementData(thePlayer, "Должность") == "Главный Врач" or getElementData(thePlayer, "Должность") == "Заместитель Главного Врача" then
			   if target then
	               local player = getPlayerFromID(tonumber(target))		   
			         if player and isElement(player) then
					   local account = getPlayerAccount(player)
                       local oFaction = getAccountData(account, "Faction") or 0	
                          if getElementData(player, "Должность") == "Главный Врач" then 
		                  outputChatBox ( "Вы не можете изменить ранг самому себе", thePlayer, 255, 100 ,100 )
		                  return
		                  end		
                             if getElementData (player, "frac") == "HLS" then				  
                             if tonumber(id) == 1 then					   
							   local team = getTeamFromName("Hospital Los Santos")
							   setElementModel ( player, 274 )
	                           --setPlayerTeam(player, team)
		                       setElementData(player, "Должность", "Интерн")
                               outputChatBox ("Вы изменили ранг игрока "..getPlayerName(player).." на Интерн.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlayerName(thePlayer).." на Интерн.", player)
							 elseif tonumber(id) == 2 then	
							   local team = getTeamFromName("Hospital Los Santos")
							   setElementModel ( player, 274 )
	                           --setPlayerTeam(player, team)
		                       setElementData(player, "Должность", "Санитар")
                               outputChatBox ("Вы изменили ранг игрока "..getPlayerName(player).." на Санитар.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlayerName(thePlayer).." на Санитар.", player)
							   elseif tonumber(id) == 3 then	
							   local team = getTeamFromName("Hospital Los Santos")
	                           --setPlayerTeam(player, team)
		                       setElementData(player, "Должность", "Медбрат")
							   setElementModel ( player, 275 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlayerName(player).." на Медбрат.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlayerName(thePlayer).." на Медбрат.", player)
							   elseif tonumber(id) == 4 then	
							   local team = getTeamFromName("Hospital Los Santos")
	                           --setPlayerTeam(player, team)
		                       setElementData(player, "Должность", "Спасатель")
							   setElementModel ( player, 275 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlayerName(player).." на Спасатель.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlayerName(thePlayer).." на Спасатель.", player)
							   elseif tonumber(id) == 5 then	
							   local team = getTeamFromName("Hospital Los Santos")
	                           --setPlayerTeam(player, team)
		                       setElementData(player, "Должность", "Нарколог")
							   setElementModel ( player, 275 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlayerName(player).." на Нарколог.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlayerName(thePlayer).." на Нарколог.", player)
							   elseif tonumber(id) == 6 then	
							   local team = getTeamFromName("Hospital Los Santos")
	                           --setPlayerTeam(player, team)
		                       setElementData(player, "Должность", "Доктор")
							   setElementModel ( player, 276 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlayerName(player).." на Доктор.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlayerName(thePlayer).." на Доктор.", player)
							   elseif tonumber(id) == 7 then	
							   local team = getTeamFromName("Hospital Los Santos")
	                           --setPlayerTeam(player, team)
		                       setElementData(player, "Должность", "Психолог")
							   setElementModel ( player, 276 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlayerName(player).." на Психолог.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlayerName(thePlayer).." на Психолог.", player)
							   elseif tonumber(id) == 8 then	
							   local team = getTeamFromName("Hospital Los Santos")
	                           --setPlayerTeam(player, team)
		                       setElementData(player, "Должность", "Хирург")
							   setElementModel ( player, 276 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlayerName(player).." на Хирург.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlayerName(thePlayer).." на Хирург.", player)
							   elseif tonumber(id) == 9 then	
							   local team = getTeamFromName("Hospital Los Santos")
	                           --setPlayerTeam(player, team)
		                       setElementData(player, "Должность", "Заместитель Главного Врача")
							   setElementModel ( player, 70 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlayerName(player).." на Заместитель Главного Врача.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlayerName(thePlayer).." на Заместитель Главного Врача.", player)
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

function ticket (thePlayer, cmd, target, price, message)
if (getPedOccupiedVehicle (thePlayer) and getElementModel (getPedOccupiedVehicle(thePlayer)) == 416) or getElementDimension (thePlayer) == 1 then 
local price = tonumber(price)
local playeraccount = getPlayerAccount ( thePlayer )
local fac = getAccountData(playeraccount,"Faction") or 0
	if getElementData (thePlayer, "frac") == "HLS" then
		local player = getPlayerFromID( tonumber(target) )
		if (player) then
			local x,y,z = getElementPosition (thePlayer)
			if getDistanceBetweenPoints3D (x,y,z,getElementPosition(player)) <= 5 then
				outputChatBox ("Вы предложили игроку "..getPlayerName(player).." лечение на сумму 100$.", thePlayer )
				rootTicket (player,thePlayer, price, message)
			end
        end		
	end
else
	outputChatBox ("Лечить можно только либо находять в машине скорой помощи, либо в больнице", thePlayer, 255, 0, 0)
end
end
addEventHandler("CommmandHandler", getRootElement(), ticket )	 
addCommandHandler ("heal", ticket, false, false)

function rootTicket (target, police, price, message)
 outputChatBox ("" ..getPlayerName(police).." предлагает вам лечение на сумму 100$. Если вы хотите принять лечение пропишите команду /aheal", target )
 cop[target] = police
 amount[amount] = price
end

function acceptTicket (target, cmd)
if cop[target] then
 takePlayerMoney (target, 100)
 givePlayerMoney(cop[target], 100)
 setElementHealth(target,100)
 outputChatBox ("Вы оплатили ваше лечение.", target)
 outputChatBox ("" ..getPlayerName(target).." оплатил лечение.", cop[target])
 setPedAnimation (target)
 cop[target] = nil
 amount[amount] = nil
end 
end
addEventHandler("CommmandHandler", getRootElement(), acceptTicket )
addCommandHandler ("aheal", acceptTicket, false, false)	


function spravka (pl, _, id)
if not tonumber (id) then return end
if getElementData (pl, "frac") == "HLS" then
	local player = getPlayerFromID (id)
	setElementData (player, "spravka", true)
	outputChatBox ("Вы выдали игроку "..getPlayerName(player).." спавку", pl, 0, 255, 0)
end
end
addCommandHandler ("spravka", spravka)

local caller
local accepter
local timer
function call (pl)
outputChatBox ("Вы позвонили в госпиталь, ожидайте...", pl, 255, 200, 0)
caller = pl
for i, v in ipairs (getElementsByType ("player")) do
	if getElementData (v, "Job") == "Медик" then
		outputChatBox ("[Диспетчер] Игрок "..removeHex(getPlayerName(pl), 6).." вызывает медика!",v, 255, 200, 0)
		outputChatBox ("[Диспетчер] Чтобы принять вызов /accept",v, 255, 200, 0)
	end
end
	timer = setTimer (function () 
	if not getElementData (pl, "hls:accepter") then
		caller = nil 
		outputChatBox ("Никто не принял вызов, перезвоните позже...", pl, 255, 200, 0)
	end
	end, 
	1000*60*2, 1)
end
addCommandHandler ("call03", call)

function accept (pl)
accepter = pl
if caller ~= nil then
	local x, y, z = getElementPosition (caller)
	setElementData (caller, "hls:coll", createColSphere (x, y, z, 15))
	setElementData (caller, "hls:blips", createBlipAttachedTo (caller, 41, _, _, _, _, _, _, 200000, accepter))
	setElementData (caller, "hls:accepter", accepter)
else
	outputChatBox ("В данный момент нету вызовов", pl, 255, 200, 0)
end
end
addCommandHandler ("accept", accept)

addEventHandler ("onColShapeHit", root, function(el)
if getElementType (el) == "vehicle" then
	el = getVehicleOccupant (el)
end
if getElementData (el, "Job") ~= "Медик" then return end
for i, v in ipairs (getElementsByType ("player")) do
	if v ~= el then
		if getElementData (v, "hls:accepter") == el then
			destroyElement(getElementData (v, "hls:coll"))
			destroyElement(getElementData (v, "hls:blips"))
			removeElementData (v, "hls:accepter")
			accepter = nil
			caller = nil
		end
	end
end
end)