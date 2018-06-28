--------------------------------------------------------------------------------------------------
-- Distributed under the Creative Commons Attribution-NonCommercial 4.0 International license	--
-- Version:				(release) 1.0.0															--
-- Original author: 	Kacper "MrTasty (aka Addon)" Stasiak									--
-- Special thanks to: 	Doomed_Space_Marine (useful functions)									--
--						robhol (useful functions)												--
--------------------------------------------------------------------------------------------------

--Features
local enableBlips = true
local renderNorthBlip = true
local alwaysRenderMap = false --true = always render map, false = only render when in interior world 0 (radar will stay, only the map will stop rendering)
local alwaysRenderOxygen = false --true = always render oxygen, false = only when oxygen not full/local player in water
local disableGTASAhealth = true --Disable GTASA's HUD health display
local disableGTASAarmor = true --Disable GTASA's HUD armour display
local disableGTASAoxygen = true --Disable GTASA's HUD oxygen display

--Dimensions & Sizes
local worldW, worldH = 3072, 3072 --map image dimensions - if map image changed, please edit appropriately --3072
local blip = 12 --Blip size, pixels relative to 1366x768 resolution

--Colours - Notice: Health colours smoothly according it local player's HP.
local healthOkayR, healthOkayG, healthOkayB = 102, 204, 102 --RGB for health which is 'okay' (50% or more)
local healthBadR, healthBadG, healthBadB = 200, 200, 0 --RGB for health which is 'bad' (25%)
local healthCriticalR, healthCriticalG, healthCriticalB = 200, 0, 0 --RGB for health which is 'critically low' (near/at 0%)
local armorColorR, armorColorG, armorColorB = 0, 102, 255
local oxygenColorR, oxygenColorG, oxygenColorB = 255, 255, 0



------------------------------------------------------------------------------------
--Do not modify anything below unless you're absolutely sure of what you're doing.--
------------------------------------------------------------------------------------

local sx, sy = guiGetScreenSize()
local rt = dxCreateRenderTarget(290, 175)
local xFactor, yFactor = sx/1366, sy/768
local yFactor = xFactor --otherwise the radar looses it's 2:3 ratio.


-- Useful functions --
function findRotation(x1,y1,x2,y2) --Author: Doomed_Space_Marine & robhol
  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end;
  return t;
end
function getPointFromDistanceRotation(x, y, dist, angle) --Author: robhol
    local a = math.rad(90 - angle);
    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;
    return x+dx, y+dy;
end

local hud = 1

function drawRadar()
if hud == 1 then
	if disableGTASAhealth then setPlayerHudComponentVisible("health", false) end
	if disableGTASAarmor then setPlayerHudComponentVisible("armour", false) end
	if disableGTASAoxygen then setPlayerHudComponentVisible("breath", false) end
	if (not isPlayerMapVisible()) then
		local mW, mH = dxGetMaterialSize(rt)
		local x, y = getElementPosition(localPlayer)
		local X, Y = mW/2 -(x/(6000/worldW)), mH/2 +(y/(6000/worldH))
		local camX,camY,camZ = getElementRotation(getCamera())
		dxSetRenderTarget(rt, true)
		if alwaysRenderMap or getElementInterior(localPlayer) == 0 then
			dxDrawRectangle(0, 0, mW, mH, 0xFF7CA7D1) --render background 
			--dxDrawImage(X - worldW/1.98, mH/5 + (Y - worldH/2), worldW, worldH, "image/world.jpg", camZ, (x/(6000/worldW)+5), -(y/(6000/worldH)+1.7), tocolor(255, 255, 255, 255))
			dxDrawImage(X - worldW/2 - 5, mH/5 + (Y - worldH/2), worldW, worldH, "image/world.jpg", camZ, (x/(6000/worldW)), -(y/(6000/worldH)), tocolor(255, 255, 255, 255))
		end
		dxSetRenderTarget()
		dxDrawImage((10)*xFactor+16, sy-((160+40))*yFactor, (300-10)*xFactor, (175)*yFactor, rt, 0, 0, 0, tocolor(255, 255, 255, 150))
		--dxDrawImage((10)*xFactor+2, sy-((200+54))*yFactor, (320.5)*xFactor, (208)*yFactor, "image/ram.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		local health = math.max(math.min(getElementHealth(localPlayer)/(0.232018558500192*getPedStat(localPlayer, 24) -32.018558511152), 1), 0)
		local armor = math.max(math.min(getPedArmor(localPlayer)/100, 1), 0)
		local oxygen = math.max(math.min(getPedOxygenLevel(localPlayer)/(1.5*getPedStat(localPlayer, 225) +1000), 1), 0)
		local r, g, b
		if health >= 0.25 then
			r, g, b = interpolateBetween(healthBadR, healthBadG, healthBadB, healthOkayR, healthOkayG, healthOkayB, math.floor(health*20)/10, "InOutQuad")
		else
			r, g, b = interpolateBetween(healthCriticalR, healthCriticalB, healthCriticalB, healthBadR, healthBadG, healthBadB, math.floor(health*20)/10, "InOutQuad")
		end
		local col = tocolor(r, g, b, 190)
		local bg = tocolor(r, g, b, 100)
		local rx, ry, rz = getElementRotation(localPlayer)
		local lB = (15)*xFactor
		local rB = (15+290)*xFactor
		local tB = sy-(205)*yFactor
		local bB = tB + (175)*yFactor
		local cX, cY = (rB+lB)/2, (tB+bB)/2 +(35)*yFactor
		local toLeft, toTop, toRight, toBottom = cX-lB, cY-tB, rB-cX, bB-cY
		for k, v in ipairs(getElementsByType("blip")) do
			local bx, by = getElementPosition(v)
			local actualDist = getDistanceBetweenPoints2D(x, y, bx, by)
			local maxDist = getBlipVisibleDistance(v)
			if actualDist <= maxDist and getElementDimension(v)==getElementDimension(localPlayer) and getElementInterior(v)==getElementInterior(localPlayer) then
				local dist = actualDist/(6000/((worldW+worldH)/2))
				local rot = findRotation(bx, by, x, y)-camZ
				local bpx, bpy = getPointFromDistanceRotation(cX, cY, math.min(dist, math.sqrt(toTop^2 + toRight^2)), rot)
				local bpx = math.max(lB, math.min(rB, bpx))
				local bpy = math.max(tB, math.min(bB, bpy))
				local bid = getElementData(v, "customIcon") or getBlipIcon(v)
				local _, _, _, bcA = getBlipColor(v)
				local bcR, bcG, bcB = 255, 255, 255
				if getBlipIcon(v) == 0 then
					bcR, bcG, bcB = getBlipColor(v)
				end
				local bS = getBlipSize(v)
				if getElementAttachedTo (v) ~= localPlayer then
					dxDrawImage(bpx -(blip*bS)*xFactor/7, bpy -(blip*bS)*yFactor*0.3, (blip*bS)*xFactor, (blip*bS)*yFactor, "image/blip/"..bid..".png", 0, 0, 0, tocolor(bcR, bcG, bcB, bcA))
				end
			end
		end
		if renderNorthBlip then
			local rot = -camZ+180
			local bpx, bpy = getPointFromDistanceRotation(cX, cY, math.sqrt(toTop^2 + toRight^2), rot) --get position
			local bpx = math.max(lB, math.min(rB, bpx))
			local bpy = math.max(tB, math.min(bB, bpy)) --cap position to screen
			local dist = getDistanceBetweenPoints2D(cX, cY, bpx, bpy) --get distance to the capped position
			local bpx, bpy = getPointFromDistanceRotation(cX, cY, dist, rot) --re-calculate position based on new distance
			if bpx and bpy then --if position was obtained successfully
				local bpx = math.max(lB, math.min(rB, bpx))
				local bpy = math.max(tB, math.min(bB, bpy)) --cap position just in case
				dxDrawImage(bpx -(blip*2)/5, bpy -(blip*2)*0.3, blip*2, blip*2, "image/blip/4.png", 0, 0, 0) --draw north (4) blip
			end
		end
		dxDrawImage(cX -(blip*2)*xFactor/5, cY -(blip*2)*yFactor*0.3, (blip*2)*xFactor, (blip*2)*yFactor, "image/player.png", camZ-rz, 0, 0)
	end
end
end
addEventHandler("onClientRender", root, drawRadar)

function show()
if hud == 1 then
hud = 0
else
hud = 1 
end
end
addCommandHandler ("map", show)

function setVisible (bool) 
if bool == true then
	hud = 1
elseif bool == false then
	hud = 0
end
end

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
     if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
          local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
          if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
               for i, v in ipairs( aAttachedFunctions ) do
                    if v == func then
        	         return true
        	    end
	       end
	  end
     end
     return false
end

addEventHandler("onClientResourceStart", root, function()
setPlayerHudComponentVisible("radar", false)
for i, v in ipairs (getElementsByType("blip")) do
	if getBlipIcon(v) ~= 0 then
		setBlipVisibleDistance (v, 500)
		setBlipSize (v, 2)
	end
end
end)