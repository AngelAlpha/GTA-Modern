function servetime ()
  servertime = getRealTime ()
  hours = servertime.hour
  minutes = string.format("%02d", servertime.minute)
  second = string.format("%02d", servertime.second)
end
setTimer (servetime, 1000, 0)


function factionChatNews (thePlayer, cmd, ...)
if  getElementData(thePlayer, "Должность") == "Шериф" or getElementData(thePlayer, "Должность") == "Помощник Шерифа" then
    if ... then
	local message = table.concat({...}, " ")
		  outputChatBox ("[Новости] "..getPlName(thePlayer)..": "..message, root,0,205,0)
     end
	 end
end	 
addEventHandler("CommmandHandler", getRootElement(),factionChatNews )
addCommandHandler ("news", factionChatNews)

function megafon(thePlayer, cmd, ...)
local message = table.concat({...}, " ")
local veh = getPedOccupiedVehicle(thePlayer)
local id = getElementModel(veh)
local cars = {[416] = true, [597] = true, [599] = true, [490] = true, [598] = true, [596] = true, [585] = true}  
 if cars[id] then
   if message then
      for i,v in pairs (getElementsByType("player")) do
        local x,y,z = getElementPosition(thePlayer)
        local xa,ya,za = getElementPosition(v)
          if getDistanceBetweenPoints3D(x,y,z,xa,ya,za) < 40 then
            outputChatBox ("[Мегафон] "..getPlName(thePlayer)..": "..message, v)
		  end
	  end	  
   end
 end  
end
addEventHandler("CommmandHandler", getRootElement(), megafon )
addCommandHandler ("m", megafon)

function getPlayerFromID ( id )
        for k, player in ipairs ( getElementsByType ( "player" ) ) do
                local p_id = getElementData ( player, "ID" )
                if ( p_id == tonumber(id) ) then
                        player_n = getPlName ( player )
                        return player, player_n
                end
        end
                return false, "No player has been found with the ID " .. id .. "."
end

local skins = {
 [267] = 267,
 [280] = 280,
 [281] = 281,
 [282] = 282,
 [283] = 283,
 [288] = 288,
 [285] = 285
}      
   
     
    function money ()
      for i, thePlayer in pairs (getElementsByType("player")) do
	  local playeraccount = getPlayerAccount ( thePlayer )
           if getElementData(thePlayer, "Должность") == "Кадет" then  
                givePlayerMoney (100, thePlayer)
                outputChatBox ("Вам зачислена зарплата - 100$", thePlayer)
            elseif getElementData(thePlayer, "Должность") == "Офицер Полиции" then
                givePlayerMoney(thePlayer,200)
                outputChatBox ("Вам зачислена зарплата - 200$", thePlayer)
            elseif getElementData(thePlayer, "Должность") == "Детектив" then  
                givePlayerMoney(thePlayer,300)
                outputChatBox ("Вам зачислена зарплата - 300$", thePlayer)
             elseif getElementData(thePlayer, "Должность") == "Младший Сержант Полиции" then
                givePlayerMoney(thePlayer,400)
                outputChatBox ("Вам зачислена зарплата - 400$", thePlayer)
            elseif getElementData(thePlayer, "Должность") == "Сержант Полиции" then  
                givePlayerMoney(thePlayer,500)
                outputChatBox ("Вам зачислена зарплата - 500$", thePlayer)
            elseif getElementData(thePlayer, "Должность") == "Старший Сержант Полиции" then
                givePlayerMoney(thePlayer,600)
                outputChatBox ("Вам зачислена зарплата - 600$", thePlayer)
            elseif getElementData(thePlayer, "Должность") == "Лейтенант Полиции" then
                givePlayerMoney(thePlayer,700)
                outputChatBox ("Вам зачислена зарплата - 700$", thePlayer) 
            elseif getElementData(thePlayer, "Должность") == "Капитан Полиции" then
                givePlayerMoney(thePlayer,800)
                outputChatBox ("Вам зачислена зарплата - 800$", thePlayer) 
            elseif getElementData(thePlayer, "Должность") == "Инспектор" then
                givePlayerMoney(thePlayer,900)
                outputChatBox ("Вам зачислена зарплата - 900$", thePlayer) 
              elseif getElementData(thePlayer, "Должность") == "Майор Полиции" then
                givePlayerMoney(thePlayer,1000)
                outputChatBox ("Вам зачислена зарплата - 1000$", thePlayer) 	
               elseif getElementData(thePlayer, "Должность") == "Комиссар Полиции" then
                givePlayerMoney(thePlayer,1100)
                outputChatBox ("Вам зачислена зарплата - 1100$", thePlayer)
              elseif getElementData(thePlayer, "Должность") == "Шеф Полиции" then
                givePlayerMoney(thePlayer,1200)
                outputChatBox ("Вам зачислена зарплата - 1200$", thePlayer)
              elseif getElementData(thePlayer, "Должность") == "Помощник Полиции" then
                givePlayerMoney(thePlayer,1300)
                outputChatBox ("Вам зачислена зарплата - 1300$", thePlayer)		
              elseif getElementData(thePlayer, "Должность") == "Шериф" then
                givePlayerMoney(thePlayer,1400)
                outputChatBox ("Вам зачислена зарплата - 1400$", thePlayer)					
            end
        end
	 end	
    setTimer (money, 1800000, 0)
	

     
function wanteds(thePlayer, cmd)
	local acc = getPlayerAccount(thePlayer)
	local fac = getAccountData(acc,"Faction") or 0
		if getElementData (thePlayer, "frac") == "LSPD" then
			outputChatBox("#ADFF2F["..hours..":"..minutes..":"..second.."] Список разыскиваемых:", thePlayer)
			for i, v in ipairs(getElementsByType("player")) do
				if getPlayerWantedLevel(v) >= 1 then
					local wanted = getPlayerWantedLevel(v)
					outputChatBox("Преступник: "..getPlName(v).." - Уровень розыска: "..wanted.."", thePlayer)
				end
			end
		end
	end
addEventHandler("CommmandHandler", getRootElement(), wanteds )	
addCommandHandler("wanteds", wanteds, false, false)

function wanted (thePlayer, cmd, target, id, ...)
 if tonumber(id) > 0 then
    local message = table.concat({...}, " ")
	local acc = getPlayerAccount(thePlayer)
	local fac = getAccountData(acc,"Faction") or 0
	local player = getPlayerFromID (tonumber(target))
	  if (player) then
		if getElementData (thePlayer, "frac") == "LSPD" then
		 if tonumber(id) <= 6 then
			setPlayerWantedLevel (player, id)
			setElementData (player, "wanted:reason", message)
			triggerEvent ("database", root, "add", _, player, id, message)
			outputChatBox("Подал в розыск: "..getPlName(thePlayer).." - Преступник: "..getPlName(player).." - Уровень розыска: "..id.." - Причина: "..message, root, 220,20,60)
		 end	
				end
			end
		end
	end
addEventHandler("CommmandHandler", getRootElement(), wanted )	
addCommandHandler ("su", wanted, false, false)

----


function portjail(thePlayer)
	takeAllWeapons(thePlayer)
	setPlayerWantedLevel(thePlayer,0)
	setElementInterior (thePlayer , 6)
	setElementDimension (thePlayer , 1)
	setElementPosition(thePlayer , 264.20001220703, 77.599998474121, 1001)
	local blip = getElementData (thePlayer, "police:blip")
	if isElement (blip) then
	destroyElement(blip)
	end
	setElementFrozen (thePlayer, false)
	setElementData (thePlayer, "cuff", false)
	for i, v in ipairs (controlTable) do
		toggleControl (thePlayer, v, true)
	end
end

function portoutjail(thePlayer)
	setElementInterior (thePlayer , 0)
	setElementDimension (thePlayer , 0)
	setElementPosition(thePlayer , 1542.4000244141, -1681.8000488281, 13.60000038147)
end

local arrestcolshape = createMarker ( 268.29998779297, 77.599998474121, 1000, "cylinder", 1.5, 200, 0, 0, 50 )
setElementInterior (arrestcolshape , 6)
setElementDimension (arrestcolshape , 1)


local col = createColCuboid (1524.88599, -1681.58362, 5, 9, 9, 9)
function jail(theCop, Command, target)
if isElement (theCop) then outputChatBox ("Выйдите из машины!", theCop, 255, 0, 0) return end
	local acc = getPlayerAccount(theCop)
	local fac = getAccountData(acc,"Faction") or 0
	local targetplayer = getPlayerFromID (tonumber(target))
	local wantedlevel  = getPlayerWantedLevel(targetplayer)
	if not isElementWithinColShape (targetplayer, col) then outputChatBox ("Садить можно только на определенной территории", theCop, 255, 0, 0) return end
	if getElementData (theCop, "frac") == "LSPD" then   
		if wantedlevel >= 1 then
			local player = getPlayerFromID (tonumber(target))
	          if (player) then
				local knastzeit = wantedlevel*5
				setAccountData(getPlayerAccount(targetplayer), "Jailtime", knastzeit)
				portjail(targetplayer)
				outputChatBox("Вас посадил "..getPlName(theCop).." на "..tonumber(knastzeit).." минут в тюрьму.", targetplayer)
				outputChatBox("Вы посадили преступника "..getPlName(targetplayer).." на "..tonumber(knastzeit).." минут в тюрьму.", theCop)
				triggerEvent ("database", root, "remove", _, player)
				
				--if getElementData (targetplayer, "blipTarget") then
				--end
			end
		end
	end
end
addEventHandler("CommmandHandler", getRootElement(), jail )
addCommandHandler("jail", jail)

function SetJailTime()
    for theKey,thePlayer in ipairs(getElementsByType ( "player" )) do
        local acc = getPlayerAccount( thePlayer )
        if not isGuestAccount( acc ) and tonumber( getAccountData(getPlayerAccount(thePlayer), "Jailtime") ) then
            local jailtime = getAccountData(getPlayerAccount(thePlayer), "Jailtime" )
            if tonumber(jailtime) > 0 then
                setAccountData ( getPlayerAccount(thePlayer), "Jailtime", jailtime - 1 )
            elseif tonumber(jailtime) == 0 then
                portoutjail(thePlayer)
                setAccountData(getPlayerAccount(thePlayer), "Jailtime", false)
            end
        end
    end
end
setTimer ( SetJailTime, 60000, 0 )

addCommandHandler ("unjail", function(pl, _, id)
if not tonumber(id) then return end
local targetplayer = getPlayerFromID (tonumber(id))
if not targetplayer then return end
local pos1 = Vector3(getElementPosition (pl))
local pos2 = Vector3(getElementPosition (targetplayer))
if getDistanceBetweenPoints3D (pos1, pos2) > 10 then outputChatBox ("Вы слишком далеко", pl, 255, 0, 0) return end
portoutjail(targetplayer)
setAccountData(getPlayerAccount(targetplayer), "Jailtime", false)
end)

function showtime(thePlayer, cmd)
	local jailtime = getAccountData(getPlayerAccount(thePlayer), "Jailtime")
	outputChatBox("Вам осталось "..tonumber(jailtime).." минут(а/ы) в тюрьме.", thePlayer)
end
addEventHandler("CommmandHandler", getRootElement(), showtime )
addCommandHandler("jailtime", showtime)	
	
cop = {}
amount = {}

function ticket (thePlayer, cmd, target, price, message)
 local price = tonumber(price)
 local playeraccount = getPlayerAccount ( thePlayer )
 local fac = getAccountData(playeraccount,"Faction") or 0
  if getElementData (thePlayer, "frac") == "LSPD" then
    local player = getPlayerFromID( tonumber(target) )
	   if (player) then
	    if price < 1001 then
		if message then
	    local x,y,z = getElementPosition (thePlayer)
	    if getDistanceBetweenPoints3D (x,y,z,getElementPosition(player)) <= 5 then
	     outputChatBox ("Вы выставили игроку "..getPlName(player).." штраф на сумму "..price.."$. Причина: "..message, thePlayer )
	     rootTicket (player,thePlayer, price, message)
		else
		outputChatBox ("Нарушитель слишком далеко от вас находится!", thePlayer,255,0,0 )
		end	
		else
outputChatBox ("Вы не указали причину штрафа!", thePlayer,255,0,0 )	
        end	
else
outputChatBox ("Слишком большая сумма для штрафа! Максимальная, разрешённая сумма: 1000$", thePlayer,255,0,0 )		
		end
       end
	end 
end
addEventHandler("CommmandHandler", getRootElement(), ticket )	 
addCommandHandler ("ticket", ticket, false, false)

function rootTicket (target, police, price, message)
 outputChatBox (""..getPlName(police).." выставил вам штраф на "..price.."$ по причине: "..message..". Если вы хотите оплатит штраф пропишите команду /accept", target )
 cop[target] = police
  amount[amount] = price
end

function acceptTicket (target, cmd)
if cop[target] then
 takePlayerMoney (target, amount[amount])
 givePlayerMoney(cop[target], amount[amount])
 outputChatBox ("Вы оплатили штраф.", target)
 outputChatBox (""..getPlName(target).." оплатил штраф.", cop[target])
 cop[target] = nil
 amount[amount] = nil
end 
end
addEventHandler("CommmandHandler", getRootElement(), acceptTicket )
addCommandHandler ("accept", acceptTicket, false, false)	

function playerVeh (pl, cmd, id)
if not tonumber (id) then return end
if not isPedInVehicle (pl) then return end
local target = getPlayerFromID(tonumber(id))
if cmd == "spl" then
	if isPedInVehicle (target) then return end
	if not getElementData (target, "cuff") then return end
	local pos1 = Vector3(getElementPosition (pl))
	local pos2 = Vector3(getElementPosition (target))
	if getDistanceBetweenPoints3D (pos1, pos2) > 10 then outputChatBox ("Вы слишком далеко", pl, 255, 0, 0) return end
	local seat = getFreeSeat (getPedOccupiedVehicle (pl))
	warpPedIntoVehicle (target, getPedOccupiedVehicle(pl), seat)
elseif cmd == "kpl" then
	if not isPedInVehicle (target) then return end
	removePedFromVehicle (target)
end
end
addCommandHandler ("spl", playerVeh)
addCommandHandler ("kpl", playerVeh)

function invite (thePlayer, cmd, target, id)
if thePlayer and isElement(thePlayer) then 
		  local accountplayer = getPlayerAccount(thePlayer)
          local accName = getAccountName (accountplayer)
        if  getElementData(thePlayer, "Должность") == "Шериф" or getElementData(thePlayer, "Должность") == "Помощник Шерифа" then
			   if target then
	               local player = getPlayerFromID(tonumber(target))		   
			         if player and isElement(player) then
					   local account = getPlayerAccount(player)
                       local oFaction = getAccountData(account, "Faction") or 0	
		                  if getElementData(player, "Должность") == "Шериф" or getElementData(player, "Должность") == "Помощник Шерифа" then 
		                  outputChatBox ( "Вы не можете принять во фракцию самого себя", thePlayer, 255, 100 ,100 )
		                  return
		                  end					   
						                             if getElementData(player, "Должность") == "Безработный" then	
                              if tonumber(oFaction) == nil or 0 then
							   setAccountData (getPlayerAccount (player), "prevSkin", getElementModel (player))
							   setElementData(player, "frac", "LSPD")
		                       setElementData(player, "Должность", "Кадет")
							   setElementData (player, "Job", "Полиция")
							   setPlayerNametagColor(player, 0,0,200)
							   setElementModel ( player, 265 )
							   
                               outputChatBox ("Вы приняли "..getPlName(player).." во фракцию LSPD.", thePlayer)
						      outputChatBox ("Вас принял "..getPlName(thePlayer).." во фракцию LSPD.", player)
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
        if  getElementData(thePlayer, "Должность") == "Шериф" or getElementData(thePlayer, "Должность") == "Помощник Шерифа" then
			   if target then
	               local player = getPlayerFromID(tonumber(target))		   
			         if player and isElement(player) then
					   local account = getPlayerAccount(player)
                       local oFaction = getAccountData(account, "Faction") or 0	
		                  if getElementData(player, "Должность") == "Шериф" then 
		                  outputChatBox ( "Вы не можете изгнать из фракции самого себя", thePlayer, 255, 100 ,100 )
		                  return
		                  end				
						if getElementData (player, "frac") == "LSPD" then							  
                              if tonumber(oFaction) == nil or 0 then
							   setElementData(player, "frac", "Безработный")
		                       setElementData(player, "Должность", "Безработный")
							   setElementData (player, "Job", "Безработный")
							   setElementModel ( player, getAccountData (getPlayerAccount (player), "prevSkin") or 0)
							   setPlayerNametagColor(player, 255,215,0)
                               outputChatBox ("Вы изгнали "..getPlName(player).." из фракции LSPD.", thePlayer)
						       outputChatBox ("Вас изгнал "..getPlName(thePlayer).."из фракции LSPD.", player)
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
         if  getElementData(thePlayer, "Должность") == "Шериф" or getElementData(thePlayer, "Должность") == "Помощник Шерифа" then
			   if target then
	               local player = getPlayerFromID(tonumber(target))		   
			         if player and isElement(player) then
					   local account = getPlayerAccount(player)
                       local oFaction = getAccountData(account, "Faction") or 0	
                          if getElementData(player, "Должность") == "Шериф" then 
		                  outputChatBox ( "Вы не можете изменить ранг самому себе", thePlayer, 255, 100 ,100 )
		                  return
		                  end		
                             if getElementData (player, "frac") == "LSPD" then				  
                             if tonumber(id) == 1 then					   
							   --local team = getTeamFromName("Los Santos Police Department")
	                           --setPlayerTeam(player, team)
							   setElementData(player, "frac", "LSPD")
		                       setElementData(player, "Должность", "Кадет")
							   setElementModel ( player, 265 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlName(player).." на Кадета.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlName(thePlayer).." на Кадета.", player)
							 elseif tonumber(id) == 2 then	
							   setElementData(player, "frac", "LSPD")
		                       setElementData(player, "Должность", "Офицер Полиции")
							   setElementModel ( player, 280 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlName(player).." на Офицера Полиции.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlName(thePlayer).." на Офицера Полиции.", player)
							   elseif tonumber(id) == 3 then	
							   setElementData(player, "frac", "LSPD")
		                       setElementData(player, "Должность", "Детектив")
							   setElementModel ( player, 281 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlName(player).." на Детектива.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlName(thePlayer).." на Детектива.", player)
							   elseif tonumber(id) == 4 then	
							   setElementData(player, "frac", "LSPD")
		                       setElementData(player, "Должность", "Младший Сержант Полиции")
							   setElementModel ( player, 281 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlName(player).." на Младшего Сержанта Полиции.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlName(thePlayer).." на Младшего Сержанта Полиции.", player)
							   elseif tonumber(id) == 5 then	
							   setElementData(player, "frac", "LSPD")
		                       setElementData(player, "Должность", "Сержант Полиции")
							   setElementModel ( player, 266 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlName(player).." на Сержанта Полиции.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlName(thePlayer).." на Сержанта Полиции.", player)
							   elseif tonumber(id) == 6 then	
							   setElementData(player, "frac", "LSPD")
		                       setElementData(player, "Должность", "Старший Сержант Полиции")
							   setElementModel ( player, 266 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlName(player).." на Старшего Сержанта Полиции.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlName(thePlayer).." на Старшего Сержанта Полиции.", player)
							   elseif tonumber(id) == 7 then	
							   setElementData(player, "frac", "LSPD")
		                       setElementData(player, "Должность", "Лейтенант Полиции")
							   setElementModel ( player, 267 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlName(player).." на Лейтенанта Полиции.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlName(thePlayer).." на Лейтенанта Полиции.", player)
							   elseif tonumber(id) == 8 then	
							   setElementData(player, "frac", "LSPD")
		                       setElementData(player, "Должность", "Капитан Полиции")
							   setElementModel ( player, 267 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlName(player).." на Капитана Полиции.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlName(thePlayer).." на Капитана Полиции.", player)
							   elseif tonumber(id) == 9 then	
							   setElementData(player, "frac", "LSPD")
		                       setElementData(player, "Должность", "Инспектор")
							   setElementModel ( player, 282 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlName(player).." на Инспектора.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlName(thePlayer).." на Инспектора.", player)
							   elseif tonumber(id) == 10 then	
							   setElementData(player, "frac", "LSPD")
		                       setElementData(player, "Должность", "Майор Полиции")
							   setElementModel ( player, 282 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlName(player).." на Майора Полиции.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlName(thePlayer).." на Майора Полиции.", player)
							   elseif tonumber(id) == 11 then	
							   setElementData(player, "frac", "LSPD")
		                       setElementData(player, "Должность", "Комиссар Полиции")
							   setElementModel ( player, 282 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlName(player).." на Комиссара Полиции.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlName(thePlayer).." на Комиссара Полиции.", player)
							   elseif tonumber(id) == 12 then	
							   setElementData(player, "frac", "LSPD")
		                       setElementData(player, "Должность", "Шеф Полиции")
							   setElementModel ( player, 283 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlName(player).." на Шефа Полиции.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlName(thePlayer).." на Шефа Полиции.", player)
							   elseif tonumber(id) == 13 then	
							   setElementData(player, "frac", "LSPD")
		                       setElementData(player, "Должность", "Помощник Шерифа")
							   setElementModel ( player, 283 )
                               outputChatBox ("Вы изменили ранг игрока "..getPlName(player).." на Помощника Шерифа.", thePlayer)
						       outputChatBox ("Ваш ранг изменил "..getPlName(thePlayer).." на Помощника Шерифа.", player)
							   else
							   outputChatBox ("Неправильный номер ранга", thePlayer)
						   end
						   else
						   outputChatBox ("Этот игрок не состоит в этой фракции.", thePlayer)
                     end
				end	 
          end
end
end
end
addEventHandler("CommmandHandler", getRootElement(), rank )			   
addCommandHandler( "rank", rank)


function getPlName (name)
local name = removeHex (getPlayerName(name))
return name
end

local caller
local accepter
local timer
function call (pl)
outputChatBox ("Вы позвонили в полицию, ожидайте...", pl, 255, 200, 0)
caller = pl
for i, v in ipairs (getElementsByType ("player")) do
	if getElementData (v, "Job") == "Полиция" then
		outputChatBox ("[Диспетчер] Игрок "..removeHex(getPlayerName(pl), 6).." вызывает полицию!",v, 255, 200, 0)
		outputChatBox ("[Диспетчер] Чтобы принять вызов /accept",v, 255, 200, 0)
	end
end
	timer = setTimer (function () 
	if not getElementData (pl, "police:accepter") then
		caller = nil 
		outputChatBox ("Никто не принял вызов, перезвоните позже...", pl, 255, 200, 0)
	end
	end, 
	1000*60*2, 1)
end
addCommandHandler ("call02", call)

function accept (pl)
accepter = pl
if caller ~= nil then
	local x, y, z = getElementPosition (caller)
	setElementData (caller, "police:coll", createColSphere (x, y, z, 15))
	setElementData (caller, "police:blips", createBlipAttachedTo (caller, 41, _, _, _, _, _, _, 200000, accepter))
	setElementData (caller, "police:accepter", accepter)
else
	outputChatBox ("В данный момент нету вызовов", pl, 255, 200, 0)
end
end
addCommandHandler ("accept", accept)

addEventHandler ("onColShapeHit", root, function(el)
if getElementType (el) == "vehicle" then
	el = getVehicleOccupant (el)
end
if getElementData (el, "Job") ~= "Полиция" then return end
for i, v in ipairs (getElementsByType ("player")) do
	if v ~= el then
		if getElementData (v, "police:accepter") == el then
			destroyElement(getElementData (v, "police:coll"))
			destroyElement(getElementData (v, "police:blips"))
			removeElementData (v, "police:accepter")
			accepter = nil
			caller = nil
		end
	end
end
end)

function removeHex(text, digits)
    assert(type(text) == "string", "Bad argument 1 @ removeHex [String expected, got " .. tostring(text) .. "]")
    --assert(digits == nil or (type(digits) == "number" and digits > 0), "Bad argument 2 @ removeHex [Number greater than zero expected, got " .. tostring(digits) .. "]")
    return string.gsub(text, "#" .. (6 and string.rep("%x", 6) or "%x+"), "")
end