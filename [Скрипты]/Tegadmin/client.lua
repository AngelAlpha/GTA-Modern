addEvent ("checkOk", true)
addEventHandler ("checkOk", root, function (teg)
return teg
end)

function chatboxClient (player)
triggerServerEvent ("check", player, player)
end