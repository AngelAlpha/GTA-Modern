function buyNumberPlate (idCar, del)
theVehicle = findVeh (idCar)
	if isElement (theVehicle) then
		Owner = getElementData(theVehicle, "owner")
		if del == false then
			local db = exports.and_salon:getDBCarShop()
			local numb = toJSON({getElementData(theVehicle,"numberType"),getElementData(theVehicle,"number:plate")})
			dbExec(db, "UPDATE Vehicles SET Number = ? WHERE ID = ?", numb, idCar)
			updateVehicles (getAccountPlayer(getAccount(Owner)))
		else
			local db = exports.and_salon:getDBCarShop()
			local numb = toJSON({getElementData(theVehicle,"numberType"),getElementData(theVehicle,"number:plate")})
			dbExec(db, "UPDATE Vehicles SET Number = ? WHERE ID = ?", toJSON({nil, nil}), idCar)
			updateVehicles (getAccountPlayer(getAccount(Owner)))
		end
	end
end
addEvent("buyNumberPlate", true)
addEventHandler("buyNumberPlate", getRootElement(), buyNumberPlate)

function isNumberExists(ntype,ntext)
local db = exports.and_salon:getDBCarShop()
	local data = dbPoll(dbQuery(db, "SELECT * FROM Vehicles"), -1)
	if data then
	for k,v in pairs(data) do
		local num = fromJSON(v["RealNumber"])
		if num then
			if num[1] == ntype and num[2] == ntext then
				return true
			end
		end
	end
	end
end


function updateVehicleInfo(player)
	if isElement(player) then
		local db = exports.and_salon:getDBCarShop()
		local result = dbPoll(dbQuery(db, "SELECT * FROM Vehicles WHERE Account = ?", getAccountName(getPlayerAccount(player))), -1)
		if type(result) == "table" then
			setElementData(player, "vehicles", result)
		end
	end
end
addEvent ("write", true)
addEventHandler("write", root, updateVehicleInfo)

function updateVehicles(ply)
	local db = exports.and_salon:getDBCarShop()
	local account = getAccountName(getPlayerAccount(ply))

	local result = dbPoll(dbQuery(db, "SELECT * FROM Vehicles WHERE Account = ?", account), -1)
	if type(result) == "table" then
		setElementData(ply,"vehicles",result)
	end
end
addEvent ("refreshCarNumb", true)
addEventHandler ("refreshCarNumb", root, updateVehicles)

function findVeh(id)
	local vehicles = getElementsByType("vehicle")
	for k,v in pairs(vehicles) do
		if getElementData(v,"ID") == id then
			return v
		end
	end
	return false
end

function takeMoneyN (pl, money)
	takePlayerMoney(pl,tonumber(money))
end
addEvent ("takeN", true)
addEventHandler ("takeN", root, takeMoneyN)