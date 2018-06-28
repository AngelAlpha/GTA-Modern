local lp = getLocalPlayer()
local screenW, screenH = guiGetScreenSize()
local x, y = guiGetScreenSize()
local fonts1 = dxCreateFont("shared/1.ttf", 11)
local fonts2 = dxCreateFont("shared/1.ttf", 22)
local fonts = dxCreateFont("shared/1.ttf", 10)
local hud

function mainhHud()
    local health,money = math.floor(getElementHealth(lp)), getPlayerMoney()
    local time = getRealTime()
    local hours = time.hour
    local minutes = time.minute
    local resW, resH = 1365, 767
	local xe, ye =  (screenW/resW), (screenH/resH)
	armadura =  math.floor(getPedArmor(lp))
	weapon = getPedWeapon(getLocalPlayer())
    vida = getElementHealth ( getLocalPlayer() ) + 0.40000152596
	provida= (screenW * 0.150)*(health/100)
	porarmadura= (screenW * 0.150)*(armadura/100)
	if minutes <= 9 then
		minutes = "0"..minutes
	end
      if hud == 1 then
        dxDrawImage( x - 371, -1, 377, 181, "shared/fon.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
        dxDrawText("Налик: "..floorM(money).."$",  x-225,-40,x-320,100, tocolor(0, 255, 130, 200), 1, fonts1, "left", "center", false, true, true, false, false)
        dxDrawText(hours..":"..minutes,x-1,50,x-90,8, tocolor(230, 230, 230, 255), 0.5, fonts2, "center", "center", false, true, true, false, false)
        dxDrawRectangle(x-230.5,82,212.5/getPedMaxHealth(localPlayer)*vida,ye*8, tocolor(225, 0, 0, 255), true)
        dxDrawText(getPedAmmoInClip(localPlayer)..":"..getPedTotalAmmo(localPlayer), x-80,63,x-188,55, tocolor(200, 200, 200, 255), 1, fonts1, "left", "center", false, true, true, false, false)
		if getElementData(localPlayer, "bank.money") then
		dxDrawText("Банк: "..tostring(floorM(math.floor(getElementData(localPlayer, "bank.money")))).."$", x-225,10,x-90,105, tocolor(0, 255, 130, 200), 1, fonts1, "left", "center", false, true, true, false, false)
		else
		dxDrawText("Банк: 0$", x-225,10,x-90,105, tocolor(0, 255, 130, 200), 1, fonts1, "left", "center", false, true, true, false, false)
		end
	 end
    end
addEventHandler("onClientRender", root,mainhHud)

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function ()
	setPlayerHudComponentVisible ( "all", false )
	hud = 1
end)

function floorM (moneyP)
local moneyP = string.gsub(tostring(moneyP), "^(-?%d+)(%d%d%d)", "%1.%2")
local moneyP = string.gsub(tostring(moneyP), "^(-?%d+)(%d%d%d)", "%1.%2")
local moneyP = string.gsub(tostring(moneyP), "^(-?%d+)(%d%d%d)", "%1.%2")
return moneyP
end

function show()
if hud == 1 then
hud = 0
else
hud = 1 
end
end
addCommandHandler ("hud", show)

function setVisible (bool) 
if bool == true then
	hud = 1
elseif bool == false then
	hud = 0
end
end

function getPedMaxHealth(ped)
  assert(isElement(ped) and (getElementType(ped) == "ped" or getElementType(ped) == "player"), "Bad argument @ 'getPedMaxHealth' [Expected ped/player at argument 1, got " .. tostring(ped) .. "]")
  local stat = getPedStat(ped, 24)
  local maxhealth = 100 + (stat - 569) / 4.31
  return math.max(1, maxhealth)
end