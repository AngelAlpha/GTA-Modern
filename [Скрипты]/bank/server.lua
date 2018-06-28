local db = dbConnect("sqlite","database.db")
local networkTroubles = {}
local transferLimit = {}

addEventHandler("onResourceStart",resourceRoot,
function()
	dbExec(db,"CREATE TABLE IF NOT EXISTS `clients` (`serial` TEXT,`account` TEXT,`money` TEXT)")
	
	setTimer(function()
		transferLimit = {}
	end,86400000,0)
end)
 
addEventHandler("onPlayerLogin",getRootElement(),
function(_,theCurrentAccount)
	local login = getAccountName(theCurrentAccount)
	local serial = getPlayerSerial(source)
	local query = dbQuery(db,"SELECT * FROM `clients` WHERE `account` = '"..login.."';")
	local result = dbPoll(query,-1)
	if (result and result[1]) then
		setElementData(source,"bank.money",tonumber(result[1].money))
	else
		setElementData(source,"bank.money",0)
		local query = dbQuery(db,"INSERT INTO `clients` (`serial`,`account`,`money`) VALUES ('"..serial.."','"..login.."','0');")
		dbFree(query)
	end
end)

addEventHandler("onPlayerLogout",getRootElement(),
function(_,theCurrentAccount)
	removeElementData(source,"bank.money")
end)

addEventHandler("onElementDataChange",getRootElement(),
function(dataName,oldValue)
	if client and dataName == "bank.money" then
		outputDebugString("Игрок '"..getPlayerName(source).."' был исключен из игры в подозрении в читерстве! Взлом переменной хранящей деньги в банке.")
		outputDebugString("Деньги раньше в банке: "..(getElementData(source,"bank.money") or 0))
		setElementData(source,"bank.money",0)
		setPlayerMoney(source,0)
		local query = dbQuery(db,"UPDATE `clients` SET `money` = '0' WHERE `account` = '"..getAccountName(getPlayerAccount(source)).."';")
		kickPlayer(source)
		dbFree(query)
	end
end)

addEventHandler("onPlayerNetworkStatus",root,
function(status,ticks)
	networkTroubles[source] = status
end)

function playerMoneyPut(money)
	if not networkTroubles[source] or networkTroubles[source] > 0 then
		if getPlayerMoney(source) < money then
			outputChatBox("#ff0000Ошибка:#ffffff У вас денег меньше чем вы вводите!",source,255,255,255,true)
			return true
		end
		takePlayerMoney(source,money)
		setElementData(source,"bank.money",(getElementData(source,"bank.money") or 0) + money)
		local query = dbQuery(db,"UPDATE `clients` SET `money` = '"..(getElementData(source,"bank.money") or 0).."' WHERE `account` = '"..getAccountName(getPlayerAccount(source)).."';")
		dbFree(query)
		outputChatBox("Вы положили на счёт '"..money.."'$",source,255,255,0,true)
		triggerClientEvent(source,"updateBankWindow",source)
	end
end
addEvent("player:moneyPut",true)
addEventHandler("player:moneyPut",getRootElement(),playerMoneyPut)

function playerMoneyTake(money)
	if not networkTroubles[source] or networkTroubles[source] > 0 then
		if (getElementData(source,"bank.money") or 0) < money then
			outputChatBox("#ff0000Ошибка:#ffffff У вас денег меньше чем вы вводите!",source,255,255,255,true)
			return true
		end
		givePlayerMoney(source,money)
		setElementData(source,"bank.money",(getElementData(source,"bank.money") or 0) - money)
		local query = dbQuery(db,"UPDATE `clients` SET `money` = '"..(getElementData(source,"bank.money") or 0).."' WHERE `account` = '"..getAccountName(getPlayerAccount(source)).."';")
		dbFree(query)
		outputChatBox("Вы сняли со счета '"..money.."'$",source,255,255,0,true)
		triggerClientEvent(source,"updateBankWindow",source)
	end
end
addEvent("player:moneyTake",true)
addEventHandler("player:moneyTake",getRootElement(),playerMoneyTake)

function playerMoneyTakeBank(money)
	if not networkTroubles[source] or networkTroubles[source] > 0 then
		if (getElementData(source,"bank.money") or 0) < money then
			outputChatBox("#ff0000Ошибка:#ffffff У вас денег меньше чем вы вводите!",source,255,255,255,true)
			return true
		end
		if (tonumber(getElementData (source, "Коммуналка:Дома")) or 0) <= 0 then
			outputChatBox("Вы уже оплатили коммунальные услуги!",source,255,255,0,true)
		elseif (tonumber(getElementData (source, "Коммуналка:Дома")) or 0) < money then
			local cost = tonumber(getElementData (source, "Коммуналка:Дома"))
			setElementData (source, "Коммуналка:Дома", 0)
			setElementData(source,"bank.money",(getElementData(source,"bank.money") or 0) - cost)
			local query = dbQuery(db,"UPDATE `clients` SET `money` = '"..(getElementData(source,"bank.money") or 0).."' WHERE `account` = '"..getAccountName(getPlayerAccount(source)).."';")
			dbFree(query)
			outputChatBox("У вас снялось со счета '"..cost.."'$",source,255,255,0,true)
			triggerClientEvent(source,"updateBankWindow",source)
		else
			setElementData(source,"bank.money",(getElementData(source,"bank.money") or 0) - money)
			local query = dbQuery(db,"UPDATE `clients` SET `money` = '"..(getElementData(source,"bank.money") or 0).."' WHERE `account` = '"..getAccountName(getPlayerAccount(source)).."';")
			dbFree(query)
			outputChatBox("У вас снялось со счета '"..money.."'$",source,255,255,0,true)
			setElementData (source, "Коммуналка:Дома", (tonumber(getElementData (source, "Коммуналка:Дома")) - money))
			triggerClientEvent(source,"updateBankWindow",source)
		end
	end
end
addEvent("player:moneyTakeBank",true)
addEventHandler("player:moneyTakeBank",getRootElement(),playerMoneyTakeBank)

function playerMoneyTransfer(money,player,name)
	if not networkTroubles[source] or networkTroubles[source] > 0 then
		if (getElementData(source,"bank.money") or 0) < money then
			outputChatBox("#ff0000Ошибка:#ffffff У вас денег в банке меньше чем вы хотите перевести!",source,255,255,255,true)
			return true
		end
		
		--[[if transferLimit[ getPlayerSerial(source) ] + money >= maxTransfer then
			outputChatBox("#ff0000Ошибка:#ffffff Вы превысили лимит перевода денег!",source,255,255,255,true)
			return false
		end]]--
		
		setElementData(source,"bank.money",(getElementData(source,"bank.money") or 0) - money)
		setElementData(player,"bank.money",(getElementData(player,"bank.money") or 0) + money)
		
		outputChatBox("Вы перевели на счёт игрока "..name.." "..money.."$",source,255,255,0,true)
		outputChatBox("Вам перевел на счёт игрок "..string.gsub(getPlayerName(source),"#%x%x%x%x%x%x","").." "..money.."$",player,255,255,0,true)
		
		triggerClientEvent(source,"updateBankWindow",source)
		
		local query = dbQuery(db,"UPDATE `clients` SET `money` = '"..(getElementData(source,"bank.money") or 0).."' WHERE `account` = '"..getAccountName(getPlayerAccount(source)).."';")
		dbFree(query)
		
		local query = dbQuery(db,"UPDATE `clients` SET `money` = '"..(getElementData(player,"bank.money") or 0).."' WHERE `account` = '"..getAccountName(getPlayerAccount(source)).."';")
		dbFree(query)
		
		transferLimit[ getAccountName(getPlayerAccount(source)) ] = (transferLimit[ getAccountName(getPlayerAccount(source)) ] or 0) + money
			
	end
end
addEvent("player:moneyTransfer",true)
addEventHandler("player:moneyTransfer",getRootElement(),playerMoneyTransfer)

function AccrualInterest()
	local players = getElementsByType("player")
	for i, player in ipairs(players) do
	    local moneySource = tonumber(getElementData(player, "bank.money"))
		local money = moneySource * (perchant / 100)
		setElementData(player,"bank.money",(getElementData(player,"bank.money") or 0) + money)
		outputChatBox("Вам начислено "..perchant.."% от суммы в банке. Ваш заработок составил: "..math.floor(money).. "$",player,255,255,0,true)
	end
end
setTimer(AccrualInterest,minute * 60000,0)
addCommandHandler ("bank", AccrualInterest)
--setTimer(AccrualInterest,20000,0)