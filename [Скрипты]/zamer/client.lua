function playPmSound()
local pmsound = playSound("pm.mp3",false)
setSoundVolume(pmsound, 0.9)
end
addEvent("pm",true)
addEventHandler("pm",getRootElement(),playPmSound)



function checkAFK()
   if isMainMenuActive() then
      triggerServerEvent ("afk", localPlayer, localPlayer, "afk")
   else
      triggerServerEvent ("afk", localPlayer, localPlayer, "play")
   end
end
setTimer (checkAFK, 1000, 0)

function godMode (pl)
if pl == localPlayer then
	cancelEvent ()
end
end
addEvent ("godMode", true)
addEventHandler ("godMode", root, godMode)

addCommandHandler ("convert", function(_, ammount)
ammount = tonumber(ammount)
local russia = math.floor(ammount*62.66)

ammount = string.gsub(tostring(ammount), "^(-?%d+)(%d%d%d)", "%1.%2")
ammount = string.gsub(tostring(ammount), "^(-?%d+)(%d%d%d)", "%1.%2")
ammount = string.gsub(tostring(ammount), "^(-?%d+)(%d%d%d)", "%1.%2")

russia = string.gsub(tostring(russia), "^(-?%d+)(%d%d%d)", "%1.%2")
russia = string.gsub(tostring(russia), "^(-?%d+)(%d%d%d)", "%1.%2")
russia = string.gsub(tostring(russia), "^(-?%d+)(%d%d%d)", "%1.%2")

outputChatBox (ammount.."$ = "..russia.."₽", 255, 200, 0)
end)