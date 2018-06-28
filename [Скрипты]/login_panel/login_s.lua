--[[
	*Scripted by ZoRRoM^.
	*ZoRRoM^ tarafından kodlanmıştır.
	*Lütfen http://mtasa-tr.com adresini ziyaret edin.
	*Please visit http://mtasa-tr.com adress.
]]

local function do_login(player, username, password, save_log)
	setElementData(source, "loggedin", true)
	triggerClientEvent(source, "closeLogin", source)
	if save_log then
		triggerClientEvent(source, "saveLoginToXML", root, username, password)
	else
		triggerClientEvent(source, "resetSaveXML", root, username, password)
	end
end

addEvent("onAccountManage", true)
addEventHandler("onAccountManage", root, function(typ, username, password, save_log)
	if not hasObjectPermissionTo(getThisResource(), "function.addAccount", true) then
		triggerClientEvent(source, "setInfoText", source, 9)
		return
	end
	if typ == "register" then
		if getAccount(username) then
			triggerClientEvent(source, "setInfoText", source, 5)
			return
		end
		if string.find (username, "%W") then
			triggerClientEvent(source, "setInfoText", source, 13)
			return
		end
		
		addAccount(username, password)
		if save_log then
			logIn(source, getAccount(username), password)
			setElementData(source, "loggedin", true)
			triggerClientEvent(source, "closeLogin", source)
			return
		end
		triggerClientEvent(source, "setInfoText", source, 11)
	elseif typ == "login" then
		if not getAccount(username) then
			triggerClientEvent(source, "setInfoText", source, 6)
			return
		end
		if not getAccount(username, password) then
			triggerClientEvent(source, "setInfoText", source, 7)
			return
		end
		
		if logIn(source, getAccount(username), password) then
			do_login(source, username, password, save_log)
		else
			if getAccount(username) and getAccountPlayer(getAccount(username)) == source then
				do_login(source, username, password, save_log)
				return
			end
			triggerClientEvent(source, "setInfoText", source, 12)
		end
	end
end)

addEventHandler("onPlayerLogout", root, function()
	setElementData(source," loggedin", false)
end)

addEventHandler("onPlayerLogin", root, function()
	setElementData(source, "loggedin", true)
end)

addEventHandler("onResourceStart", resourceRoot, function()
	for i, player in ipairs(getElementsByType("player")) do
		setElementData(player, "loggedin", not isGuestAccount(getPlayerAccount(player)))
	end
end)