


--addEvent("aw",true)
 
--addEventHandler("aw",root,
 
function lol (player, money)
takePlayerMoney(player, money)
end
 
--end
addEvent( "aw", true )
addEventHandler( "aw", getRootElement(), lol )


function showError (target, ...)
if ... then
local msg = table.concat({...}, " ") 
outputChatBox (msg,target, 255, 255, 0)
end
end
addEvent ("errorMSG", true)
addEventHandler ("errorMSG", root, showError)