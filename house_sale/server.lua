
addEvent("onHouseSystemHouseCreate", true)
addEvent("onHouseSystemHouseLock", true)
addEvent("onHouseSystemHouseDeposit", true)
addEvent("onHouseSystemHouseWithdraw", true)
addEvent("onHouseSystemWeaponDeposit", true)
addEvent("onHouseSystemWeaponWithdraw", true)
addEvent("onHouseSystemRentableSwitch", true)
addEvent("onHouseSystemRentalprice", true)
addEvent("onHouseSystemTenandRemove", true)
addEvent("onHouseSystemInfoBuy", true)
addEvent("onHouseSystemInfoRent", true)
addEvent("onHouseSystemInfoEnter", true)



db = nil
function initDatabase()
	db = dbConnect("sqlite", "houses.db")
	dbExec(db, "CREATE TABLE IF NOT EXISTS houses (ID, POS, INTERIOR, DIM, INTPOS, LOCKED, PRICE, OWNER, PARKING, KOM)") --10
end
initDatabase()

function getDBHouse ()
if db then
	return db
end
end

function getFreeID()
	local result = dbPoll(dbQuery(db, "SELECT ID FROM houses ORDER BY ID ASC"), -1)
	newID = false
	for i, id in pairs (result) do
		if id["ID"] ~= i then
			newID = i
			break
		end
	end
	if newID then return newID else return #result + 1 end
end

function getFreeDim()
	local result = dbPoll(dbQuery(db, "SELECT DIM FROM houses ORDER BY DIM ASC"), -1)
	newID = false
	for i, id in pairs (result) do
		if id["DIM"] ~= i then
			newID = i
			break
		end
	end
	if newID then return newID else return #result + 1 end
end

function getPlayerHouses (pl)
local result = dbPoll(dbQuery(db, "SELECT * FROM houses WHERE OWNER = ?", getAccountName (getPlayerAccount(pl)) ), -1)
return #result
end

local max_player_houses = 2
local sellhouse_value = 80
local open_key = "F5"
local leave_key = "lalt"

local timeRent = 1000*60*60*24*1

local pickup = {}
local pickupInt = {}

addEventHandler ("onResourceStart", resourceRoot, function()
if db then
	local result = dbPoll(dbQuery(db, "SELECT * FROM houses"), -1)
	for i, v in ipairs (result) do
		buildHouse (v["ID"], v["POS"], v["INTERIOR"], v["INTPOS"], v["OWNER"], v["PRICE"], v["KOM"], v["PARKING"], v["LOCKED"])
	end
	setTimer(takePlayerRent, timeRent, 0)
end
end)

function buildHouse (i, pos, int, intpos, owner, price, kom, parking, locked)
		if owner == "Свободен" then
			if pos then
				pickup[i] = createPickup (fromJSON(pos)[1], fromJSON(pos)[2], fromJSON(pos)[3], 3, 1273, 100)
				pickupInt[i] = createPickup (fromJSON(intpos)[1], fromJSON(intpos)[2], fromJSON(intpos)[3], 3, 1318, 100)
				blip = createBlip(fromJSON(pos)[1], fromJSON(pos)[2], fromJSON(pos)[3], 31, 2, 255, 0, 0, 255, 0, 50)
			end
		else
			if pos then
				pickup[i] = createPickup (fromJSON(pos)[1], fromJSON(pos)[2], fromJSON(pos)[3], 3, 1272, 100)
				pickupInt[i] = createPickup (fromJSON(intpos)[1], fromJSON(intpos)[2], fromJSON(intpos)[3], 3, 1318, 100)
				blip = createBlip(fromJSON(pos)[1], fromJSON(pos)[2], fromJSON(pos)[3], 32, 2, 255, 0, 0, 255, 0, 50)
			end
		end
		setElementInterior (pickupInt[i], int)
		setElementDimension (pickupInt[i], i)
		
		local house = pickup[i]
		local inter = pickupInt[i]
		
		------------
		-- EVENTS --
		------------
		
		-- IN
		local moveT = {"forwards", "backwards", "left", "right", "sprint"}
		addEventHandler("onPickupHit", pickup[i], function(hitElement)
			if(getElementType(hitElement) == "player") then
				for i, v in ipairs (moveT) do
					setControlState (hitElement, v, false)
				end
				togglePlayerInfomenue (hitElement, i)
			end
		end)
		
		pickup[i] = {}
		
		
		pickup[i]["HOUSE"] = house
		pickup[i]["LOCKED"] = locked or 0
		pickup[i]["PRICE"] = price or "N/A"
		pickup[i]["OWNER"] = owner or "Свободен"
		pickup[i]["PARKING"] = parking or "0"
		pickup[i]["KOM"] = kom or "0"
		pickup[i]["BLIP"] = blip
		pickup[i]["POS"] = pos
		
		pickupInt[i] = {}
		
		pickupInt[i]["INTER"] = inter
		pickupInt[i]["INTPOS"] = intpos
		pickupInt[i]["INTERIOR"] = int
		pickupInt[i]["DIMENSION"] = i
		
end

function togglePlayerInfomenue (pl, id)
if id then
	local house = pickup[id]
	local x, y, z = getElementPosition (house["HOUSE"])
	local owner = house["OWNER"]
	local price = house["PRICE"]
	local locked = house["LOCKED"]
	local parking = house["PARKING"]
	local kom = house["KOM"]
	local owner_bool = false
	if(getAccountName(getPlayerAccount(pl)) == owner) then
		owner_bool = true
	end
	triggerClientEvent (pl, "onClientHouseSystemInfoMenueOpen", pl, owner, x, y, z, price, locked, id, kom, parking,owner_bool)
end
end

local saveableValues = {
	["LOCKED"] = "LOCKED",
	["OWNER"] = "OWNER",
}

function setpickup(ID, typ, value)
	-- Security array -- 
	pickup[ID][typ] = value
	if(saveableValues[typ]) then
		local query = dbExec(db, "UPDATE houses SET "..saveableValues[typ].." = ? WHERE ID = ?", value, ID )
		if not (query) then
			error("[ДОМА] Не удалось установить дату: "..typ.." со значением: "..value.." для дома "..ID.."!")
		end
	end
end

addCommandHandler("cdom", function(thePlayer)
	if(hasObjectPermissionTo ( thePlayer, "function.kickPlayer", false ) ) then
		if(getElementInterior(thePlayer) ~= 0) then
			outputChatBox("Вы не снаружи!", thePlayer, 255, 0, 0)
			return
		end
		if(isPedInVehicle(thePlayer) == true) then
			outputChatBox("Пожалуйста, выйдите из автомобиля.", thePlayer, 255, 0, 0)
			return
		end
		triggerClientEvent(thePlayer, "onClientHouseSystemGUIStart", thePlayer)
	else
		outputChatBox("Вы не администратор!", thePlayer, 255, 0, 0)
	end
end)

addEventHandler("onHouseSystemHouseCreate", getRootElement(), function(x, y, z, int, intx, inty, intz, price, parking, kom)
	local newid = getFreeID ()
	local query = dbQuery(db, "INSERT INTO houses (ID, POS, INTERIOR, DIM, INTPOS, LOCKED, PRICE, OWNER, PARKING, KOM) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", newid, toJSON({x, y, z}), int, getFreeDim (),toJSON ({intx, inty, intz}), 0, price, "Свободен", parking, kom)
	local result, numrows = dbPoll(query, -1)
	if(result) then
		print("Дом "..newid.." создан!")
		buildHouse(newid, toJSON({x, y, z}), int, toJSON ({intx, inty, intz}), "Свободен", price, kom, parking, false)
	else
		error("Произошла ошибка в создании "..newid.." дома!")
	end
end)


function buy(thePlayer)
local house = getElementWithingWith (thePlayer)
	if (house) then
		local id = getHouseID (house)
		local owner = pickup[id]["OWNER"]
		if(owner ~= "Свободен") then
			outputChatBox("Этот дом уже занят!", thePlayer, 255, 0, 0)
		else
			local houses = getPlayerHouses (thePlayer)
			if (houses == max_player_houses) then
				outputChatBox("У вас уже имеется "..max_player_houses.." дома.", thePlayer, 255, 0, 0)
			return
			end
			local money = getPlayerMoney(thePlayer)
			local price = pickup[id]["PRICE"]
			if(money < price) then outputChatBox("У вас не хватает денег! Вам нехватает "..(price-money).."$!", thePlayer, 255, 0, 0) return end
			setpickup(id, "OWNER", getAccountName(getPlayerAccount(thePlayer)))
			takePlayerMoney(thePlayer, price)
			outputChatBox("Поздравляем! Вы купили дом!", thePlayer, 0, 255, 0)
			setPickupType(pickup[id]["HOUSE"], 3, 1272)
			setBlipIcon(pickup[id]["BLIP"], 32)
			triggerEvent ( "playerBoughtHouse", thePlayer, pickup[id] )
		end
	end
end

function sell (thePlayer)
local house = getElementWithingWith (thePlayer)
if(house) then
	local id = getHouseID (house)
	local owner = pickup[id]["OWNER"]
	if(owner ~= getAccountName(getPlayerAccount(thePlayer))) then
		outputChatBox("Это не твой дом!", thePlayer, 255, 0, 0)
	else
		local price = pickup[id]["PRICE"]
		setpickup(id, "OWNER", "Свободен")
		setpickup(id, "LOCKED", 0)
		givePlayerMoney(thePlayer, math.floor(price/100*sellhouse_value))
		outputChatBox("Вы успешно продали этот дом и получили"..math.floor(price/100*sellhouse_value).." назад!", thePlayer, 0, 255, 0)
		setPickupType(pickup[id]["HOUSE"], 3, 1273)
		setBlipIcon(pickup[id]["BLIP"], 31)
	end
end
end

function buyHouse (id, value)
if pickup[id] then
	if value == true then
		buy (source)
	else
		sell (source)
	end
end
end		
addEventHandler ("onHouseSystemInfoBuy", root, buyHouse)

function inINT (id)
if pickup[id] then
	local house = getElementWithingWith (source)
	if(house) then
		if (tonumber(pickup[id]["LOCKED"]) == 0) or (pickup[id]["OWNER"] == getAccountName(getPlayerAccount(source))) then
			local x, y, z = fromJSON(pickupInt[id]["INTPOS"])[1], fromJSON(pickupInt[id]["INTPOS"])[2], fromJSON(pickupInt[id]["INTPOS"])[3]
			local int, intx, inty, intz, dim = pickupInt[id]["INTERIOR"], x, y, z, pickupInt[id]["DIMENSION"]
			setInPosition(source, intx, inty, intz, int, false, dim)
			unbindKey(source, open_key, "down", togglePlayerInfomenue, id)
			outputChatBox ("Для выхода из дома нажмите кнопку "..leave_key, source, 50, 200, 50)
			if(pickup[id]["OWNER"] == getAccountName(getPlayerAccount(source))) then
				--bindKey(source, open_key, "down", togglePlayerHousemenue, id)
			end
			bindKey(source, leave_key, "down", leaveHome )
		else
			outputChatBox("У вас нету ключа от этого дома!", thePlayer, 255, 0, 0)
		end
	end
end
end
addEventHandler("onHouseSystemInfoEnter", getRootElement(), inINT)

function leaveHome (pl)
local house = getElementWithingWith (pl)
if(house) then
	print (getHouseINTID (house))
	local id = getHouseINTID (house) 
	local x, y, z = fromJSON(pickup[id]["POS"])[1],  fromJSON(pickup[id]["POS"])[2],  fromJSON(pickup[id]["POS"])[3]
	setInPosition(pl, x, y, z, 0, false, 0)
	unbindKey(pl, leave_key, "down", leaveHome)
end
end

addCommandHandler ("lock", function(pl)
local house = getElementWithingWithINT (pl)
if getElementInterior (pl) == 0 then return end
if house then
	local id = getHouseINTID (house) 
	if pickup[id]["LOCKED"] == 0 then
		setpickup(id, "LOCKED", 1)
		outputChatBox ("Вы закрыли свой дом", pl, 0, 255, 0)
	elseif pickup[id]["LOCKED"] == 1 then
		setpickup(id, "LOCKED", 0)
		outputChatBox ("Вы открыли свой дом", pl, 0, 255, 0)
	end
else
	outputChatBox ("Встаньте на маркер", pl, 0, 255, 0)
end
end)

addCommandHandler ("thome", function(pl, cmd, id)
if not tonumber(id) then outputChatBox ("[ДОМ] Синтаксис: /home [номер дома]", pl, 255, 200, 0) return end
	if pickup[tonumber(id)] then
		local x, y, z = fromJSON(pickup[tonumber(id)]["POS"])[1],  fromJSON(pickup[tonumber(id)]["POS"])[2],  fromJSON(pickup[tonumber(id)]["POS"])[3]
		setInPosition(pl, x, y, z, 0, false, 0)
	else
		outputChatBox ("[ДОМ] Дома с таким номером нету!", pl, 255, 200, 0)
	end
end)

function dprint (...)
local msg = table.concat({...}, " ")
outputDebugString (tostring(msg))
end

local tableH = {
{"#FF0000[АДМИН] #FFCC00Создать дом: #00FF00/cdom"},
{"#FF0000[АДМИН] #FFCC00Коммуналка: #00FF00/rentableHouse"},
{"Закрыть дом (Вводить внутри дома): #00FF00/lock"},
}

function helpH (pl)
for i = 1, 15 do
outputChatBox (" ", pl, 255, 200, 0)
end
for i, v in ipairs (tableH) do
	outputChatBox (unpack (v), pl, 255, 200, 0, true)
end
end
addCommandHandler ("hhelp", helpH)

function getPlayerHouseParking (pl)
local parking = 0
local acc = getAccountName (getPlayerAccount(pl))
for i, v in ipairs (pickup) do
	if v["OWNER"] == acc then
		parking = parking + v["PARKING"]
	end
end
return parking
end

function isPlayerHouse (pl)
local acc = getAccountName (getPlayerAccount(pl))
for i, v in ipairs (pickup) do
	if v["OWNER"] == acc then
		return true
	end
end
return false
end

function getPlayerHouse (pl)
local acc = getAccountName (getPlayerAccount(pl))
for i, v in ipairs (pickup) do
	if v["OWNER"] == acc then
		return v
	end
end
end

function getHouseRent (pl)
local price = 0
local acc = getAccountName (getPlayerAccount(pl))
if isPlayerHouse (pl) then
	for i, v in ipairs (pickup) do
		if v["OWNER"] == acc then
			price = price + v["KOM"]
		end
	end
	return price
end
end

function getHouseID (el)
if getElementType (el) ~= "pickup" then return end
for i, v in ipairs (pickup) do
	if v["HOUSE"] == el then
		return i
	end
end
end

function removePlayerHouse (pl)
local acc = getAccountName (getPlayerAccount(pl))
for i, v in ipairs (pickup) do
	if v["OWNER"] == acc then
		local id = getHouseID (v["HOUSE"])
		setpickup(id, "OWNER", "Свободен")
		setpickup(id, "LOCKED", 0)
		setPickupType(v["HOUSE"], 3, 1273)
		setBlipIcon(v["BLIP"], 31)
		givePlayerMoney (pl, math.floor(v["PRICE"]/100*50))
		setElementData (pl, "Коммуналка:Дома", 0)
	end
end
end

function takePlayerRent()
	for index, player in pairs(getElementsByType("player")) do
		if (isPlayerHouse(player) ~= false) then
			local house = getPlayerHouse(player)
			local owner = house["OWNER"]
			local rentprice = tonumber(getHouseRent(player))
			setElementData (player, "Коммуналка:Дома", (getElementData (player, "Коммуналка:Дома") or 0) + rentprice)
			if getElementData (player, "Коммуналка:Дома") >= 1000000 then
				outputChatBox ("У вас забрали все дома за неоплату банку!", player, 255, 0, 0)
				removePlayerHouse (player)
			elseif getElementData (player, "Коммуналка:Дома") < 1000000 and getElementData (player, "Коммуналка:Дома") >= 9500000 then
				outputChatBox ("У вас задолженость банку по комуннальным услугам!", player, 255, 0, 0)
				outputChatBox("Оплатить счет можно в ближайшем банке!", player, 255, 255, 0)
			elseif getElementData (player, "Коммуналка:Дома") < 9500000 then
				outputChatBox("Поступил счет за дома в размере $"..rentprice.."!", player, 255, 255, 0)
				outputChatBox("Оплатить счет можно в ближайшем банке!", player, 255, 255, 0)
			end
		end
	end
end
addCommandHandler ("rentableHouse", takePlayerRent)

function getHouseINTID (el)
if getElementType (el) ~= "pickup" then return end
for i, v in ipairs (pickupInt) do
	if v["INTER"] == el then
		return i
	end
end
end