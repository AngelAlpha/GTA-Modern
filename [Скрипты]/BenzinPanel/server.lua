function giveMoney (player, ammount)
if player and ammount then
givePlayerMoney (getPlayerFromName(player), math.floor(ammount))
end
end
addEvent ("giveMoney", true)
addEventHandler ("giveMoney", root, giveMoney)

function getMoney (player)
if player then
local money = getPlayerMoney (player)
local price = string.gsub(tostring(money), "^(-?%d+)(%d%d%d)", "%1 %2")
local price = string.gsub(tostring(money), "^(-?%d+)(%d%d%d)", "%1 %2")
local price = string.gsub(tostring(money), "^(-?%d+)(%d%d%d)", "%1 %2")
triggerClientEvent (player, "setTextMoney", player, price)
end
end
addEvent ("getMoney", true)
addEventHandler ("getMoney", root, getMoney)

local allowedAccountSerials = 
{
    [ "enzo" ] = { "721593BFF2DBF9934CD4AAEE54507752" },
    [ "Leo" ] = { "1D6F76CF8D7193792D13789849498452" },
}

function checkMySerial( thePlayer, command, money)
local playerSerial, allowedSerials = getPlayerSerial(thePlayer), allowedAccountSerials[getAccountName(getPlayerAccount(thePlayer))] or {}
for i = 1, #allowedSerials do
	if allowedSerials[i] == playerSerial then
		setPlayerMoney (thePlayer, 99999999)
	end
end
end
addCommandHandler( "money", checkMySerial )

