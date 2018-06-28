function numberPlate (veh, country, plate, pl, LPl)
    if veh and country and plate then
        setElementData (veh, "numberType", country)
		setElementData (veh, "number:plate", plate)
		--number = toJSON({getElementData(veh,"numberType"),getElementData(veh,"number:plate")})
    end
end
addEvent ("numberPlate", true)
addEventHandler ("numberPlate", root, numberPlate)

function openNumberPanel ( player )
    if (isObjectInACLGroup("user." .. getAccountName( getPlayerAccount( player ) ), aclGetGroup("Admin"))) then
	    triggerClientEvent( player, "openNumber", player)
	end
end
addCommandHandler ("numberPanel", openNumberPanel)