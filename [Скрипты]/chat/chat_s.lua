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
    

local last_msg 			= {{ }}
local cooldownTimers 		= { }
local characteraddition 	= 100
local antiSpamTime 		= 1000
local maxbubbles 		= 4
local chat_range 		= 180
local showtime 			= 7500
local hideown 			= true
local defR,defG,defB		= 240, 235, 255

local nameOfIRCResource	= "irc"

local lawTeams = {
	["Government"] 			= true,
	["Emergency service"] 		= true,
}
local policeTeams = {
	["Government"] 			= true,
}

local enable_bad_word_replacement 	= false
local patterns = {
	{ "fuck", "feck" },
	{ "fuk", "feck" },
	{ "shit", "feck" },
	{ "bitch", "feck" },
	{ "cock", "feck" },
	{ "cunt", "feck" },
	{ "nigger", "feck" },
	{ "dick", "feck" },
	{ "whore", "feck" },
	{ "fag", "feck" },
	{ "pussy", "feck" },
	{ "hoe", "feck" },
	{ "slut", "feck" },
	{ "twat", "feck" },
	{ "tits", "feck" },
	{ "mtasa://", "gtw://" },
}

function getGroupChatColor(group)
	local r,g,b = exports.GTWgroups:getGroupChatColor(group)
	if not r or not g or not b then
		r,g,b = defR,defG,defB
	end
	return r,g,b
end

function outputToChat(text, visible_to, red, green, blue, color_coded)
	if enable_bad_word_replacement then
		for k,v in pairs(patterns) do
			text = string.gsub(text, v[1], v[2])
		end
	end
	outputChatBox(text, visible_to, red, green, blue, color_coded)
end

function cleanUpChat()
	last_msg[source] = nil
	cooldownTimers[source] = nil
end
addEventHandler("onPlayerQuit", root, cleanUpChat)

function is_player_in_range(player,x,y,z,range)
   local px,py,pz = getElementPosition(player)
   return((x-px)^2+(y-py)^2+(z-pz)^2)^0.5<=range
end

function isServerStaff(plr)
	if (not plr) or (not getPlayerAccount(plr)) then return false end

	local acc = getAccountName(getPlayerAccount(plr))
	if isObjectInACLGroup("user."..acc, aclGetGroup("Admin")) or
		isObjectInACLGroup("user."..acc, aclGetGroup("SuperModerator")) or
		isObjectInACLGroup("user."..acc, aclGetGroup("Moderator")) or
		isObjectInACLGroup("user."..acc, aclGetGroup("Supporter")) then
		return true
	else
		return false
	end
end

function validateChatInput(plr, chatID, text)
	if isPlayerMuted(plr) then
		outputToChat("У вас мут, вы не можете что-либо писать", plr, 255, 100, 0)
		return false
	end
	if isTimer(cooldownTimers[plr]) then
		outputToChat("Не спамьте!", plr, 255, 100, 0)
		return false
	end
	if chatID == "car" and not getPedOccupiedVehicle(plr) then
		outputToChat("Эту команду возможно использовать только в автомобиле", plr, 255, 100, 0)
		return false
	end
	return true
end

function useCarChat(plr, n, ...)
	local msg = table.concat({...}, " ")
	if not validateChatInput(plr, "car", msg) then return end
	local r,g,b = defR,defG,defB
	if getPlayerTeam(plr) then
		r,g,b = getTeamColor(getPlayerTeam(plr))
	end
	local veh = getPedOccupiedVehicle(plr)
	local nick = getPlayerName(plr)
	for n, v in pairs(getVehicleOccupants(veh)) do
		local outText = "(CC) ["..tostring(n).."] "..nick..": "..RGBToHex(defR,defG,defB)
		local length = string.len(outText..firstToUpper(msg))
			outputToChat("#ffffff (Авто) #EEEED1"..getPlayerName ( plr )..": #ff6400"..firstToUpper(msg) ,v,200,0,200,true)
		end
	cooldownTimers[plr] = setTimer(function() end, antiSpamTime, 1)
end
addCommandHandler("", useCarChat, false, false)

function useActionChatDo(plr, n, ...)
	local msg = table.concat({...}, " ")
	if not validateChatInput(plr, "do", msg) then return end
	local nick = getPlayerName(plr)
	local ID = getElementData ( plr, "ID" )	
	outputToChat("#ffffff #ff6400"..getPlayerName ( plr ).." "..firstToUpper(msg), root, 255, 100, 200,true)
	cooldownTimers[plr] = setTimer(function() end, antiSpamTime, 1)
end
addCommandHandler("", useActionChatDo, false, false)

function pay (ThePlayer, cmd, target, amount)
   local player = getPlayerFromID(tonumber(target))
   if player then
     local x, y, z = getElementPosition ( player )
     if getDistanceBetweenPoints3D ( x, y ,z ,getElementPosition ( ThePlayer ) ) < 10 then  
      amount = tonumber(amount) or 0
      if amount > 0 and getPlayerMoney(ThePlayer) >= amount then
		 if amount <= 50000 then
         givePlayerMoney(player, amount)
         takePlayerMoney(ThePlayer,amount)
		 outputToChat ("#ffffff Вы передали #ff6400"..getPlayerName(player)..": #228b22"..amount.."$.", ThePlayer,255, 100, 200,true)
		 outputToChat ("#ffffff Вам передал #ff6400"..getPlayerName(ThePlayer)..": #228b22"..amount.."$.", player,255, 100, 200,true)
		 else
		 outputToChat ("#ffffffВы не можете перевести больше 50000$. Воспользуйтесь банком", ThePlayer,255, 100, 200,true)
		 end
      end
	  else
	  outputToChat ("#ffffff #cd5b45Игрок слишком далеко от вас.", ThePlayer,255, 100, 200,true)
	 end 
	else
      outputToChat ("#ffffff #cd5b45Правильно: #ff0000/pay #ffa500[ID игрока] #228b22[сумма]", ThePlayer,255, 100, 200,true)	 
   end
end
addEventHandler("CommmandHandler", getRootElement(), pay )
addCommandHandler("pay", pay)


function reportPlayer (ThePlayer, cmd, ...)
if not isPlayerMuted (ThePlayer) then
  if ... then
  local id = getElementData (ThePlayer, "ID")
  local message = table.concat({...}, " ")
  outputToChat ("#ffff00*Ваш репорт -  #ffffff"..message, ThePlayer,255, 100, 200,true)
    for i,v in pairs (getElementsByType("player")) do
	   local accName = getAccountName ( getPlayerAccount ( v ) )
         if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerator" ) ) then
		 outputToChat ("#ffff00*Репорт от - #ffffff("..tonumber(id)..") #ffffff"..getPlayerName(ThePlayer)..": #FFFFff"..message, v,255, 100, 200,true)
		 end
    end
  end
end
end
addEventHandler("CommmandHandler", getRootElement(), reportPlayer )
addCommandHandler ("re", reportPlayer)

function otvet (ThePlayer, cmd, target, ...)
  local accName = getAccountName ( getPlayerAccount ( ThePlayer ) )
    if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerator" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderator" ) ) then
       local player = getPlayerFromID(tonumber(target))
         if player then
           if ... then
           local message = table.concat({...}, " ") 
           outputToChat ("#ffff00*Ответ от #ffffff"..getPlayerName(ThePlayer)..": #ffff00"..message, player,255, 100, 200,true)
		    for i,v in pairs (getElementsByType("player")) do
			 local accNamev = getAccountName ( getPlayerAccount ( v ) )
			 if isObjectInACLGroup ("user."..accNamev, aclGetGroup ( "Admin" ) ) then
			  outputToChat("#ffff00*Ответ от #ffffff"..getPlayerName(ThePlayer).." #ffff00для #ffffff"..getPlayerName(player)..": #ffff00"..message, v,255, 100, 200,true)
			 end 
			end
           end
        end
	end
end
addEventHandler("CommmandHandler", getRootElement(), otvet )
addCommandHandler ("ot", otvet)

function global (ThePlayer, cmd, ...)
   local accName = getAccountName ( getPlayerAccount ( ThePlayer ) )
      if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderator" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerator" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) then
         if ... then
		 local message = table.concat({...}, " ") 
			local teg
				if isObjectInACLGroup("user." .. accName, aclGetGroup("Admin")) then
				teg = ""
			
				elseif isObjectInACLGroup("user." .. accName, aclGetGroup("SuperModerator")) then
				teg = "#00FF00[A]"
			
				elseif isObjectInACLGroup("user." .. accName, aclGetGroup("Moderator")) then
				teg = "#00FF00[M]"
			
				elseif isObjectInACLGroup("user." .. accName, aclGetGroup("Dev")) then       
				teg = "#FFFF00[Девушка]"
			
				elseif isObjectInACLGroup("user." .. accName, aclGetGroup("Everyone")) then
				teg = ""
				end
				local text = "#D5D5D5"..teg.." #EEEED1"..getPlayerName ( ThePlayer )..": #FFCC00"
           outputToChat (text..message, root, 255, 200, 0,true)
         end
      end
end
addEventHandler("CommmandHandler", getRootElement(), global )
addCommandHandler ("o", global)

function bChat (ThePlayer, cmd, ...)
if not isPlayerMuted (ThePlayer) then
   if ... then
    local message = table.concat({...}, " ")
     for i,v in pairs (getElementsByType("player")) do
      local x,y,z = getElementPosition(ThePlayer)
      local xa,ya,za = getElementPosition(v)
       if getDistanceBetweenPoints3D(x,y,z,xa,ya,za) < 10 then
        outputToChat( "#ffffff #ffa500"..getPlayerName(ThePlayer).." #8b795e(OOC): #8b814c(( #228b22" ..message.. " #8b814c))", v,255, 100, 200,true)
       end
     end
   end
end
end
addEventHandler("CommmandHandler", getRootElement(), bChat )
addCommandHandler ("", bChat)

function wChat (ThePlayer, cmd, ...)
if not isPlayerMuted (ThePlayer) then
   if ... then
    local message = table.concat({...}, " ")
     for i,v in pairs (getElementsByType("player")) do
      local x,y,z = getElementPosition(ThePlayer)
      local xa,ya,za = getElementPosition(v)
       if getDistanceBetweenPoints3D(x,y,z,xa,ya,za) < 3 then
        outputToChat( "#ffffff #ffa500"..getPlayerName(ThePlayer).." #8b814cшепчет: "..message, v,255, 100, 200,true)
       end
     end
   end
end
end
addEventHandler("CommmandHandler", getRootElement(), wChat )
addCommandHandler ("t", wChat)


function doChat (ThePlayer, cmd, ...)
if not isPlayerMuted (ThePlayer) then
   if ... then
    local message = table.concat({...}, " ")
     for i,v in pairs (getElementsByType("player")) do
      local x,y,z = getElementPosition(ThePlayer)
      local xa,ya,za = getElementPosition(v)
       if getDistanceBetweenPoints3D(x,y,z,xa,ya,za) < 10 then
        outputToChat( "#c547ff"..message.." "..getPlayerName(ThePlayer).."", v,255, 100, 200,true)
       end
     end
   end
end
end
addEventHandler("CommmandHandler", getRootElement(), doChat )
addCommandHandler ("e", doChat)


function sChat (ThePlayer, cmd, ...)
if not isPlayerMuted (ThePlayer) then
   if ... then
    local message = table.concat({...}, " ")
     for i,v in pairs (getElementsByType("player")) do
      local x,y,z = getElementPosition(ThePlayer)
      local xa,ya,za = getElementPosition(v)
       if getDistanceBetweenPoints3D(x,y,z,xa,ya,za) < 20 then
        outputToChat( "#ffffff #ffffff"..getPlayerName(ThePlayer).." #00AEFFкричит: #ffffff"..message, v,255, 100, 200,true)
       end
     end
   end
end
end
addEventHandler("CommmandHandler", getRootElement(), sChat )
addCommandHandler ("s", sChat)

function tryChat (ThePlayer, cmd, ...)
if not isPlayerMuted (ThePlayer) then
   if ... then
    local message = table.concat({...}, " ")
	local fix = math.random(1,2)
     for i,v in pairs (getElementsByType("player")) do
      local x,y,z = getElementPosition(ThePlayer)
      local xa,ya,za = getElementPosition(v)
       if getDistanceBetweenPoints3D(x,y,z,xa,ya,za) < 15 then
		 if fix == 1 then 
           outputToChat( "#c547ff* "..getPlayerName(ThePlayer).."#c547ff попытался "..message.." #ff0000(неудачно)", v,255, 100, 200,true)
		  elseif fix == 2 then
           outputToChat( "#c547ff* "..getPlayerName(ThePlayer).."#c547ff попытался "..message.." #00ff00(удачно)", v,255, 100, 200,true)
		 end
       end
     end
   end
end
end
addEventHandler("CommmandHandler", getRootElement(), tryChat )
addCommandHandler ("try", tryChat)


function admin (ThePlayer, cmd, ...)
   local accName = getAccountName ( getPlayerAccount ( ThePlayer ) )
      if isServerStaff (ThePlayer) then 
         if ... then
		   for i,v in pairs (getElementsByType("player")) do
		   local vName = getAccountName ( getPlayerAccount ( v ) )
	          if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerator" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderator" ) ) then
		       local message = table.concat({...}, " ") 
               outputToChat ("#07ADEE[Админ чат] #ffa500"..getPlayerName(ThePlayer)..": #07ADEE"..message, v, 255,140,0, true)
              end		   
		   end
         end
      end
end
addEventHandler("CommmandHandler", getRootElement(), admin )
--addCommandHandler ("Админ", admin)

local teg

function useGlobalChat(message, messageType)
	cancelEvent()
	for i,v in ipairs (getElementsByType("player")) do
		local x, y, z = getElementPosition (source)
		local xa, ya, za = getElementPosition (v)
		if getDistanceBetweenPoints3D(x,y,z,xa,ya,za) < 200000 then
			if (messageType == 0) then
	
				local acc = getAccountName (getPlayerAccount(source))
				if isObjectInACLGroup("user."..acc, aclGetGroup("Oleg")) then
				teg = "#22f5cbОснователь"
				
                elseif isObjectInACLGroup("user." .. acc, aclGetGroup("Admin")) then
				teg = "#ffff00Зам Основателя"
				
				elseif isObjectInACLGroup("user." .. acc, aclGetGroup("SuperModerator")) then
				teg = "#23de62Администратор"
			
				elseif isObjectInACLGroup("user." .. acc, aclGetGroup("Moderator")) then
				teg = "#a0e319Модератор"
			
				elseif isObjectInACLGroup("user." .. acc, aclGetGroup("Dev")) then       
				teg = "#FFFF00Девушка"

				elseif isObjectInACLGroup("user." .. acc, aclGetGroup("Everyone")) then
				teg = ""
				
				end
				
				if not validateChatInput(source, "main", message) then return end
					local occupation = ""
					local r,g,b = defR,defG,defB
					if getPlayerTeam(source) then
					r,g,b = getTeamColor(getPlayerTeam(source))
				end
				local px,py,pz = getElementPosition(source)
				local loc = getElementData(source, "Location") or getZoneName(px,py,pz)
				if getElementData ( source, "ID" ) then
					local ID = getElementData ( source, "ID" )
					local outText
					if teg == "#00FF00[A]" then
						local outText = "#ffffff #D5D5D5("..ID..") "..teg.." #EEEED1"..getPlayerName ( source )..": #00FF00"
						outputToChat(outText..firstToUpper(message), v,255, 100, 0, true)
					else
						local outText = "#ffffff #D5D5D5("..ID..") "..teg.." #EEEED1"..getPlayerName ( source )..": #ffffff"
						outputToChat(outText..firstToUpper(message), v,255, 100, 0, true)
					end
				end
			end
		end
	end
end
addEventHandler("onPlayerChat", root, useGlobalChat)

function freezeChats()
cancelEvent()
end

local freeze = false
function freezeChat (pl, cmd)
if freeze == false then
	if isEventHandlerAdded ("onPlayerChat", root, useGlobalChat) then
	removeEventHandler ("onPlayerChat", root, useGlobalChat)
	addEventHandler ("onPlayerChat", root, freezeChats)
	freeze = true
	outputChatBox ("Чат заморожен!", root, 0, 255, 255)
	end
else
	if not isEventHandlerAdded ("onPlayerChat", root, useGlobalChat) then
	removeEventHandler ("onPlayerChat", root, freezeChats)
	addEventHandler ("onPlayerChat", root, useGlobalChat)
	freeze = false
	outputChatBox ("Чат разморожен!", root, 0, 255, 0)
	end
end
end
addCommandHandler ("freezeChat", freezeChat)

function displayChatBubble(message, messagetype, plr)
	if isPlayerMuted(plr) then return end
	if source then
		triggerClientEvent("GTWchat.makeChatBubble", source, message, messagetype, plr)
	else
		triggerClientEvent("GTWchat.makeChatBubble", plr, message, messagetype, plr)
	end
end

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
     if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
          local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
          if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
               for i, v in ipairs( aAttachedFunctions ) do
                    if v == func then
        	         return true
        	    end
	       end
	  end
     end
     return false
end

function RGBToHex(red, green, blue, alpha)
	if ((red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255) or(alpha and(alpha < 0 or alpha > 255))) then
		return nil
	end
	if (alpha) then
		return string.format("#%.2X%.2X%.2X%.2X", red,green,blue,alpha)
	else
		return string.format("#%.2X%.2X%.2X", red,green,blue)
	end
end

function firstToUpper(str)
	if str and str:sub(1,4) ~= "http" and str:sub(1,4) ~= "www." then
    	return str:sub(1,1):upper()..str:sub(2)
    else
    	return str
    end
end


function receiveSettings()
	local settings =
	{
		showtime,
		characteraddition,
		maxbubbles,
		hideown
	}
	triggerClientEvent(source,"GTWchat.returnSettings", root, settings)
end
addEvent("GTWchat.askForSettings",true)
addEventHandler("GTWchat.askForSettings", root, receiveSettings)