function chatboxCheck(player)
local acc = getAccountName (getPlayerAccount(player))
local teg

    if isObjectInACLGroup("user." .. acc, aclGetGroup("Admin")) then
	teg = ""
	
    elseif isObjectInACLGroup("user." .. acc, aclGetGroup("SuperModerator")) then 	
	teg = "#00FF00[A]"

    elseif isObjectInACLGroup("user." .. acc, aclGetGroup("Moderator")) then
	teg = "#00FF00[M]"
	
	elseif isObjectInACLGroup("user." .. acc, aclGetGroup("Dev")) then       
	teg = "#FFFF00[Девушка]"
	
	elseif isObjectInACLGroup("user." .. acc, aclGetGroup("Everyone")) then
	teg = ""
	end
	return teg
end

function check(_, player)
local acc = getAccountName (player)
    if isObjectInACLGroup("user." .. acc, aclGetGroup("Admin")) or isObjectInACLGroup("user." .. acc, aclGetGroup("SuperModerator")) or isObjectInACLGroup("user." .. acc, aclGetGroup("Moderator")) then
	setElementData (source, "teg", true)
	else
	setElementData (source, "teg", false)
	end
end
addEventHandler ("onPlayerLogin", root, check)

function getPlayerFromAccountName(name) 
    local acc = getAccount (name)
    if name and acc and not isGuestAccount (acc) then
        return getAccountPlayer (acc)
    else
        return false
    end
end