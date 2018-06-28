symbols = {'A','B','C','E','H','K','O','M','P','T','X'}

addEvent("startDriving", true)
addEventHandler("startDriving", getRootElement(), function(name, price,model)
	if source then
		takePlayerMoney(source, price)
		number = math.random(1,#coordinations[name])
		pos = coordinations[name][number]
		veh = createVehicle(model,pos[1],pos[2],pos[3]+1,0,0,pos[4])
		if getElementData(veh, "numberType") ~= nil then
			removeElementData(veh, "numberType")
			removeElementData(veh, "number:plate")
			setElementData(veh, "numberType", "c")
			setElementData(veh, "number:plate", "Автошкола")
		else
			setElementData(veh, "numberType", "c")
			setElementData(veh, "number:plate", "Автошкола")
		end
		setElementData(veh, "OwnerSchool", source)
		setElementData(source, "VehSchool", veh)
		setVehicleColor(veh, 255,255,255,255,255,255)
		warpPedIntoVehicle(source, veh)
		triggerClientEvent("startPoints", source, veh, name)
	end
end)

addEvent("stopDriving", true)
addEventHandler("stopDriving", getRootElement(), function(veh)
	if isElement(veh) then
		destroyElement(veh)
		removeElementData (source, "OwnerSchool")
	end
end)

local saveableData = { 
["cars"] = true, 
["moto"] = true, 
["gruz"] = true, 
["passangers"] = true, 
} 

addEventHandler("onPlayerLogin", root, 
function(_,acc) 
setElementData ( source, "cars", getAccountData ( acc, "cars" ) or false ) 
setElementData ( source, "moto", getAccountData ( acc, "moto" ) or false ) 
setElementData ( source, "gruz", getAccountData ( acc, "gruz" ) or false ) 
setElementData ( source, "passangers", getAccountData ( acc, "passangers" ) or false ) 
end) 

function outputChange(dataName,oldValue) 
if getElementType(source) == "player" then 
if saveableData[dataName] then 
setAccountData ( getPlayerAccount ( source ), dataName, getElementData ( source, dataName ) ) 
end 
end 
end 
addEventHandler("onElementDataChange",getRootElement(),outputChange)