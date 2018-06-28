maxSlots = 500
slot = 1
maxSlotsFrac = 5000


tableMarkers = {
{297.12662, 1905.57996, 17.64063, 2}, --Маркер где должен быть грузовик для появления маркера загрузки
{307.52640, 1902.56287, 17.64063, 1.5}, --Маркер где береться ящик для загрузки в грузовик
{286.09766, 1927.72144, 17.64063, 2}, --Маркер где должен быть грузовик для появления маркера разгрузки
{289.73059, 1937.05627, 17.64063, 1.5}, --Маркер разгрузки LVA
{297.64471, 1941.72400, 17.64063, 1.5}, --Маркер разгрузки LSPD
{303.89297, 1933.33240, 17.64063, 1.5}, --Маркер склада LVA
{293.85355, 1933.51270, 17.64063, 1.5}, --Маркер склада LSPD
}

tableWeapon = {
["Пистолет"] = 100,
["Пистолет с глушителем"] = 100,
["Дигл"] = 100,
["Дробовик"] = 200,
["Обрез"] = 200,
["SPAZ-12"] = 200,
["Uzi"] = 400,
["Tec-9"] = 400,
["MP5"] = 400,
["M4A1"] = 500,
["AK47"] = 500,
["Винтовка"] = 500,
["Бронежилет"] = 100,
}

function veh (el)
return getPedOccupiedVehicle(el)
end


function dxDrawTextOnElement(TheElement,text,height,distance,R,G,B,alpha,size,font,checkBuildings,checkVehicles,checkPeds,checkDummies,seeThroughStuff,ignoreSomeObjectsForCamera,ignoredElement)
				local x, y, z = getElementPosition(TheElement)
				local x2, y2, z2 = getElementPosition(localPlayer)
				local distance = distance or 20
				local height = height or 1
                                local checkBuildings = checkBuildings or true
                                local checkVehicles = checkVehicles or false
                                local checkPeds = checkPeds or false
                                local checkObjects = checkObjects or true
                                local checkDummies = checkDummies or true
                                local seeThroughStuff = seeThroughStuff or false
                                local ignoreSomeObjectsForCamera = ignoreSomeObjectsForCamera or false
                                local ignoredElement = ignoredElement or nil
				if (isLineOfSightClear(x, y, z, x2, y2, z2, checkBuildings, checkVehicles, checkPeds , checkObjects,checkDummies,seeThroughStuff,ignoreSomeObjectsForCamera,ignoredElement)) then
					local sx, sy = getScreenFromWorldPosition(x, y, z+height)
					if(sx) and (sy) then
						local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
						if(distanceBetweenPoints < distance) then
							dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center")
			end
		end
	end
end

function getMarkerLVA ()
for i, v in ipairs (getElementsByType ("marker")) do
	if getElementData (v, "LVAAmmo:fracAmmoLVA") then
		return v
	end
end
end

function getMarkerLSPD ()
for i, v in ipairs (getElementsByType ("marker")) do
	if getElementData (v, "LVAAmmo:fracAmmoLSPD") then
		return v
	end
end
end

function checkPlLVA (pl)
if getElementData (pl, "frac") == "LVA" then
	return true
else
	return false
end
end

function checkPlLSPD (pl)
if getElementData (pl, "frac") == "LSPD" then
	return true
else
	return false
end
end

function getMarkerWithingMarker (el)
for i, v in ipairs (getElementsByType ("marker")) do
if isElementWithinMarker (el, v) then
	return v
end
end
end