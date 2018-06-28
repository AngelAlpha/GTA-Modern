db = nil
function initDatabase()
	db = dbConnect("sqlite", "database.db")
	--dbExec(db, "DROP TABLE Vehicles")
	dbExec(db, "CREATE TABLE IF NOT EXISTS Vehicles (ID, Account, Model, X, Y, Z, RotZ, Colors, Upgrades, Paintjob, HP, Handlings, Fuel, Number, Toner, Vinil, Mileage, ramka)") -- 16
	dbExec(db, "CREATE TABLE IF NOT EXISTS Market (ID, OldID, Owner, Price, Date)")
end
initDatabase()

function getDBCarShop ()
if db then
	return db
end
end

local lastPosition = {}

local numberSymbols =
{
	'A',
	'B',
	'C',
	'Y',
	'O',
	'P',
	'T',
	'E',
	'X',
	'M',
	'H',
	'K'
}

function stopTestDrive(veh)
	if not veh then return end
	local ply = getVehicleController(veh)
	if ply then
		fadeCamera(ply,false,1)
		setTimer(function(ply,veh)
			removePedFromVehicle(ply)
			local pos = getElementData(veh,"pos")
			setElementPosition(ply,pos[1],pos[2],pos[3])
			outputChatBox("#ffffff*Тест-драйв #ff0000окончен",ply,255,255,255,true)
		end,1000,1,ply,veh)
		setTimer(function(ply)
			fadeCamera(ply,true,1)
		end,1500,1,ply)
	end
	setTimer(destroyElement,2000,1,veh)
	triggerClientEvent(ply,"initDemoTimer",ply)
end

function startTestDrive(id)
	fadeCamera(source,false,1)
	local pos = testDriveSpawnPosition
	local veh = createVehicle(id,pos[1],pos[2],pos[3],0,0,pos[4])
	local oldx,oldy,oldz = getElementPosition(source)
	setVehicleColor(veh,200,200,200)
	setElementData(veh,"numberType","c")
	setElementData(veh,"number:plate","Тест Драйв")
	setElementData(veh,"tdrive",true)
	setElementData(veh,"ID","tdrive")
	setElementData(veh,"pos",{oldx,oldy,oldz})
	if defaultHandlingTable[getElementModel(veh)] then
		updateVehicleHandlings(veh,defaultHandlingTable[getElementModel(veh)])
	end
	setTimer(function(ply,veh) 
		warpPedIntoVehicle(ply,veh) 
		fadeCamera(ply,true,1)
		triggerClientEvent(ply,"initDemoTimer",ply)
	end,1500,1,source,veh)
	setTimer(stopTestDrive,60000,1,veh)
	outputChatBox("#ffffff*Вы начали тест-драйв автомобиля. Через минуту он будет #ff0000окончен",source,255,255,255,true)
end
addEvent("startTestDrive",true)
addEventHandler("startTestDrive",root,startTestDrive)

addEventHandler ( "onVehicleStartExit", getRootElement(), function()
	if getElementData(source,"tdrive") then
		stopTestDrive(source)
		cancelEvent()
	end
end)

--[[
function buyNumberPlate(type,text,price, admin)
	local num = toJSON({type,text})
	local result = dbPoll(dbQuery(db, "SELECT * FROM Vehicles WHERE Number = ?",num),-1)
	if #result < 1 then
		local veh = getPedOccupiedVehicle(source)
		if getElementData(veh,"owner") ~= getAccountName(getPlayerAccount(source)) and not isObjectInACLGroup ("user."..getAccountName(getPlayerAccount(source)), aclGetGroup ( "Admin" ) ) then
			outputChatBox("Это не ваш автомобиль!",source,200,0,0)
			return
		end
		if veh then
			if getPlayerMoney(source) >= price then
				takePlayerMoney(source,price)
				setElementData(veh,"numberType",type)
				setElementData(veh,"number:plate",text)
				local id = getElementData(veh, "ID")
				dbExec(db, "UPDATE Vehicles SET Number=? WHERE Account = ? AND ID = ?", num, getAccountName(getPlayerAccount(source)), id)
				outputChatBox("Вы успешно приобрели данный номер",source,0,200,0)
			else
				outputChatBox("У вас недостаточно денег!",source)
			end
		else
			outputChatBox("Вы должны быть в машине!",source)
		end
	else
		outputChatBox("Такие номера уже существуют!",source)
	end
end
addEvent("buyNumberPlate", true)
addEventHandler("buyNumberPlate", root, buyNumberPlate)
]]--

function setPlayerDimension(dim)
	setElementDimension(source,dim)
end
addEvent("setPlayerDimension",true)
addEventHandler("setPlayerDimension",root,setPlayerDimension)

function getFreeID()
	local result = dbPoll(dbQuery(db, "SELECT ID FROM Vehicles ORDER BY ID ASC"), -1)
	newID = false
	for i, id in pairs (result) do
		if id["ID"] ~= i then
			newID = i
			break
		end
	end
	if newID then return newID else return #result + 1 end
end

function getMarketFreeID()
	local result = dbPoll(dbQuery(db, "SELECT ID FROM Market ORDER BY ID ASC"), -1)
	newID = false
	for i, id in pairs (result) do
		if id["ID"] ~= i then
			newID = i
			break
		end
	end
	if newID then return newID else return #result + 1 end
end

function switchVehicleNumberPlate(vehid,newplate,delete)
	local numbers = getElementData(source,"numbers")
	if getPlayerMoney(source) >= numberSwitchPrice then
		takePlayerMoney(source,numberSwitchPrice)
	else
		return
	end
	for k,v in pairs(numbers) do
		if v[1] == newplate[1] and v[2] == newplate[2] then
			if delete then
				table.remove(numbers,k)
				setElementData(source,"numbers",numbers)
				setAccountData(getPlayerAccount(source), "numbers", toJSON(getElementData(source,"numbers")))
				updateVehicles(source)
				break
			end
			dbExec(db, "UPDATE Vehicles SET Number = ? WHERE ID = ?", toJSON(newplate),vehid)
			local veh = findVeh(vehid)
			if veh then
				setElementData(veh,"numberType",nil)
				setElementData(veh,"number:plate",nil)
			end
			for key,val in pairs(getElementData(source,"vehicles")) do
				if val["ID"] == vehid then
					if val["Number"] then
						local realNum = fromJSON(val["Number"])
						if realNum[1] == "c" and realNum[2] == "" then
							-- DO NOTHING
						else
							table.insert(numbers,realNum)
						end
					end
				end
			end
			table.remove(numbers,k)
			setElementData(source,"numbers",numbers)
			setAccountData(getPlayerAccount(source), "numbers", toJSON(getElementData(source,"numbers")))
			updateVehicles(source)
			break
		end
	end
	if newplate[1] == "c" and newplate[2] == "" then
		dbExec(db, "UPDATE Vehicles SET Number = ? WHERE ID = ?", nil,vehid)
		local veh = findVeh(vehid)
		if veh then
			setElementData(veh,"number:plate", nil)
			setElementData(veh,"numberType", nil)
		end
		for key,val in pairs(getElementData(source,"vehicles")) do
			if val["ID"] == vehid then
				if val["Number"] then
					local realNum = fromJSON(val["Number"])
					if realNum[1] == "c" and realNum[2] == "" then
						-- DO NOTHING
					else
						table.insert(numbers,realNum)
						setElementData(source,"numbers",numbers)
						setAccountData(getPlayerAccount(source), "numbers", toJSON(getElementData(source,"numbers")))
						updateVehicles(source)
					end
				end
			end
		end
	end
end
addEvent("switchVehicleNumberPlate",true)
addEventHandler("switchVehicleNumberPlate",root,switchVehicleNumberPlate)

function updateVehicles(ply)
	local account = getAccountName(getPlayerAccount(ply))

	local result = dbPoll(dbQuery(db, "SELECT * FROM Vehicles WHERE Account = ?", account), -1)
	if type(result) == "table" then
		setElementData(ply,"vehicles",result)
	end

	local soldtab = {}
	local result2 = dbPoll(dbQuery(db, "SELECT * FROM Market WHERE Owner = ?", account), -1)
	if result2 and type(result2) == "table" then
		for k,v in pairs(result2) do
			local vehdata = dbPoll(dbQuery(db, "SELECT * FROM Vehicles WHERE ID = ?", v["OldID"]), -1)[1]
			table.insert(soldtab,vehdata)
		end
	end
	setElementData(ply,"soldvehicles",soldtab)

	local numbers = getAccountData(getPlayerAccount(ply),"numbers")

	if numbers then
		setElementData(ply,"numbers",fromJSON(numbers))
	else
		setElementData(ply,"numbers",{})
		setAccountData(getPlayerAccount(ply), "numbers", toJSON(getElementData(ply,"numbers")))
	end
end

function refreshCar (ply)
updateVehicles(ply)
end
addEvent ("refreshCar", true)
addEventHandler ("refreshCar", root, refreshCar)

function getPlayerVehiclesCount(ply)
	local account = getAccountName(getPlayerAccount(ply))
	local result = dbPoll(dbQuery(db, "SELECT * FROM Vehicles WHERE Account = ?", account), -1)
	local count = 0
	if result and type(result) == "table" then
		count = count + #result
	end
	local result2 = dbPoll(dbQuery(db, "SELECT * FROM Market WHERE Owner = ?", account), -1)
	if result2 and type(result2) == "table" then
		count = count + #result2
	end
	return count
end

function blockVehicle(ply,veh)
	if veh then
		if getElementData(veh,"owner") == getAccountName(getPlayerAccount(ply)) then
			if getElementData(veh,"blocked") then
				setElementData(veh,"blocked",false)
				setElementFrozen(veh, false)
				setVehicleDamageProof(veh, false)
				setVehicleLocked(veh,false)
				outputChatBox("#ffffff*Автомобиль #00ff00разблокирован",ply,255,255,255,true)
			else
				if exports["houses"]:getNearbyHouse(ply,veh) then
					setElementData(veh,"blocked",true)
					setElementFrozen(veh, true)
					setVehicleDamageProof(veh, true)
					setVehicleLocked(veh,true)
					outputChatBox("#ffffff*Автомобиль #ff0000заблокирован",ply,255,255,255,true)
				else
					outputChatBox("#ffffff*Автомобиль должен находиться около вашего дома!",ply,200,0,0,true)
				end
			end
		end
	else
		outputChatBox("#ffffff*Автомобиль #ff0000не #ffffffзаспавнен",ply,200,0,0,true)
	end
end
addEvent("blockVehicle",true)
addEventHandler("blockVehicle",root,blockVehicle)

function buyTheVehicle(buy_type, ply,shop,vehid,colorid,wheelsid,reg)
	local account = getPlayerAccount(ply)
	local accName = getAccountName(account)
	local vehicleData = getVehicleData(vehid)
	if getPlayerVehiclesCount(ply) >= exports["houses"]:getCarLimit(ply) then
		outputChatBox("#ffffff*У вас #ff0000недостаточно #ffffffпарковочных мест. Купите дом для расширения количества парковочных мест",ply,200,0,0,true)
		return
	end
	if account then
		local result = dbPoll(dbQuery(db, "SELECT * FROM Vehicles WHERE Account = ? AND Model = ?", accName,vehid), -1)
		--outputChatBox(#result)
		if not result or #result <= 50 then
		    if buy_type == "bank" then
			    if getElementData(ply,"bank.money") >= vehicleData[3] then
				    setElementData(ply,"bank.money", getElementData(ply,"bank.money") - vehicleData[3])
				else
				    outputChatBox("#ffffff*У вас #ff0000недостаточно #ffffffденег", ply, 200,0,0,true)
					return
				end
			elseif buy_type == "nall" then
			    if getPlayerMoney(ply) >= vehicleData[3] then
				    takePlayerMoney(ply,vehicleData[3])
				else
				    outputChatBox("#ffffff*У вас #ff0000недостаточно #ffffffденег", ply, 200,0,0,true)
					return
				end
			end
			--if getElementData(ply,"bank.money") >= vehicleData[3] then -- if getPlayerMoney(ply) >= vehicleData[3]+100 then
				local veh = createVehicle(vehicleData[1],vehShopsTable[shop][4],vehShopsTable[shop][5],vehShopsTable[shop][6],vehShopsTable[shop][7],vehShopsTable[shop][8],vehShopsTable[shop][9])
				local col = vehShopColors[colorid]
				setElementFrozen(veh,true)
				setTimer(setElementFrozen,2000,1,veh,false)
				--takePlayerMoney(ply,vehicleData[3]+100)
				--setElementData(ply,"bank.money", getElementData(ply,"bank.money") - vehicleData[3]+100)
				setVehicleColor(veh,col[1],col[2],col[3])
				if wheelsid ~= 1 then
					addVehicleUpgrade( veh, vehShopWheels[wheelsid])
				end
				warpPedIntoVehicle( ply, veh )
				local ID = getFreeID()
				setElementData(veh,"ID",ID)
				setElementData(veh,"owner",accName)
				setElementData(veh,"fuel",100)
				setElementData(veh,"numberType","ru")
				setElementData(veh,"mileage",0)
				setElementData(veh,"ramka","1.png")
				local s1 = numberSymbols[math.random(1,#numberSymbols)]
				local s2 = numberSymbols[math.random(1,#numberSymbols)]
				local s3 = numberSymbols[math.random(1,#numberSymbols)]
				local num = math.random(100,999)
				local region =  math.random(10,99)
				setElementData(veh,"number:plate",s1..num..s2..s3..reg)
				setElementData(veh,"vinil",false)

				local x,y,z = getElementPosition(veh)
				local _,_,rz = getElementRotation(veh)
				local c1,c2,c3,c4,c5,c6 = getVehicleColor(veh,true)
				local color = toJSON({c1,c2,c3,c4,c5,c6,255,255,255})
				local number = toJSON({getElementData(veh,"numberType"),getElementData(veh,"number:plate")})
				dbExec(db,"INSERT INTO Vehicles VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", ID, accName, vehicleData[1],x,y,z,rz,color,"","",1000,number,100,"","",0, getElementData(veh, "ramka"))
				addEventHandler("onVehicleDamage", veh,
				function(loss)
					setTimer(function(source) if isElement(source) then dbExec(db, "UPDATE Vehicles SET HP = ? WHERE ID = ?", getElementHealth(source), getElementData(source,"ID")) end end, 100, 1, source)
				end)
				if defaultHandlingTable[getElementModel(veh)] then
					updateVehicleHandlings(veh,defaultHandlingTable[getElementModel(veh)])
				end
				saveVehicle(veh)
				updateVehicles(ply)
		else
			outputChatBox("#ffffff*У вас уже есть этот автмообиль!", ply, 200,0,0,true)
		end
	end
end
addEvent("buyTheVehicle",true)
addEventHandler("buyTheVehicle",root,buyTheVehicle)

function saveVehicle(veh)
	local ID = getElementData(veh,"ID")
	local owner = getElementData(veh,"owner")
	local x,y,z = getElementPosition(veh)
	local _,_,rz = getElementRotation(veh)
	local c1,c2,c3,c4,c5,c6 = getVehicleColor(veh,true)
	local c7,c8,c9 = getVehicleHeadLightColor( veh )
	local color = toJSON({c1,c2,c3,c4,c5,c6,c7,c8,c9})
	local upgrade = ""
		for _, upgradee in ipairs (getVehicleUpgrades(veh)) do
			if upgrade == "" then
				upgrade = upgradee
			else
				upgrade = upgrade..","..upgradee
			end
		end
	local paintjob = getVehiclePaintjob( veh )
	local hp = getElementHealth(veh)
	local handlings = toJSON(getVehicleHandling( veh ))
	local fuel = getElementData(veh,"fuel")
	local number = toJSON({getElementData(veh,"numberType"),getElementData(veh,"number:plate")})
	
	local toner = toJSON({false,false,false})
	if getElementData(veh,"toner:toner") then
		toner = toJSON({getElementData(veh,"toner:toner"), getElementData(veh,"toner:type"),getElementData(veh,"toner:alpha")})
	end
		
	local vinil = getElementData(veh,"vinil")
	local mileage = getElementData(veh,"mileage") or 0
	local ramka = getElementData(veh,"ramka") or "1.png"
	lastPosition[veh] = nil
	dbExec(db, "UPDATE Vehicles SET X = ?, Y = ?, Z = ?, RotZ = ?, Colors = ?, Upgrades = ?, Paintjob = ?, HP = ?, Handlings = ?, Fuel = ?, Number = ?, Toner = ?, Vinil = ?, Mileage = ?, ramka = ? WHERE ID = ?",x,y,z,rz,color,upgrade,paintjob,hp,handlings,fuel,number,toner,vinil,mileage,ramka,ID)
end
addEvent("saveVehicle",true)
addEventHandler("saveVehicle",root,saveVehicle)


function setNumberPlate (ID, number)
if ID and number then
	dbExec(db, "UPDATE Vehicles SET Number = ? WHERE ID = ?",number,ID)
	--print ("ok")
end
end
addEvent ("setNumberPlate", true)
addEventHandler ("setNumberPlate", root, setNumberPlate)

function destroyTheVehicle(veh)
	if veh then
		saveVehicle(veh)
		destroyElement(veh)
	else
		outputChatBox("#ffffff*Машина #ff0000не #ffffffзаспавнена",source,255,255,255,true)
	end
end
addEvent("destroyTheVehicle",true)
addEventHandler("destroyTheVehicle",root,destroyTheVehicle)

function lockVehicle(veh)
	if veh then
		setVehicleLocked( veh, not isVehicleLocked( veh ) )
		if isVehicleLocked( veh ) then
			outputChatBox("#ffffff*Автомобиль #ff0000закрыт",source,255,255,255,true)
		else
			outputChatBox("#ffffff*Автомобиль #00ff00открыт",source,255,255,255,true)
		end
	else
		outputChatBox("#ffffff*Машина #ff0000не #ffffffзаспаунена",source,255,255,255,true)
	end
end
addEvent("lockVehicle",true)
addEventHandler("lockVehicle",root,lockVehicle)

function bringVehicle(veh)
	if not isPedInVehicle(source) then
		if veh then
			local x,y,z = getElementPosition(source)
			setElementPosition(veh,x+3,y+3,z+3)
		else
			outputChatBox("#ffffff*Машина #ff0000не #ffffffзаспаунена",source,255,255,255,true)
		end
	else
		outputChatBox("#ffffff*Сначала выйдите из машины!",source,255,255,255,true)
	end
end
addEvent("bringVehicle",true)
addEventHandler("bringVehicle",root,bringVehicle)

function sellVehicle(veh)
	if isDonateVehicle(getElementModel(veh)) then
		outputChatBox("#ffffff*Вы не можете продать донатную технику!",source,200,0,0,true)
		return
	end
	if veh then
		local ID = getElementData(veh,"ID")
		local mdl = getElementModel(veh)
		local data = getVehicleData(mdl)
		givePlayerMoney(source,data[3]/2)
		outputChatBox("#ffffff*Вы продали свой автомобиль за #00ff00"..(data[3]/2).."$",source,255,255,255,true)
		destroyElement(veh)
		dbExec(db,"DELETE FROM Vehicles WHERE ID = ?",ID)
		updateVehicles(source)
	else
		outputChatBox("#ffffff*Ваш автомобиль должен быть заспавнен!",source,255,255,255,true)
	end
end
addEvent("sellVehicle",true)
addEventHandler("sellVehicle",root,sellVehicle)

function switchVehicleManager()
	updateVehicles(source)
	triggerClientEvent( source, "initVehicleManager", source, getPlayerVehiclesCount(source).."/"..exports["houses"]:getCarLimit(source) )
end
addEvent("switchVehicleManager",true)
addEventHandler("switchVehicleManager",root,switchVehicleManager)

function loginEvent(_, account)
	local mon = getAccountData(account, "marketMoney")
	if mon then
		if mon > 0 then
			outputChatBox("Вы получили #00ff00$"..mon.." #ffffffза продажу автомобиля с Б/У рынка!",source,255,255,255,true)
			givePlayerMoney(source,mon)
			setAccountData(account,"marketMoney",0)
		end
	else
		setAccountData(account,"marketMoney",0)
	end
end
addEventHandler ( "onPlayerLogin", getRootElement(), loginEvent )

function spawnTheVehicle(id)
	local data = dbPoll(dbQuery(db, "SELECT * FROM Vehicles WHERE ID = ?", id), -1)[1]
	local vehicles = getElementsByType("vehicle")
	for k,v in pairs(vehicles) do
		if getElementData(v,"ID") == id then
			outputChatBox("Машина уже создана!",source)
			return
		end
	end
	local veh = createVehicle(data["Model"],data["X"],data["Y"],data["Z"],0,0,data["RotZ"])
	setElementData(veh,"owner",data["Account"])
	setElementData(veh,"fuel",data["Fuel"])
	setElementData(veh,"ID",data["ID"])
	--outputChatBox(data["ID"])
	if data["HP"] <= 300 then data["HP"] = 300 end
	setElementHealth(veh,data["HP"])
	setVehiclePaintjob( veh, data["Paintjob"] )

	if defaultHandlingTable[getElementModel(veh)] then
		updateVehicleHandlings(veh,defaultHandlingTable[getElementModel(veh)])
	end

	local handlings = fromJSON(data["Handlings"])
	for key,value in pairs(handlings) do
		setVehicleHandling(veh, key, value)
	end

	local colors = fromJSON(data["Colors"])
	setVehicleColor(veh,colors[1],colors[2],colors[3],colors[4],colors[5],colors[6])
	setVehicleHeadLightColor(veh, colors[7],colors[8],colors[9] )

	if data["Number"] then
		local number = fromJSON(data["Number"])
		if number[1] then
			setElementData(veh,"numberType",number[1])
			setElementData(veh,"number:plate",number[2])
		end
	end

	if data["Toner"] then
		local toner = fromJSON(data["Toner"])
		if toner[1] then
			setElementData(veh,"toner:toner",toner[1])
			setElementData(veh,"toner:type",toner[2])
			setElementData(veh,"toner:alpha",toner[3])
		else
			setElementData(veh,"toner",{})
		end
	end

	local vinil = data["Vinil"]
	if type(vinil) == "string" and #vinil >= 3 then
		setElementData(veh,"vinil",vinil)
	end

	local upd = split(tostring(data["Upgrades"]), ',')
	for i, upgrade in ipairs(upd) do
		addVehicleUpgrade(veh, upgrade)
	end

	local mileage = data["Mileage"]
	if mileage then
		setElementData(veh,"mileage",mileage)
	end
	local ramka = data["ramka"]
	if ramka then
		setElementData(veh,"ramka",ramka)
	end
	
	addEventHandler("onVehicleDamage", veh,
	function(loss)
		setTimer(function(source) if isElement(source) then dbExec(db, "UPDATE Vehicles SET HP = ? WHERE ID = ?", getElementHealth(source), getElementData(source,"ID")) end end, 100, 1, source)
	end)
end
addEvent("spawnTheVehicle",true)
addEventHandler("spawnTheVehicle",root,spawnTheVehicle)


addEventHandler("onVehicleDamage", root, function(loss)
	if getElementHealth(source) <= 300 then
		setElementHealth(source,300)
		--setVehicleDamageProof( source, true )
	else
		--setVehicleDamageProof( source, false )
	end
end)

function quitPlayer()
	local account = getPlayerAccount(source)
	local accName = getAccountName(account)
	local vehicles = getElementsByType("vehicle")
	for k,v in pairs(vehicles) do
		if getElementData(v,"owner") == accName then
			destroyTheVehicle(v)
		end
	end
end
addEventHandler ( "onPlayerQuit", getRootElement(), quitPlayer )

function pos(ply)
	local x,y,z = getElementPosition(ply)
	outputConsole( x..","..y..","..z, ply )
	local veh = getPedOccupiedVehicle( ply )
	if veh then
		local vx,vy,vz = getElementPosition(veh)
		local rx,ry,rz = getElementRotation(veh)
		outputConsole( vx..","..vy..","..vz..","..rx..","..ry..","..rz, ply )
	end
end
addCommandHandler( "pos", pos )

-- TRADING PART

function sendTradeOffer(ply,id,cash)
	local data = dbPoll(dbQuery(db, "SELECT * FROM Vehicles WHERE ID = ?", id), -1)[1]
	local name = getVehicleData(data["Model"])[2]
	if isDonateVehicle(data["Model"]) then
		outputChatBox("#ffffff*Вы не можете продать донатную технику!",source,200,50,50,true)
		return
	end

	if getPlayerVehiclesCount(ply) >= exports["houses"]:getCarLimit(ply) then
		outputChatBox("#ffffff*У игрока #ff0000недостаточно #ffffffпарковочных мест!",source,200,50,50,true)
		return
	end
	triggerClientEvent( ply, "cacheTradeOffer", source, id, name, cash )
end
addEvent("sendTradeOffer",true)
addEventHandler("sendTradeOffer",root,sendTradeOffer)

function tradeAccepted(ply,id,cash)
	if isElement(source) and isElement(ply) then
		local data = dbPoll(dbQuery(db, "SELECT * FROM Vehicles WHERE ID = ?", id), -1)[1]
		if data then
			local sellerAccountName = getAccountName(getPlayerAccount(ply)) 
			local buyerAccountName = getAccountName(getPlayerAccount(source))
			--outputChatBox(sellerAccountName.." "..buyerAccountName)
			if data["Account"] == sellerAccountName then
				if getPlayerMoney(source) >= cash then
					takePlayerMoney(source, cash)
					givePlayerMoney(ply,cash)
					dbExec(db, "UPDATE Vehicles SET Account = ? WHERE ID = ?", buyerAccountName, id)
					outputChatBox("#ffffff*Вы успешно #00ff00приобрели #ffffffавтомобиль",source,0,200,0,true)
					outputChatBox("#ffffff*Вы успешно #ff0000продали автомобиль",ply,0,200,0,true)
					local veh = findVeh(id)
					if veh then
						setElementData(veh,"owner",buyerAccountName)
					end
				else
					outputChatBox("#ffffff*У вас #ff0000недостаточно #ffffffденег!",source,200,0,0,true)
				end
			end
		end
	end
end
addEvent("tradeAccepted",true)
addEventHandler("tradeAccepted",root,tradeAccepted)

function giveVehicle(ply,cmd,login,id)
	local accName = getAccountName ( getPlayerAccount ( ply ) )
    if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) then
		local id = tonumber(id)
		if getAccount(login) then
			local veh = createVehicle(id,0,0,0)
			local dbID = getFreeID()
			local vehicleData = getVehicleData(id)
			local color = toJSON({255,255,255,255,255,255,255,255,255})
			local number = nil
			setElementData(veh,"ID",dbID)
			setElementData(veh,"owner",login)
			setElementData(veh,"fuel",100)
			setElementData(veh,"numberType",nil)
			setElementData(veh,"number:plate",nil)
			setElementData(veh,"vinil",false)
			dbExec(db,"INSERT INTO Vehicles VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", dbID, login, vehicleData[1],0,0,0,0,color,"","",1000,number,100,"","",0)
			destroyTheVehicle(veh)
			updateVehicles(ply)
		else
			outputChatBox("#ffffff*Аккаунта с таким логином #ff0000не #ffffffсуществует",255,255,255,true)
		end
	end
end
addCommandHandler("give",giveVehicle)

function toggleEngine()
	local ply = source
	local veh = getPedOccupiedVehicle(ply)
	if veh then
		if getVehicleController(veh) == ply then
			if getVehicleEngineState(veh) then
				setVehicleEngineState(veh,false)
			else
				if getElementData(veh,"fuel") then
					if getElementData(veh,"fuel") > 0 then
						setVehicleEngineState(veh,true)
					else
						outputChatBox("#ff0000*Нет #ffffffбензина",ply,200,0,0,true)
					end
				else
					setVehicleEngineState(veh,true)
				end
			end
		end
	end
end
addEvent("toggleEngine",true)
addEventHandler("toggleEngine",root,toggleEngine)

addEventHandler ( "onPlayerVehicleExit", getRootElement(), function(veh,seat)
	if seat == 0 then
		setVehicleEngineState(veh,false)
	end
end)

addEventHandler ( "onVehicleStartExit", getRootElement(), function()
end)

local handlingNamesTable = 
{
	"mass","turnMass","dragCoeff","centerOfMassX","centerOfMassY","centerOfMassZ","percentSubmerged","tractionMultiplier","tractionLoss", "tractionBias", "numberOfGears","maxVelocity","engineAcceleration","engineInertia",
	"driveType","engineType","brakeDeceleration","brakeBias","ABS","steeringLock","suspensionForceLevel","suspensionDamping","suspensionHighSpeedDamping","suspensionUpperLimit",
	"suspensionLowerLimit","suspensionFrontRearBias","suspensionAntiDiveMultiplier","seatOffsetDistance","collisionDamageMultiplier","monetary","modelFlags","handlingFlags"
}

function updateVehicleHandlings(veh,handlings,flags)
	if isElement(veh) then
		if type(handlings) == "string" then
			local strArray = {}
			for token in string.gmatch(handlings, "[^%s]+") do
  				table.insert(strArray,token)
			end
			local i = 2

			for k,v in pairs(handlingNamesTable) do
				--if v ~= "suspensionLowerLimit" then
					setVehicleHandling(veh, v, strArray[i])
					if v == "modelFlags" or v == "handlingFlags" then
						setVehicleHandling(veh, v, tonumber("0x"..strArray[i]))
						--outputChatBox(v.." "..tonumber("0x"..strArray[i]))
					elseif v == "driveType" then
						if strArray[i] == "4" then
							setVehicleHandling(veh, v, "awd")
							--outputChatBox(v.." "..tonumber(strArray[i]))
						end
					end
					--outputChatBox(v.." : "..strArray[i])
				--end
				i = i + 1
			end 
		elseif type(handlings) == "table" then
			for k,v in pairs(handlings) do
			end
		end
	end
end
addEvent("updateVehicleHandlings",true)
addEventHandler("updateVehicleHandlings",root,updateVehicleHandlings)

function removeNumberPlate(player,num)
	local numbers = getElementData(player,"numbers")
	for k,v in pairs(numbers) do
		if v[1] == num[1] and v[2] == num[2] then
			table.remove(numbers,k)
		end
	end
	setElementData(player,"numbers",numbers)
	setAccountData(getPlayerAccount(player), "numbers", toJSON(getElementData(player,"numbers")))
	--outputChatBox("TOOK NUMBERS "..num[2].." FROM PLAYER "..getPlayerName(player),player,200,0,0)
end

function giveNumberPlate(player,num)
	local numbers = getElementData(player,"numbers")
	table.insert(numbers,num)
	setElementData(player,"numbers",numbers)
	setAccountData(getPlayerAccount(player), "numbers", toJSON(getElementData(player,"numbers")))
	--outputChatBox("GAVE NUMBERS "..num[2].." TO PLAYER "..getPlayerName(player),player,0,200,0)
end

marketPositions = -- Позиции парковочных мест на Б/У рынке
{
{-2629.7194824219,1334.6466064453,6.8145437240601,0,0,359},
{-2632.9599609375,1334.5842285156,6.8125,0,0,1},
{-2636.4096679688,1334.2061767578,6.812924861908,0,0,0},
{-2639.6684570313,1334.1417236328,6.8080649375916,0,0,1},
{-2643.1098632813,1334.2559814453,6.7965817451477,0,0,359},
{-2646.5231933594,1334.1818847656,6.7919087409973,0,0,0},
{-2643.2922363281,1343.0924072266,6.7756333351135,0,0,179},
{-2646.4892578125,1343.1749267578,6.7894606590271,0,0,181},
{-2643.3732910156,1350.197265625,6.7760787010193,0,0,359},
{-2646.4494628906,1350.6075439453,6.787956237793,0,0,0},
{-2643.4343261719,1360.5219726563,6.7773094177246,0,0,180},
{-2646.6520996094,1360.3677978516,6.7874822616577,0,0,179},
{-2640.1564941406,1360.5249023438,6.7635040283203,0,0,180},
{-2636.8515625,1360.4093017578,6.7477507591248,0,0,182},
{-2617.7001953125,1377.1451416016,6.7509684562683,0,0,178},
{-2621.1560058594,1377.3393554688,6.7526969909668,0,0,180},
{-2624.37890625,1377.3585205078,6.7520098686218,0,0,180},
{-2627.6701660156,1377.5334472656,6.7542238235474,0,0,179},
{-2630.7834472656,1377.3878173828,6.7540011405945,0,0,179},
{-2633.5478515625,1377.3435058594,6.7514910697937,0,0,177},
{-2636.6799316406,1377.4873046875,6.7570538520813,0,0,181},
{-2639.8173828125,1377.1983642578,6.7630515098572,0,0,177},
{-2643.2451171875,1377.431640625,6.7761268615723,0,0,181},
{-2646.4755859375,1377.4161376953,6.7885718345642,0,0,181},
{-2636.8459472656,1367.2761230469,6.74906873703,0,0,359},
{-2640.0239257813,1367.2659912109,6.7626996040344,0,0,0},
{-2643.2072753906,1367.2556152344,6.7736663818359,0,0,0},
{-2646.5402832031,1367.2947998047,6.7889280319214,0,0,359},
}

markerPositionLV = 
{
{2078.5200195313,2163.4982910156,10.437775611877,0,0,359},
{2075.0556640625,2163.4289550781,10.438052177429,0,0,358},
{2071.7602539063,2163.1713867188,10.438320159912,0,0,358},
{2068.5170898438,2163.1875,10.437803268433,0,0,1},
{2065.2751464844,2163.1135253906,10.436864852905,0,0,3},
{2061.6879882813,2163.1826171875,10.437469482422,0,0,0},
{2058.4592285156,2163.2709960938,10.43728351593,0,0,0},
{2058.6350097656,2173.6362304688,10.422070503235,0,0,178},
{2061.6674804688,2173.6630859375,10.439148902893,0,0,183},
{2064.8979492188,2173.6379394531,10.436880111694,0,0,179},
{2068.4287109375,2173.5036621094,10.438279151917,0,0,180},
{2071.6408691406,2173.6533203125,10.426829338074,0,0,182},
{2074.9704589844,2173.6311035156,10.438035011292,0,0,177},
{2078.3420410156,2173.6179199219,10.437269210815,0,0,181},
{2078.2819824219,2156.2956542969,10.437063217163,0,0,180},
{2075.0861816406,2156.3364257813,10.437746047974,0,0,182},
{2071.6899414063,2156.328125,10.438287734985,0,0,180},
{2068.1240234375,2156.3950195313,10.436445236206,0,0,180},
{2065.2492675781,2156.3359375,10.425356864929,0,0,181},
{2062.0297851563,2156.373046875,10.440390586853,0,0,176},
{2058.6604003906,2156.3352050781,10.431752204895,0,0,180},
{2078.2614746094,2180.4995117188,10.436965942383,0,0,359},
{2075.3054199219,2180.4436035156,10.436255455017,0,0,2},
{2071.625,2180.4689941406,10.437182426453,0,0,359},
{2068.4616699219,2180.4724121094,10.437504768372,0,0,1},
{2065.1528320313,2180.4760742188,10.43979549408,0,0,359},
{2061.8239746094,2180.4755859375,10.437355041504,0,0,0},
{2058.3481445313,2180.4174804688,10.437754631042,0,0,357},
{2058.8278808594,2192.2941894531,10.439846992493,0,0,177},
{2061.7221679688,2192.23046875,10.439162254333,0,0,177},
{2065.0920410156,2192.23046875,10.438654899597,0,0,180},
{2068.6569824219,2192.2868652344,10.436318397522,0,0,176},
{2071.5302734375,2192.2653808594,10.436681747437,0,0,183},
{2075.2204589844,2192.2316894531,10.43696308136,0,0,179},
{2078.4072265625,2192.2351074219,10.431732177734,0,0,181},
{2081.7626953125,2192.2243652344,10.439141273499,0,0,178},
{2085.0981445313,2192.2160644531,10.43771648407,0,0,184},
{2088.3422851563,2192.1943359375,10.439648628235,0,0,178},
{2091.8427734375,2192.2883300781,10.437069892883,0,0,176},
{2095.1853027344,2191.9440917969,10.437591552734,0,0,180},
{2098.3020019531,2192.1887207031,10.438164710999,0,0,181},
{2101.5417480469,2192.2326660156,10.438508987427,0,0,177},
{2104.8701171875,2192.232421875,10.438980102539,0,0,177},
{2104.7639160156,2180.4875488281,10.437501907349,0,0,1},
{2101.2783203125,2180.3977050781,10.433715820313,0,0,1},
{2098.322265625,2180.4768066406,10.437443733215,0,0,1},
{2094.7895507813,2180.46484375,10.437810897827,0,0,1},
{2095.1569824219,2173.5764160156,10.437081336975,0,0,183},
{2098.3740234375,2173.6110839844,10.438412666321,0,0,179},
{2101.91796875,2173.6323242188,10.437028884888,0,0,184},
{2104.9653320313,2173.6245117188,10.436994552612,0,0,181},
}

markerPositionLS = {
{1098.4553222656,-1755.15625,12.972321510315,0,0,89},
{1084.3123779297,-1760.9691162109,12.985319137573,0,0,269},
{1084.3303222656,-1766.8956298828,12.980153083801,0,0,266},
}

function placeVehicleOnMarket(veh,price,date,withdraw)
	local lotid = getMarketFreeID()
	if getElementData(veh,"owner") == getAccountName(getPlayerAccount(source)) then
		if marketPositions[lotid] then
			if getPlayerMoney(source) >= withdraw then
				takePlayerMoney(source,withdraw)
				local currentTime = getRealTime().timestamp
				local timeToPlace = currentTime + 86400*date
				dbExec(db, "INSERT INTO Market VALUES(?, ?, ?, ?, ?)",lotid,getElementData(veh,"ID"),getAccountName(getPlayerAccount(source)),price,timeToPlace)
				dbExec(db, "UPDATE Vehicles SET Account = ? WHERE Account = ? AND ID = ?", "Market", getAccountName(getPlayerAccount(source)), getElementData(veh,"ID"))
				updateVehicles(source)
				local x,y,z,rx,ry,rz = unpack(marketPositions[lotid])
				fixVehicle(veh)
				removePedFromVehicle(source)
				setElementPosition(veh,x,y,z)
				setElementRotation(veh,rx,ry,rz)
				setTimer(setElementFrozen,3000,1,veh,true)
				--setElementFrozen(veh,true)
				setVehicleDamageProof( veh,true )
				setVehicleLocked ( veh, false ) 
			--	fixVehicle( veh )
				setElementData(veh,"owner","Market")
				setElementData(veh,"Price",price)
				setElementData(veh,"oldOwner",getAccountName(getPlayerAccount(source)))
				outputChatBox("#ffffff*Ваш автомобиль выставлен на продажу за #00ff00"..price.."$ #ffffffПарковочное место арендовано на "..date.." дней.",source,0,200,0,true)
				outputChatBox("#ffffff*Если автомобиль #ff0000не #ffffffбудет выкуплен в указанный срок - он будет возвращён вам.",source,0,200,0,true)
			else
				outputChatBox("#ffffff*Вы #ff0000не #ffffffможете оплатить аренду парковочного места!",source,200,0,0,true)
			end
		else
			outputChatBox("#ffffff*На рынке #ff0000нет #ffffffсвободных парковочных мест!",source,200,0,0,true)
		end
	else
		outputChatBox("#ffffff*Вы #ff0000не #ffffffвладеете данным Т/С.",source,200,0,0,true)
	end
end
addEvent("placeVehicleOnMarket",true)
addEventHandler("placeVehicleOnMarket",root,placeVehicleOnMarket)

function placeVehicleOnMarketLV(veh,price,date,withdraw)
	local lotid = getMarketFreeID()
	if getElementData(veh,"owner") == getAccountName(getPlayerAccount(source)) then
		if markerPositionLV[lotid] then
			if getPlayerMoney(source) >= withdraw then
				takePlayerMoney(source,withdraw)
				local currentTime = getRealTime().timestamp
				local timeToPlace = currentTime + 86400*date
				dbExec(db, "INSERT INTO Market VALUES(?, ?, ?, ?, ?)",lotid,getElementData(veh,"ID"),getAccountName(getPlayerAccount(source)),price,timeToPlace)
				dbExec(db, "UPDATE Vehicles SET Account = ? WHERE Account = ? AND ID = ?", "Market", getAccountName(getPlayerAccount(source)), getElementData(veh,"ID"))
				updateVehicles(source)
				local x,y,z,rx,ry,rz = unpack(markerPositionLV[lotid])
				fixVehicle(veh)
				removePedFromVehicle(source)
				setElementPosition(veh,x,y,z)
				setElementRotation(veh,rx,ry,rz)
				setTimer(setElementFrozen,3000,1,veh,true)
				--setElementFrozen(veh,true)
				setVehicleDamageProof( veh,true )
				setVehicleLocked ( veh, false ) 
			--	fixVehicle( veh )
				setElementData(veh,"owner","Market")
				setElementData(veh,"Price",price)
				setElementData(veh,"oldOwner",getAccountName(getPlayerAccount(source)))
				outputChatBox("#ffffff*Ваш автомобиль выставлен на продажу за #00ff00"..price.."$ #ffffffПарковочное место арендовано на "..date.." дней.",source,0,200,0,true)
				outputChatBox("#ffffff*Если автомобиль #ff0000не #ffffffбудет выкуплен в указанный срок - он будет возвращён вам.",source,0,200,0,true)
			else
				outputChatBox("#ffffff*Вы #ff0000не #ffffffможете оплатить аренду парковочного места!",source,200,0,0,true)
			end
		else
			outputChatBox("#ffffff*На рынке #ff0000нет #ffffffсвободных парковочных мест!",source,200,0,0,true)
		end
	else
		outputChatBox("#ffffff*Вы #ff0000не #ffffffвладеете данным Т/С.",source,200,0,0,true)
	end
end
addEvent("placeVehicleOnMarketLV",true)
addEventHandler("placeVehicleOnMarketLV",root,placeVehicleOnMarketLV)

function placeVehicleOnMarketLS(veh,price,date,withdraw)
	local lotid = getMarketFreeID()
	if getElementData(veh,"owner") == getAccountName(getPlayerAccount(source)) then
		if markerPositionLS[lotid] then
			if getPlayerMoney(source) >= withdraw then
				takePlayerMoney(source,withdraw)
				local currentTime = getRealTime().timestamp
				local timeToPlace = currentTime + 86400*date
				dbExec(db, "INSERT INTO Market VALUES(?, ?, ?, ?, ?)",lotid,getElementData(veh,"ID"),getAccountName(getPlayerAccount(source)),price,timeToPlace)
				dbExec(db, "UPDATE Vehicles SET Account = ? WHERE Account = ? AND ID = ?", "Market", getAccountName(getPlayerAccount(source)), getElementData(veh,"ID"))
				updateVehicles(source)
				local x,y,z,rx,ry,rz = unpack(markerPositionLS[lotid])
				fixVehicle(veh)
				removePedFromVehicle(source)
				setElementPosition(veh,x,y,z)
				setElementRotation(veh,rx,ry,rz)
				setTimer(setElementFrozen,3000,1,veh,true)
				--setElementFrozen(veh,true)
				setVehicleDamageProof( veh,true )
				setVehicleLocked ( veh, false ) 
			--	fixVehicle( veh )
				setElementData(veh,"owner","Market")
				setElementData(veh,"Price",price)
				setElementData(veh,"oldOwner",getAccountName(getPlayerAccount(source)))
				outputChatBox("#ffffff*Ваш автомобиль выставлен на продажу за #00ff00"..price.."$ #ffffffПарковочное место арендовано на "..date.." дней.",source,0,200,0,true)
				outputChatBox("#ffffff*Если автомобиль #ff0000не #ffffffбудет выкуплен в указанный срок - он будет возвращён вам.",source,0,200,0,true)
			else
				outputChatBox("#ffffff*Вы #ff0000не #ffffffможете оплатить аренду парковочного места!",source,200,0,0,true)
			end
		else
			outputChatBox("#ffffff*На рынке #ff0000нет #ffffffсвободных парковочных мест!",source,200,0,0,true)
		end
	else
		outputChatBox("#ffffff*Вы #ff0000не #ffffffвладеете данным Т/С.",source,200,0,0,true)
	end
end
addEvent("placeVehicleOnMarketLS",true)
addEventHandler("placeVehicleOnMarketLS",root,placeVehicleOnMarketLS)

function buyVehicleFromMarket(veh)
	local price = getElementData(veh,"Price")
	local account = getAccount(getElementData(veh,"oldOwner"))
	local bAcc = getAccountName(getPlayerAccount(source))
	if getPlayerAccount(source) == account then price = 0 
	else
		if getPlayerVehiclesCount(source) >= exports["houses"]:getCarLimit(source) then
			outputChatBox("У вас недостаточно парковочных мест. Купите дом для расширения количества парковочных мест.",source,200,0,0)
			return
		end
	end

	local data = dbPoll(dbQuery(db, "SELECT * FROM Vehicles WHERE Account = ?", bAcc), -1)

	if getPlayerMoney(source) >= price then
		takePlayerMoney(source,price)
		dbExec(db, "DELETE FROM Market WHERE OldID = ?", getElementData(veh,"ID"))
		dbExec(db, "UPDATE Vehicles SET Account = ? WHERE Account = ? AND ID = ?", bAcc, "Market", getElementData(veh,"ID"))
		setElementData(veh,"owner",getAccountName(getPlayerAccount(source)))
		setElementFrozen(veh,false)
		setVehicleDamageProof(veh,false)
		setVehicleEngineState(veh,true)
		setElementData(veh,"fuel",10)
		setVehicleLocked ( veh, false ) 
		removeElementData(veh,"Price")
		outputChatBox("Вы успешно приобрели данный автомобиль.",source,0,200,0)
		updateVehicles(source)
		if getAccountPlayer(account) then
			givePlayerMoney(getAccountPlayer(account), price)
			outputChatBox("Ваш автомобиль был куплен. Вы получили "..price.."$",getAccountPlayer(account),0,200,0)
		else
			setAccountData(account,"marketMoney", getAccountData(account,"marketMoney")+price)
		end
	else
		outputChatBox("У вас недостаточно денег!", source, 200,0,0)
		removePedFromVehicle(source)
	end
end
addEvent("buyVehicleFromMarket",true)
addEventHandler("buyVehicleFromMarket",root,buyVehicleFromMarket)


local marketMarker = createMarker(-2629.67139, 1366.76794, 6.10028,"cylinder",2,255,0,0,150)
createBlipAttachedTo(marketMarker, 20, 1, 255, 255, 255, 255, 0, 200)

local marketMarker2 = createMarker(2096.80200, 2158.59448, 9,"cylinder",2,255,0,0,150)
createBlipAttachedTo(marketMarker2, 20, 1, 255, 255, 255, 255, 0, 200)

local marketMarker3 = createMarker(1090.61353, -1737.44214, 12.58994,"cylinder",2,255,0,0,150)
createBlipAttachedTo(marketMarker3, 20, 1, 255, 255, 255, 255, 0, 200)

addEventHandler("onPlayerMarkerHit",root,function(marker)
	if marker == marketMarker then
		local veh = getPedOccupiedVehicle( source )
		if veh and getVehicleController(veh) == source then
			if not isDonateVehicle(getElementModel(veh)) then
				triggerClientEvent( source,"initMarkerWindow", source, "SF")
			else
				outputChatBox("Этот автомобиль нельзя продать!",source,200,0,0)
			end
		end
	elseif marker == marketMarker2 then
		local veh = getPedOccupiedVehicle( source )
		if veh and getVehicleController(veh) == source then
			if not isDonateVehicle(getElementModel(veh)) then
				triggerClientEvent( source,"initMarkerWindow", source, "LV")
			else
				outputChatBox("Этот автомобиль нельзя продать!",source,200,0,0)
			end
		end
	elseif marker == marketMarker3 then
		--print ("LS")
		local veh = getPedOccupiedVehicle( source )
		if veh and getVehicleController(veh) == source then
			if not isDonateVehicle(getElementModel(veh)) then
				triggerClientEvent( source,"initMarkerWindow", source, "LS")
			else
				outputChatBox("Этот автомобиль нельзя продать!",source,200,0,0)
			end
		end
	end
end)

addEventHandler ( "onPlayerVehicleEnter", getRootElement(), function(veh,seat)
	if getElementData(veh,"owner") == "Market" then
		if getPlayerAccount(source) == getAccount( getElementData(veh,"oldOwner") ) then
			triggerClientEvent( source,"initMarketVehicleWindow", source,true )
		else
			triggerClientEvent( source,"initMarketVehicleWindow", source,false )
		end
		setVehicleEngineState(veh,false)
	end
end)

function initMarketVehicles()
	local data = dbPoll(dbQuery(db, "SELECT * FROM Vehicles WHERE Account = ?", "Market"), -1)
	if not data then return end
	for k,v in pairs(data) do
		local marketData = dbPoll(dbQuery(db, "SELECT * FROM Market WHERE OldID = ?", v["ID"]), -1)[1]
		if marketData then
			local x,y,z,rx,ry,rz = unpack(marketPositions[ marketData["ID"] ] )
				veh = createVehicle(v["Model"], x,y,z+1, rx, ry, rz)
				local colors = fromJSON(v["Colors"])
				setVehicleColor(veh,colors[1],colors[2],colors[3],colors[4],colors[5],colors[6])
				setVehicleHeadLightColor( veh, colors[7],colors[8],colors[9] )
				setElementData(veh, "ID", v["ID"])
	----------------------------------
				local upd = split(tostring(v["Upgrades"]), ',')
				for i, upgrade in ipairs(upd) do
					addVehicleUpgrade(veh, upgrade)
				end
				local Paintjob = v["Paintjob"] or 3
				setVehiclePaintjob(veh, Paintjob) 

				local number = fromJSON(v["RealNumber"])
				if number[1] then
					setElementData(veh,"numberType",number[1])
					setElementData(veh,"number:plate",number[2])
				end

				local toner = fromJSON(v["Toner"])
				if toner[1] then 
					setElementData(veh,"toner:toner",toner[1])
					setElementData(veh,"toner:type",toner[2])
					setElementData(veh,"toner:alpha",toner[3])
				end

				local vinil = v["Vinil"]
				if type(vinil) == "string" and #vinil >= 3 then
					setElementData(veh,"vinil",vinil)
				end

			setElementPosition(veh,x,y,z)
			setElementRotation(veh,rx,ry,rz)
			setTimer(setElementFrozen,3000,1,veh,true)
			--setElementFrozen(veh,true)
			setVehicleDamageProof( veh,true )
			fixVehicle( veh )
			setElementData(veh,"owner","Market")
			setElementData(veh,"Price",marketData["Price"])
			setElementData(veh,"oldOwner",marketData["Owner"])
		else
			--outputDebugString("ERROR LOADING MARKET VEHICLE. ID: "..v["ID"].." PRICE: "..getVehicleData(v["Model"])[3]..". REMOVING THIS VEHICLE!")
			dbExec(db, "DELETE FROM Vehicles WHERE ID = ?", v["ID"])
		end
	end
end

function checkMarketVehicles()
	local marketArray = dbPoll(dbQuery(db, "SELECT * FROM Market"), -1)
	if not marketArray then return end
	local currentTime = getRealTime().timestamp
	for k,v in pairs(marketArray) do
		if v["Date"] < currentTime then
			local owner = getAccount(v["Owner"])
			dbExec(db, "UPDATE Vehicles SET Account = ? WHERE Account = ? AND ID = ?", v["Owner"], "Market", v["OldID"])
			for key,val in pairs(getElementsByType("vehicle")) do
				if getElementData(val,"ID") == v["OldID"] then
					destroyElement(val)
				end
			end
			local ply = getAccountPlayer(owner)
			if ply then
				outputChatBox("Ваш автмомобиль был снят с продажи в связи с истечением срока аренды парковочного места.", ply, 0, 150, 150)
				updateVehicles(ply)
			end
			dbExec(db, "DELETE FROM Market WHERE ID = ?", v["ID"])
		end
	end
	setTimer(checkMarketVehicles,10000,1)
end

initMarketVehicles()
checkMarketVehicles()

function updateMileage()
	for k,v in pairs(getElementsByType("vehicle")) do
		if getElementData(v,"ID") and getVehicleController(v) then
			local x,y,z = getElementPosition(v)
			if lastPosition[v] then
				local dist = getDistanceBetweenPoints3D(lastPosition[v][1],lastPosition[v][2],lastPosition[v][3], x,y,z)
				if dist <= 5000 then
					local curmil = getElementData(v,"mileage") or 0
					setElementData(v,"mileage",curmil+dist/1000)
				end
				lastPosition[v] = {x,y,z}
			else
				lastPosition[v] = {x,y,z}
			end
		end
	end
	setTimer(updateMileage,5000,1)
end
updateMileage()

function saveMileage(veh)
	local result = dbPoll(dbQuery(db, "SELECT * FROM Vehicles WHERE ID = ?", getElementData(veh,"ID")),-1)
	if result and type(result) == "table" and #result >= 1 then
		dbExec(db,"UPDATE Vehicles SET Mileage = ? WHERE ID = ?",getElementData(veh,"mileage"),getElementData(veh,"ID"))
	end 
end

function saveAllMileages()
	for k,v in pairs(getElementsByType("vehicle")) do
		if getElementData(v,"ID") then
			if getElementData(v,"mileage") then
				saveMileage(v)
			end
		end
	end
	setTimer(saveAllMileages,60000,1)
end
saveAllMileages()

-- BARTER SYSTEM

-- TRADE SYSTEM

function sendBarterOffer(ply)
	--print (ply)
	outputChatBox("Вы отправили игроку #00dd00"..ply.."#ffffff предложение обмена",source,255,255,255,true)
	triggerClientEvent(getPlayerFromName(ply), "cacheBarterOfferWindow", source )
end
addEvent("sendBarterOffer",true)
addEventHandler( "sendBarterOffer", root, sendBarterOffer )

function offerAccepted(ply)
	updateVehicles(ply)
	updateVehicles(source)

	triggerClientEvent(ply, "initBarterWindow", source)
	triggerClientEvent(source, "initBarterWindow", ply)
	--outputChatBox("ACCEPTED: "..getPlayerName(source).." "..getPlayerName(ply))
end
addEvent("offerAccepted",true)
addEventHandler( "offerAccepted", root, offerAccepted )

function updateBarterStatus(ply,items,ready,ready2)
	triggerClientEvent(ply,"updateBarterStatus",source,items,ready,ready2)
end
addEvent("updateBarterStatus",true)
addEventHandler( "updateBarterStatus", root, updateBarterStatus )

function finishBarter(ply1,ply2,items1,items2)
	local accountName1 = getAccountName(getPlayerAccount(ply1))
	local accountName2 = getAccountName(getPlayerAccount(ply2))
	-- CHECKING MONEY ON EVERY SIDE
	local paysum1 = 0
	local paysum2 = 0

	local vehcount1 = 0
	local vehcount2 = 0

	for k,v in pairs(items1) do
		if v[1] == "Деньги" then
			paysum1 = paysum1 + tonumber(v[2])
 		end
 		if v[1] == "Автомобиль" then
 			vehcount1 = vehcount1 + 1
 		end
	end

	for k,v in pairs(items2) do
		if v[1] == "Деньги" then
			paysum2 = paysum2 + tonumber(v[2])
 		end
 		if v[1] == "Автомобиль" then
 			vehcount2 = vehcount2 + 1
 		end
	end

	if getPlayerMoney(ply1) < paysum1 or getPlayerMoney(ply2) < paysum2  then
		triggerClientEvent(ply1, "initBarterWindow", source)
		triggerClientEvent(ply2, "initBarterWindow", source)
		outputChatBox("Сделка не может быть завершена(недостаточно денег)!",ply1,200,0,0)
		outputChatBox("Сделка не может быть завершена(недостаточно денег)!",ply2,200,0,0)
		return
	end

	if exports["houses"]:getCarLimit(ply1)-getPlayerVehiclesCount(ply1) < vehcount2 or exports["houses"]:getCarLimit(ply2)-getPlayerVehiclesCount(ply2) < vehcount1  then
		triggerClientEvent(ply1, "initBarterWindow", source)
		triggerClientEvent(ply2, "initBarterWindow", source)
		outputChatBox("Сделка не может быть завершена(недостаточно парковочных мест)!",ply1,200,0,0)
		return
	end

	if not getElementData(ply1,"barterWindowShown") or not getElementData(ply2,"barterWindowShown") then
		outputChatBox("Ошибка обмена!",ply1,200,0,0)
		outputChatBox("Ошибка обмена!",ply2,200,0,0)
		return 
	end

	takePlayerMoney(ply1,paysum1)
	takePlayerMoney(ply2,paysum2)

	-- CONTINUE

	for k,v in pairs(items1) do
		if v[1] == "Автомобиль" then
			dbExec(db, "UPDATE Vehicles SET Account = ? WHERE Account = ? AND ID = ?", accountName2, accountName1, tonumber(v[3]))
		elseif v[1] == "Номера" then
			removeNumberPlate(ply1,v[3])
			giveNumberPlate(ply2,v[3])
		elseif v[1] == "Деньги" then
			givePlayerMoney(ply2,tonumber(v[2]))
		end
		--outputChatBox(k.." "..tostring(v))
	end
	for k,v in pairs(items2) do
		if v[1] == "Автомобиль" then
			dbExec(db, "UPDATE Vehicles SET Account = ? WHERE Account = ? AND ID = ?", accountName1, accountName2, tonumber(v[3]))
		elseif v[1] == "Номера" then
			removeNumberPlate(ply2,v[3])
			giveNumberPlate(ply1,v[3])
		elseif v[1] == "Деньги" then
			givePlayerMoney(ply1,tonumber(v[2]))
		end
		--outputChatBox(k.." "..tostring(v))
	end
	triggerClientEvent(ply1, "initBarterWindow", source)
	triggerClientEvent(ply2, "initBarterWindow", source)
	updateVehicles(ply1)
	updateVehicles(ply2)
	outputChatBox("Вы успешно обменялись с #00dd00"..getPlayerName(ply2),ply1,255,255,255,true)
	outputChatBox("Вы успешно обменялись с #00dd00"..getPlayerName(ply1),ply2,255,255,255,true)
end
addEvent("finishBarter",true)
addEventHandler( "finishBarter", root, finishBarter )

function abortBarter(ply,window)
	outputChatBox("Игрок #00dd00"..getPlayerName(source).."#ffffff отказался от обмена.",ply,255,255,255,true)
	if window then
		triggerClientEvent(ply, "initBarterWindow", source)
	end
end
addEvent("abortBarter",true)
addEventHandler( "abortBarter", root, abortBarter )

addEventHandler( 'onPlayerLogin', root, function() 
refreshCar (source)
end)

addEventHandler ("onResourceStart", resourceRoot, function(res)
for i, v in ipairs (getElementsByType ("player")) do
	refreshCar (v)
end
end)