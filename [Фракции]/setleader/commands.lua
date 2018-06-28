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

function cancelCmd(cmdstring)
  if source then
     if cmdstring == "login" or cmdstring == "logout" then
	   cancelEvent()
	 end
  end
end
addEventHandler ("onPlayerCommand", root, cancelCmd)

function servetime ()
  servertime = getRealTime ()
  hours = servertime.hour
  minutes = string.format("%02d", servertime.minute)
  second = string.format("%02d", servertime.second)
end
setTimer (servetime, 1000, 0)

function fractionchat (ThePlayer, cmd, ...)
   local accName = getAccountName ( getPlayerAccount ( ThePlayer ) )
   local DoljnostAmount = getElementData(ThePlayer, "Должность")
     if getElementData (ThePlayer, "frac") == "LSPD" or getElementData(ThePlayer, "frac") == "HLS" or getElementData(ThePlayer, "frac") == "LVA" then
         if ... then
		   for i,v in pairs (getElementsByType("player")) do
		   local vName = getAccountName ( getPlayerAccount ( v ) )
	          if getElementData (v, "frac") == "LSPD" or getElementData(v, "frac") == "HLS" or getElementData(v, "frac") == "LVA" then	   
		       local message = table.concat({...}, " ") 
               outputChatBox("["..getElementData (ThePlayer, "frac").."]  ["..DoljnostAmount.."] "..getPlName(ThePlayer)..": "..message, v, 0,0,200)
              end		   
		   end
         end
      end
end
addCommandHandler( "dep", fractionchat)

--[[function rationchatLSPD (ThePlayer, cmd, ...)
   local accName = getAccountName ( getPlayerAccount ( ThePlayer ) )
   local DoljnostAmount = getElementData(ThePlayer, "Должность")
     if getTeamName (getPlayerTeam (ThePlayer)) == "Los Santos Police Department" then
         if ... then
		   for i,v in pairs (getElementsByType("player")) do
		   local vName = getAccountName ( getPlayerAccount ( v ) )
	          if getTeamName (getPlayerTeam (v)) == "Los Santos Police Department" then	   
		       local message = table.concat({...}, " ") 
               outputChatBox("[Рация]  ["..DoljnostAmount.."] "..getPlName(ThePlayer)..": "..message, v, 0,0,200)
              end		   
		   end
         end
      end
end
addEventHandler("CommmandHandler", getRootElement(), rationchatLSPD )
addCommandHandler( "r", rationchatLSPD)]]--

function rationchat (ThePlayer, cmd, ...)
local accName = getAccountName ( getPlayerAccount ( ThePlayer ) )
local DoljnostAmount = getElementData(ThePlayer, "Должность")
    if getElementData (ThePlayer, "frac") == "LSPD" then
        if ... then
			for i,v in pairs (getElementsByType("player")) do
				if getElementData (v, "frac") == "LSPD" then	   
					local message = table.concat({...}, " ") 
					outputChatBox("[Рация]  ["..DoljnostAmount.."] "..getPlName(ThePlayer)..": "..message, v, 0,200,0)
				end		   
			end
		end
	elseif getElementData (ThePlayer, "frac") == "HLS" then
        if ... then
			for i,v in pairs (getElementsByType("player")) do
				if getElementData (v, "frac") == "HLS" then	   
					local message = table.concat({...}, " ") 
					outputChatBox("[Рация]  ["..DoljnostAmount.."] "..getPlName(ThePlayer)..": "..message, v, 0,200,0)
				end		   
			end
        end
	elseif getElementData (ThePlayer, "frac") == "LVA" then
        if ... then
			for i,v in pairs (getElementsByType("player")) do
				if getElementData (v, "frac") == "LVA" then	   
					local message = table.concat({...}, " ") 
					outputChatBox("[Рация]  ["..DoljnostAmount.."] "..getPlName(ThePlayer)..": "..message, v, 0,200,0)
				end		   
			end
        end
    end
end
addCommandHandler( "r", rationchat)

--[[function rationchatCHOP (ThePlayer, cmd, ...)
   local accName = getAccountName ( getPlayerAccount ( ThePlayer ) )
   local DoljnostAmount = getElementData(ThePlayer, "Должность")
     if getTeamName (getPlayerTeam (ThePlayer)) == "Частное охранное предприятие" then
         if ... then
		   for i,v in pairs (getElementsByType("player")) do
		   local vName = getAccountName ( getPlayerAccount ( v ) )
	          if getTeamName (getPlayerTeam (v)) == "Частное охранное предприятие" then	   
		       local message = table.concat({...}, " ") 
               outputChatBox("[Рация]  ["..DoljnostAmount.."] "..getPlName(ThePlayer)..": "..message, v, 0,0,0)
              end		   
		   end
         end
      end
end
addEventHandler("CommmandHandler", getRootElement(), rationchatCHOP )
addCommandHandler( "r", rationchatCHOP)

function rationchatLVA (ThePlayer, cmd, ...)
   local accName = getAccountName ( getPlayerAccount ( ThePlayer ) )
   local DoljnostAmount = getElementData(ThePlayer, "Должность")
     if getTeamName (getPlayerTeam (ThePlayer)) == "Las Venturas Army" then
         if ... then
		   for i,v in pairs (getElementsByType("player")) do
		   local vName = getAccountName ( getPlayerAccount ( v ) )
	          if getTeamName (getPlayerTeam (v)) == "Las Venturas Army" then	   
		       local message = table.concat({...}, " ") 
               outputChatBox("[Рация]  ["..DoljnostAmount.."] "..getPlName(ThePlayer)..": "..message, v, 0,0,0)
              end		   
		   end
         end
      end
end
addEventHandler("CommmandHandler", getRootElement(), rationchatLVA )
addCommandHandler( "r", rationchatLVA)]]--

function OOSrationchatLSPD (ThePlayer, cmd, ...)
local accName = getAccountName ( getPlayerAccount ( ThePlayer ) )
local DoljnostAmount = getElementData(ThePlayer, "Должность")
    if getElementData (ThePlayer, "frac") == "LSPD" then
        if ... then
		    for i,v in pairs (getElementsByType("player")) do
		    local vName = getAccountName ( getPlayerAccount ( v ) )
				if getElementData (v, "frac") == "LSPD" or getElementData (v, "frac") == "HLS" then	   
					local message = table.concat({...}, " ") 
					outputChatBox("[ООС Рация]  ["..DoljnostAmount.."] "..getPlName(ThePlayer)..": "..message, v, 0,0,200)
				end		   
			end
        end
	elseif getElementData (ThePlayer, "frac") == "HLS" then
        if ... then
		    for i,v in pairs (getElementsByType("player")) do
		    local vName = getAccountName ( getPlayerAccount ( v ) )
				if getElementData (v, "frac") == "LSPD" or getElementData (v, "frac") == "HLS" then	   
					local message = table.concat({...}, " ") 
					outputChatBox("[ООС Рация]  ["..DoljnostAmount.."] "..getPlName(ThePlayer)..": "..message, v, 0,0,200)
				end		   
			end
        end
	elseif getElementData (ThePlayer, "frac") == "LVA" then
        if ... then
		    for i,v in pairs (getElementsByType("player")) do
		    local vName = getAccountName ( getPlayerAccount ( v ) )
				if getElementData (v, "frac") == "LSPD" or getElementData (v, "frac") == "LVA" then	   
					local message = table.concat({...}, " ") 
					outputChatBox("[ООС Рация]  ["..DoljnostAmount.."] "..getPlName(ThePlayer)..": "..message, v, 0,0,200)
				end		   
			end
        end
    end
end
addCommandHandler( "db", OOSrationchatLSPD)

function rationchatTeam (ThePlayer, cmd, ...)
local accName = getAccountName ( getPlayerAccount ( ThePlayer ) )
local DoljnostAmount = getElementData(ThePlayer, "Должность")
    if getElementData (ThePlayer, "frac") == "LSPD" then
        if ... then
		    for i,v in pairs (getElementsByType("player")) do
		    local vName = getAccountName ( getPlayerAccount ( v ) )
				if getElementData (v, "frac") == "LSPD" then	   
					local message = table.concat({...}, " ") 
					outputChatBox("[ООС Рация]  ["..DoljnostAmount.."] "..getPlName(ThePlayer)..": (("..message.."))", v, 123, 104, 238)
				end		   
			end
        end
	elseif getElementData (ThePlayer, "frac") == "HLS" then
        if ... then
		    for i,v in pairs (getElementsByType("player")) do
		    local vName = getAccountName ( getPlayerAccount ( v ) )
				if getElementData (v, "frac") == "HLS" then	   
					local message = table.concat({...}, " ") 
					outputChatBox("[ООС Рация]  ["..DoljnostAmount.."] "..getPlName(ThePlayer)..": (("..message.."))", v, 123, 104, 238)
				end		   
			end
        end
	elseif getElementData (ThePlayer, "frac") == "LVA" then
        if ... then
		    for i,v in pairs (getElementsByType("player")) do
		    local vName = getAccountName ( getPlayerAccount ( v ) )
				if getElementData (v, "frac") == "LVA" then	   
					local message = table.concat({...}, " ") 
					outputChatBox("[ООС Рация]  ["..DoljnostAmount.."] "..getPlName(ThePlayer)..": (("..message.."))", v, 123, 104, 238)
				end		   
			end
        end
    end
end
addCommandHandler( "rb", rationchatTeam)

--[[function OOSrationchatHLS (ThePlayer, cmd, ...)
   local accName = getAccountName ( getPlayerAccount ( ThePlayer ) )
   local DoljnostAmount = getElementData(ThePlayer, "Должность")
     if getTeamName (getPlayerTeam (ThePlayer)) == "Hospital Los Santos" then
         if ... then
		   for i,v in pairs (getElementsByType("player")) do
		   local vName = getAccountName ( getPlayerAccount ( v ) )
	          if getTeamName (getPlayerTeam (v)) == "Hospital Los Santos" then	   
		       local message = table.concat({...}, " ") 
               outputChatBox("[ООС Рация]  ["..DoljnostAmount.."] "..getPlName(ThePlayer)..": "..message, v, 0,200,0)
              end		   
		   end
         end
      end
end
addEventHandler("CommmandHandler", getRootElement(), OOSrationchatHLS )
addCommandHandler( "rr", OOSrationchatHLS)

function OOSrationchatCHOP (ThePlayer, cmd, ...)
   local accName = getAccountName ( getPlayerAccount ( ThePlayer ) )
   local DoljnostAmount = getElementData(ThePlayer, "Должность")
     if getTeamName (getPlayerTeam (ThePlayer)) == "Частное охранное предприятие" then
         if ... then
		   for i,v in pairs (getElementsByType("player")) do
		   local vName = getAccountName ( getPlayerAccount ( v ) )
	          if getTeamName (getPlayerTeam (v)) == "Частное охранное предприятие" then	   
		       local message = table.concat({...}, " ") 
               outputChatBox("[ООС Рация]  ["..DoljnostAmount.."] "..getPlName(ThePlayer)..": "..message, v, 0,0,0)
              end		   
		   end
         end
      end
end
addEventHandler("CommmandHandler", getRootElement(), OOSrationchatCHOP )
addCommandHandler( "rr", OOSrationchatCHOP)

function OOSrationchatLVA (ThePlayer, cmd, ...)
   local accName = getAccountName ( getPlayerAccount ( ThePlayer ) )
   local DoljnostAmount = getElementData(ThePlayer, "Должность")
     if getTeamName (getPlayerTeam (ThePlayer)) == "Las Venturas Army" then
         if ... then
		   for i,v in pairs (getElementsByType("player")) do
		   local vName = getAccountName ( getPlayerAccount ( v ) )
	          if getTeamName (getPlayerTeam (v)) == "Las Venturas Army" then	   
		       local message = table.concat({...}, " ") 
               outputChatBox("[ООС Рация]  ["..DoljnostAmount.."] "..getPlName(ThePlayer)..": "..message, v, 0,0,0)
              end		   
		   end
         end
      end
end
addEventHandler("CommmandHandler", getRootElement(), OOSrationchatLVA )
addCommandHandler( "rr", OOSrationchatLVA)]]--

function leader (thePlayer, cmd, target, id)
if thePlayer and isElement(thePlayer) then 
		  local accountplayer = getPlayerAccount(thePlayer)
          local accName = getAccountName (accountplayer)
         if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) then
			   if target then
	               local player = getPlayerFromID(tonumber(target))		   
			         if player and isElement(player) then
					   local account = getPlayerAccount(player)
                       local oFaction = getAccountData(account, "Faction") or 0		
                            if tonumber(id) == 1 then					   
							   setElementData(player, "frac", "LSPD")
		                       setElementData(player, "Должность", "Шериф")
							   setElementData(player, "Job", "Полиция")
							   setPlayerNametagColor(player, 0,0,200)
							   setAccountData (getPlayerAccount(player), "prevSkin", getElementModel(player))
							   setElementModel ( player, 283 )
                               outputChatBox ("Вы поставили "..getPlName(player).." на лидера фракции LSPD.", thePlayer)
						       outputChatBox ("Вас поставил "..getPlName(thePlayer).." на лидера фракции LSPD.", player)
							elseif tonumber(id) == 2 then					   
							   local team = getTeamFromName("Las Venturas Army")
	                           setPlayerTeam(player, team)
		                       setElementData(player, "Должность", "Генерал")
							   setElementData(player, "frac", "LVA")
							   setElementData(player, "Job", "Военный")
							   setPlayerNametagColor(player, 105,139,34)
							   setAccountData (getPlayerAccount(player), "prevSkin", getElementModel(player))
							   setElementModel ( player, 61 )
                               outputChatBox ("Вы поставили "..getPlName(player).." на лидера фракции LVA.", thePlayer)
						       outputChatBox ("Вас поставил "..getPlName(thePlayer).." на лидера фракции LVA.", player)
							elseif tonumber(id) == 0 then					   
							   local team = getTeamFromName("Мирные Жители")
	                           setPlayerTeam(player, team)
							   setElementModel(player, getAccountData (getPlayerAccount(player), "prevSkin") or 0)
							   setElementData (player, "frac", "Безработный")
							   setElementData(player, "Job", "Безработный")
							   setPlayerNametagColor(player, 255,215,0)
		                       setElementData(player, "Должность", "Безработный")
                               outputChatBox ("Вы забрали у "..getPlName(player).." лидерство фракции.", thePlayer)
						       outputChatBox ("У Вас забрал "..getPlName(thePlayer).." лидерство фракции.", player)
							elseif tonumber(id) == 3 then			
							   setAccountData (getPlayerAccount(player), "prevSkin", getElementModel(player))
						       setElementModel ( player, 70 )
		                       setElementData(player, "Должность", "Главный Врач")
							   setPlayerNametagColor(player, 0,200,0)
							   setElementData(player, "frac", "HLS")
							   setElementData(player, "Job", "Медик")
                               outputChatBox ("Вы поставили "..getPlName(player).." на лидера фракции HLS.", thePlayer)
						       outputChatBox ("Вас поставил "..getPlName(thePlayer).." на лидера фракции HLS.", player)
							elseif tonumber(id) == 4 then						   
							   local team = getTeamFromName("Частное охранное предприятие")
							   setElementModel ( player, 113 )
							   setPlayerNametagColor(player, 0,0,0 )
	                           setPlayerTeam(player, team)
		                       setElementData(player, "Должность", "Авторитет")
                               outputChatBox ("Вы поставили "..getPlName(player).." на лидера Частное охранное предприятие.", thePlayer)
						       outputChatBox ("Вас поставил "..getPlName(thePlayer).." на лидера Частное охранное предприятие.", player)
							   elseif tonumber(id) == 5 then	
                               setElementModel ( player, 292 )							   
							   local team = getTeamFromName("Varrios Los Aztecas")
	                           setPlayerTeam(player, team)
		                       setElementData(player, "Должность", "Цезарь")
							   setPlayerNametagColor(player, 0,229,238)
							   setElementData(player, "frac", "VLA")
                               outputChatBox ("Вы поставили "..getPlName(player).." на лидера банды Varrios Los Aztecas.", thePlayer)
						       outputChatBox ("Вас поставил "..getPlName(thePlayer).." на лидера банды Varrios Los Aztecas.", player)
							   elseif tonumber(id) == 6 then		
                               setElementModel ( player, 104 )							   
							   local team = getTeamFromName("The Ballas Gang")
	                           setPlayerTeam(player, team)
							   setElementData(player, "frac", "BALLAS")
		                       setElementData(player, "Должность", "Биг Вилли")
							   setPlayerNametagColor(player, 153,50,204 )
                               outputChatBox ("Вы поставили "..getPlName(player).." на лидера банды The Ballas Gang.", thePlayer)
						       outputChatBox ("Вас поставил "..getPlName(thePlayer).." на лидера банды The Ballas Gang.", player)
							   elseif tonumber(id) == 7 then		
							   setElementModel ( player, 270 )
							   local team = getTeamFromName("Grove Street")
	                           setPlayerTeam(player, team)
							   setElementData(player, "frac", "GROOVE")
		                       setElementData(player, "Должность", "Мэд Дог")
							   setPlayerNametagColor(player, 0,100,0 )
                               outputChatBox ("Вы поставили "..getPlName(player).." на лидера банды Grove Street.", thePlayer)
						       outputChatBox ("Вас поставил "..getPlName(thePlayer).." на лидера банды Grove Street.", player)
							   elseif tonumber(id) == 8 then					   
							   local team = getTeamFromName("The Rifa Gang")
							   setElementModel ( player, 307 )
	                           setPlayerTeam(player, team)
							   setElementData(player, "frac", "TRG")
		                       setElementData(player, "Должность", "Эль Падре")
							   setPlayerNametagColor(player, 45,111,213 )
                               outputChatBox ("Вы поставили "..getPlName(player).." на лидера банды The Rifa Gang.", thePlayer)
						       outputChatBox ("Вас поставил "..getPlName(thePlayer).." на лидера банды The Rifa Gang.", player)
							   elseif tonumber(id) == 9 then									   
							   local team = getTeamFromName("Los Santos Vagos")
							   setElementModel ( player, 110 )
							   setPlayerNametagColor(player, 238,173,14 )
	                           setPlayerTeam(player, team)
							   setElementData(player, "frac", "LSV")
		                       setElementData(player, "Должность", "Падре")
                               outputChatBox ("Вы поставили "..getPlName(player).." на лидера банды Los Santos Vagos.", thePlayer)
						       outputChatBox ("Вас поставил "..getPlName(thePlayer).." на лидера банды Los Santos Vagos.", player)
							   else
							   outputChatBox ("Неверный номер фракции/банды!", thePlayer,255,100,100)
							  end
						   end
                     end
				end	 
          end
end

addEventHandler("CommmandHandler", getRootElement(), leader )			   
addCommandHandler( "setleader", leader)

function getPlName (name)
return removeHex(getPlayerName (name))
end

function removeHex(text, digits)
    assert(type(text) == "string", "Bad argument 1 @ removeHex [String expected, got " .. tostring(text) .. "]")
    --assert(digits == nil or (type(digits) == "number" and digits > 0), "Bad argument 2 @ removeHex [Number greater than zero expected, got " .. tostring(digits) .. "]")
    return string.gsub(text, "#" .. (6 and string.rep("%x", 6) or "%x+"), "")
end