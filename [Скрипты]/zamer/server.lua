function giveMoney (pl, cmd, target, money)
if getElementData (pl, "tegA") then
	if cmd == "giveMoney" then
		if target then
			local player = getPlayerFromPartialName (target)
			givePlayerMoney (player, tonumber(money))
			outputChatBox ("Вам выдали "..money.."₽", player, 0, 255, 0)
			outputChatBox ("Вы выдали игроку "..utf8.gsub(getPlayerName(player), "#%x%x%x%x%x%x", "").." "..money.."₽", pl, 0, 255, 0)
		end
	elseif cmd == "giveMoneyAcc" then
		if target then
			if getAccount(target) then
				local acc =  getPlayerAccount (getAccountPlayer (getAccount(target)))
				local mon = getAccountData (acc, "funmodev2-money")
				setAccountData (acc, "funmodev2-money", tostring(tonumber (mon) + tonumber(money)))
				outputChatBox ("Вы выдали "..money.."₽ на аккаунт "..target..".", pl, 0, 255, 0)
			else
				outputChatBox ("Такого аккаунта нету!", pl, 255, 0, 0)
			end
		else
			outputChatBox ("Аккаунт не написан!", pl, 255, 0, 0)
		end
	end
end
end
addCommandHandler ("giveMoney", giveMoney)
addCommandHandler ("giveMoneyAcc", giveMoney)

function giveMoneyAll (pl, cmd, money)
if (isObjectInACLGroup("user." ..getAccountName(getPlayerAccount(pl)), aclGetGroup("Admin"))) then 
	for i, player in ipairs (getElementsByType("player")) do
	givePlayerMoney (player, tonumber(money))
	outputChatBox ("Администратор раздал всем по "..money.."₽", player, 0, 255, 0)
	end
end
end
addCommandHandler ("giveMoneyAll", giveMoneyAll)

function garage (pl, cmd, id)
if getElementData (pl, "teg") then
	if not tonumber(id) then return end
	setGarageOpen (id, not isGarageOpen (id))
end
end
addCommandHandler ("garage", garage)

function giveMoney (pl, cmd, target, money)
if getElementData (pl, "teg") then
if target then
	local player = getPlayerFromPartialName (target)
	takePlayerMoney (player, tonumber(money))
	outputChatBox ("У вас забрали "..money.."₽", player, 0, 255, 0)
	outputChatBox ("Вы забрали у игрока "..utf8.gsub(getPlayerName(player), "#%x%x%x%x%x%x", "").." "..money.."₽", pl, 0, 255, 0)
end
end
end
addCommandHandler ("takeMoney", giveMoney)

function giveMoney (pl, cmd, target, pass)
if getElementData (pl, "tegS") or getElementData (pl, "tegO") then
if target then
	setAccountPassword (getAccount(tostring(target)), tostring(pass))
	outputChatBox ("*Вы изменили/сбросили пароль аккаунту '"..target.."', пароль '"..pass, pl, 0, 255, 0)
end
end
end
addCommandHandler ("setPassword", giveMoney)

function obyava (pl, cmd, ...)
if getElementData (pl, "tegA") then
if ... then
	local msg = table.concat({...}," ") 
	for i, player in ipairs (getElementsByType("player")) do
	exports["Popupsys"]:Draw(msg, player, "Info")
	end
end
end
end
addCommandHandler ("ob", obyava)

function gmA (pl, cmd)
if getElementData (pl, "tegA") then
if getPedOccupiedVehicle (pl) then
	outputDebugString (tostring(isVehicleDamageProof (getPedOccupiedVehicle (pl))))
	if not isVehicleDamageProof (getPedOccupiedVehicle (pl)) then
		setVehicleDamageProof (getPedOccupiedVehicle (pl), true)
		outputChatBox ("ГМ у авто #00FF00включен", pl, 255, 255, 0, true)
	else
		setVehicleDamageProof (getPedOccupiedVehicle (pl), false)
		outputChatBox ("ГМ у авто #FF0000выключен", pl, 255, 255, 0, true)
	end
end
end
end
addCommandHandler ("gma", gmA)



function pm (pl, cmd, target, ...)
if ... and target then
	if not tonumber (target) then outputChatBox ("Проверьте введеные данные!", pl, 255, 0 , 0) return end
	local player = getPlayerFromID (target)
	local msg = table.concat({...}, " ")
	local locPl = utf8.gsub(getPlayerName(pl), "#%x%x%x%x%x%x", "")
	local targ = utf8.gsub(getPlayerName(player), "#%x%x%x%x%x%x", "")
	if not checkPM (player) then
		outputChatBox ("#FFFF00*Сообщение игроку:#C7C7C7  "..utf8.gsub(getPlayerName(player), "#%x%x%x%x%x%x", "")..":#FFFF00 "..msg, pl, 255, 255, 255,true)	
		outputChatBox ("#FFFF00*Сообщение от:#C7C7C7  "..utf8.gsub(getPlayerName(pl), "#%x%x%x%x%x%x", "")..":#FFFF00 "..msg, player, 255, 255, 255,true)
		outputServerLog ("[SMS]*Сообщение игроку: "..utf8.gsub(getPlayerName(player),"#%x%x%x%x%x%x","")..": "..msg)
		outputServerLog ("[SMS]*Сообщение от: "..utf8.gsub(getPlayerName(pl),"#%x%x%x%x%x%x","")..": "..msg)
	else	
		outputChatBox (targ.." заблокировал личные сообщения.", source, 255, 155, 0)
	end
end
end
addCommandHandler ("sms", pm)

function destroyBlownVeh ()
outputChatBox ("#FF0000*Все взорваные #C7C7C7Т\С#FF0000 будут убраны через 10 секунд!", root, 0, 255, 0,true)
setTimer (function()
	for i, veh in ipairs (getElementsByType ("vehicle")) do
		if isVehicleBlown (veh) then
			destroyElement (veh)
			outputChatBox ("#FF0000*Все взорваные #C7C7C7Т\С#FF0000 были убраны!", root, 0, 255, 0,true)
		end	
	end
end, 1000*10, 1)
end
setTimer (destroyBlownVeh, 1000*60*60*4, 0)
addCommandHandler ("checkBlownVeh", destroyBlownVeh)


function afk (pl, typ)
if typ == "afk" then
	if not getPedOccupiedVehicle (pl) then
		setElementAlpha (pl, 50)
		setElementCollisionsEnabled (pl, false)
		setElementFrozen (pl, true)
	else
		if getVehicleOccupant (getPedOccupiedVehicle (pl)) == 0 then
			if getElementSpeed (getPedOccupiedVehicle (pl), 1) ~= 0 then
				setVehicleLocked (getPedOccupiedVehicle (pl), true)
				setElementFrozen (getPedOccupiedVehicle (pl), true)
				addEventHandler ("onPlayerDamage", root, godMode)
			end
		else
			if not isEventHandlerAdded ("onPlayerDamage", root, godMode) then
				addEventHandler ("onPlayerDamage", root, godMode)
			end
		end
	end
elseif typ == "play" then
	if not getPedOccupiedVehicle (pl) then
		setElementAlpha (pl, 255)
		setElementCollisionsEnabled (pl, true)
		setElementFrozen (pl, false)
	else
		if getVehicleOccupant (getPedOccupiedVehicle (pl)) == 0 then
			setVehicleLocked (getPedOccupiedVehicle (pl), false)
			setElementFrozen (getPedOccupiedVehicle (pl), false)
			if isEventHandlerAdded ("onPlayerDamage", root, godMode) then
				removeEventHandler ("onPlayerDamage", root, godMode)
			end
		else
			if isEventHandlerAdded ("onPlayerDamage", root, godMode) then
				removeEventHandler ("onPlayerDamage", root, godMode)
			end
		end
	end
end
end
addEvent ("afk", true)
addEventHandler ("afk", root, afk)

function godMode ()
	triggerClientEvent (pl, "godMode", pl, pl)
end

function podveska (pl, cmd, type)
if not getPedOccupiedVehicle(pl) then return end
if getElementModel(getPedOccupiedVehicle(pl)) == 490 then
if type then
	if type == "up" then
		setVehicleHandling (getPedOccupiedVehicle(pl), "suspensionLowerLimit", -0.45)
		setVehicleHandling (getPedOccupiedVehicle(pl), "suspensionForceLevel", 1.5)
	elseif type == "down" then
		setVehicleHandling (getPedOccupiedVehicle(pl), "suspensionLowerLimit", -0.2)
		setVehicleHandling (getPedOccupiedVehicle(pl), "suspensionForceLevel", 1.2)
	elseif type == "sport" then
		setVehicleHandling (getPedOccupiedVehicle(pl), "maxVelocity", 400)
		setVehicleHandling (getPedOccupiedVehicle(pl), "suspensionLowerLimit", -0.15)
		setVehicleHandling (getPedOccupiedVehicle(pl), "suspensionForceLevel", 1.5)
	elseif type == "comf" then
		setVehicleHandling (getPedOccupiedVehicle(pl), "maxVelocity", 300)
		setVehicleHandling (getPedOccupiedVehicle(pl), "suspensionLowerLimit", -0.45)
		setVehicleHandling (getPedOccupiedVehicle(pl), "suspensionForceLevel", 0.6)
	elseif type == "stok" then
		setVehicleHandling (getPedOccupiedVehicle(pl), "maxVelocity", 300)
		setVehicleHandling (getPedOccupiedVehicle(pl), "suspensionLowerLimit", -0.3)
		setVehicleHandling (getPedOccupiedVehicle(pl), "suspensionForceLevel", 1)
	end
else
outputChatBox ("Синтаксис: /config [up, down, comf, sport, stok]", pl, 255, 150, 150)
end
end
end
addCommandHandler ("config", podveska)

local blockpmc = false

function checkPM (pl)
if getElementData (pl, "BlockPM") == true then
	return true
end
end


function blockPM (pl, cmd, target)
blockpmc = not blockpmc
if blockpmc == true then
	setElementData (pl, "BlockPM", true)
	outputChatBox ("#FFFF00*Вы заблокировали личные сообщения",pl, 0, 255, 0,true)
else
	setElementData (pl, "BlockPM", false)
	outputChatBox ("#FFFF00*Вы разблокировали личные сообщения",pl, 0, 255, 0,true)
end
end
addCommandHandler ("blockpm", blockPM)

addCommandHandler ("mygarage", function(pl)
if getAccountName(getPlayerAccount(pl)) == "логин" then
	setGarageOpen (38, not isGarageOpen (38))
end
end)

--[[setTimer (function()
local count = 0 
for i, pl in ipairs (getElementsByType ("player")) do
local veh = getPedOccupiedVehicle (pl)
if veh then
	if getElementModel (veh) == 550 or getElementModel (veh) == 518 or getElementModel (veh) == 470 or getElementModel (veh) == 535 or getElementModel (veh) == 477 or getElementModel (veh) == 496 or getElementModel (veh) == 587 or getElementModel (veh) == 475 or getElementModel (veh) == 495 or getElementModel (veh) == 500 or getElementModel (veh) == 442 or getElementModel (veh) == 451 then
		if not isVehicleDamageProof (veh) then
			setVehicleDamageProof(veh,true)
			count = count + 1
		end
	end
end
end
end, 30000, 0)--]]

function givePass (pl, cmd, target, prava)
if getElementData (pl, "tegS") ~= false or getElementData (pl, "tegO") ~= false then
if not tonumber(target) then return outputChatBox ("Введите ID игрока", pl, 255, 0, 0) end
if not prava then return outputChatBox ("Синтаксис: /givePrava ID [легковые, грузовые, пассажирские, мото, все]", pl, 255, 0, 0) end
if tonumber(target) and prava then
	if tostring(prava) == "легковые" then
		prava = "cars"
		setElementData (getPlayerFromID(tonumber(target)), prava, true)
		outputChatBox ("Вы выдали игроку "..removeHex(getPlayerName(getPlayerFromID(tonumber(target)))).." права на вождение легкового ТС", pl, 0, 255, 0)
		outputChatBox ("Вам выдали права на вождение легкового ТС", getPlayerFromID(tonumber(target)), 0, 255, 0)
	elseif tostring(prava) == "грузовые" then
		prava = "gruz"
		setElementData (getPlayerFromID(tonumber(target)), prava, true)
		outputChatBox ("Вы выдали игроку "..removeHex(getPlayerName(getPlayerFromID(tonumber(target)))).." права на вождение грузового ТС", pl, 0, 255, 0)
		outputChatBox ("Вам выдали права на вождение грузового ТС", getPlayerFromID(tonumber(target)), 0, 255, 0)
	elseif tostring(prava) == "пассажирские" then
		prava = "passangers"
		setElementData (getPlayerFromID(tonumber(target)), prava, true)
		outputChatBox ("Вы выдали игроку "..removeHex(getPlayerName(getPlayerFromID(tonumber(target)))).." права на вождение пассажирского ТС", pl, 0, 255, 0)
		outputChatBox ("Вам выдали права на вождение пассажирского ТС", getPlayerFromID(tonumber(target)), 0, 255, 0)
	elseif tostring(prava) == "мото" then
		prava = "moto"
		setElementData (getPlayerFromID(tonumber(target)), prava, true)
		outputChatBox ("Вы выдали игроку "..removeHex(getPlayerName(getPlayerFromID(tonumber(target)))).." права на вождение двух колесного ТС", pl, 0, 255, 0)
		outputChatBox ("Вам выдали права на вождение двух колесного ТС", getPlayerFromID(tonumber(target)), 0, 255, 0)
	elseif tostring(prava) == "все" then
		setElementData (getPlayerFromID(tonumber(target)), "moto", true)
		setElementData (getPlayerFromID(tonumber(target)), "passangers", true)
		setElementData (getPlayerFromID(tonumber(target)), "gruz", true)
		setElementData (getPlayerFromID(tonumber(target)), "cars", true)
		outputChatBox ("Вы выдали игроку "..removeHex(getPlayerName(getPlayerFromID(tonumber(target)))).." права на вождение всего ТС", pl, 0, 255, 0)
		outputChatBox ("Вам выдали права на вождение всего ТС", getPlayerFromID(tonumber(target)), 0, 255, 0)
	end
else
	outputChatBox ("Проверьте введеные данные", 255, 0, 0)
end
end
end
addCommandHandler ("givePrava", givePass)

addCommandHandler ("tp", function (pl,cmd,id)
if not tonumber (id) then return end 
if getElementData (pl,"teg")~= true then return end
local player = getPlayerFromID (tonumber(id))
if isElement (player) then 
	local x,y,z = getElementPosition (pl)
	local x1,y1,z1 = getElementPosition (player)
	if getPedOccupiedVehicle (player) then
		local numseats = getVehicleMaxPassengers(getPedOccupiedVehicle(player))
		local seat = nil
		for i=0,numseats do
			if not getVehicleOccupant(getPedOccupiedVehicle(player), i) then
				warpPedIntoVehicle(pl, getPedOccupiedVehicle(player), i)
				outputChatBox ("Администратор #ffffff"..utf8.gsub(getPlayerName(pl),"#%x%x%x%x%x%x","").."#ffcc00 телепортировался к вам в машину", player,255,200,0,true)
				outputChatBox ("Вы телепортировались в машину игрока #ffffff"..utf8.gsub(getPlayerName(player),"#%x%x%x%x%x%x",""), pl,255,200,0,true)
				break
			end
		end
	else
		setElementPosition (pl,x1,y1+1,z1) 
		outputChatBox ("Администратор #ffffff"..utf8.gsub(getPlayerName(pl),"#%x%x%x%x%x%x","").."#ffcc00 телепортировался к вам", player,255,200,0,true)
		outputChatBox ("Вы телепортировались к игроку #ffffff"..utf8.gsub(getPlayerName(player),"#%x%x%x%x%x%x",""), pl,255,200,0,true)	
	end
end
end)

addCommandHandler ("tpp", function (pl,cmd,id) 
if not tonumber (id) then return end 
if getElementData (pl,"teg")~= true then return end
local player = getPlayerFromID (tonumber(id))
if isElement (player) then 
local x,y,z = getElementPosition (pl)
local x1,y1,z1 = getElementPosition (player)
if not getPedOccupiedVehicle (player) then
	setElementPosition (player,x,y+1,z)
outputChatBox ("Администратор #ffffff"..utf8.gsub(getPlayerName(pl),"#%x%x%x%x%x%x","").."#ffcc00 телепортировал вас к себе", player,255,200,0,true)
outputChatBox ("Вы телепортировали игрока #ffffff"..utf8.gsub(getPlayerName(player),"#%x%x%x%x%x%x","").."#ffcc00 к себе", pl,255,200,0,true)
	else
		setElementPosition (getPedOccupiedVehicle(player),x,y+1,z)
outputChatBox ("Администратор #ffffff"..utf8.gsub(getPlayerName(pl),"#%x%x%x%x%x%x","").."#ffcc00 телепортировал вас к себе", player,255,200,0,true)
outputChatBox ("Вы телепортировали игрока #ffffff"..utf8.gsub(getPlayerName(player),"#%x%x%x%x%x%x","").."#ffcc00 к себе", pl,255,200,0,true)
end
end
end)


addCommandHandler ("k", function (pl,cmd,id,text) 
if not tonumber (id) then return end 
if getElementData (pl,"teg")~= true then return end
local player = getPlayerFromID (tonumber(id))
local msg = ""
if isElement (player) then 
	if text then
		msg = table.concat({text}," ") 
	end
kickPlayer (player,msg) 
end
end)

addCommandHandler ("b", function (pl,cmd,id,time,text) 
if getElementData (pl,"tegSuper")~= true and getElementData(pl,"tegA")~= true then return end 
	if tonumber(id) then
		local player = getPlayerFromID (tonumber(id))
		local msg = ""
		if isElement (player) then 
			if text then
				msg = table.concat({text}," ") 
			end
			banPlayer (player,true,true,true,nil,msg,(time*60))
		end
	else
		if getAccount (id) then
			local serial = getAccountSerial(getAccount (id))
			addBan (nil, id, serial, pl, (text or nil), (time*60))
		else
			outputChatBox ("Такого аккаунта нету!", pl, 255, 0, 0, true)
		end
	end
end)

addCommandHandler ("getaccs", function(pl, cmd, id)
if id then
	if tonumber(id) then
		local player = getPlayerFromID(tonumber(id))
		if player then
			local serial = getPlayerSerial(player)
			local accs = getAccountsBySerial (serial)
			outputChatBox ("У игрока #FFFFFF"..removeHex(getPlayerName(player)).." #FFCC00("..#accs..") #FFCC00аккаунта:", pl, 255, 200, 0, true)
			for i, v in ipairs (accs) do
			outputChatBox (i..". #FFFFFF"..getAccountName (v), pl, 255, 200, 0, true)
			end
		else
			outputChatBox ("Игрок не в сети, используйте #FFFFFF/getaccs [логин]", pl, 255, 200, 0, true)
		end
	else
		if getAccount(id) then
			local acc =  getAccount(id)
			local serial = getAccountSerial(acc)
			local accs = getAccountsBySerial (serial) 
			outputChatBox ("На логин #FFFFFF"..id.." #FFCC00зарегистрировано ("..#accs..") #FFCC00аккаунта:", pl, 255, 200, 0, true)
			for i, v in ipairs (accs) do
			outputChatBox (i..". #FFFFFF"..getAccountName (v), pl, 255, 200, 0, true)
			end
		else
			outputChatBox ("Такого аккаунта нету!", pl, 255, 0, 0, true)
		end
	end
else
	outputChatBox ("Синтаксис: #FFFFFF/getaccs [ID/Логин]", pl, 255, 200, 0, true)
end
end)

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

addEventHandler ("onPlayerLogin", root, function(_, acc)
if isObjectInACLGroup("user." ..getAccountName(acc), aclGetGroup("Scripter")) then 
	setElementData (source, "tegS", true)
elseif isObjectInACLGroup("user." ..getAccountName(acc), aclGetGroup("Oleg")) then 
	setElementData (source, "tegO", true)
elseif isObjectInACLGroup("user." ..getAccountName(acc), aclGetGroup("Admin")) then 
	setElementData (source, "tegA", true)
elseif isObjectInACLGroup("user." ..getAccountName(acc), aclGetGroup("SuperModerator")) then 
	setElementData (source, "tegS", true)
elseif isObjectInACLGroup("user." ..getAccountName(acc), aclGetGroup("Moderator")) then 
	setElementData (source, "tegM", true)
end
end)