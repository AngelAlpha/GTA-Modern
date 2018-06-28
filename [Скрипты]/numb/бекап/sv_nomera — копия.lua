function initNumberWindow(ply)
	local accName = getAccountName ( getPlayerAccount ( ply ) )
    if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) then
    	triggerClientEvent( ply, "initNewNumberWindow", ply, true )
    end
end
addCommandHandler( "nomera", initNumberWindow )

function buyNumberPlate (country, numbers, money)
    local vehicle = getPedOccupiedVehicle(source)
	setElementData(vehicle, "numberType", country)
	setElementData(vehicle, "number:plate", numbers)
	takePlayerMoney(source, money)
end
addEvent("buyNumberPlate", true)
addEventHandler("buyNumberPlate", getRootElement(), buyNumberPlate)