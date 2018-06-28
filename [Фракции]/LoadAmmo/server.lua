local Gruz = {}


function startLoadMarkers (pl, cmd)
local vehicle = getPedOccupiedVehicle( pl )
if vehicle and getElementModel( vehicle ) == 433 and checkPlLVA( pl ) then
if cmd == "loadammo_1" then
	if not checkJobLVA() then
		for i, v in ipairs (getElementsByType ("player")) do
			if not checkPlLVA (v) then return end
			local marker1 = createMarker (tableMarkers[1][1], tableMarkers[1][2], tableMarkers[1][3], "cylinder", tableMarkers[1][4], 255, 150, 0, 150, v)
			local marker2 = createMarker (tableMarkers[2][1], tableMarkers[2][2], tableMarkers[2][3], "cylinder", tableMarkers[2][4], 255, 150, 0, 150, v)
			local marker3 = createMarker (tableMarkers[3][1], tableMarkers[3][2], tableMarkers[3][3], "cylinder", tableMarkers[3][4], 255, 150, 0, 150, v)
			local marker4 = createMarker (tableMarkers[4][1], tableMarkers[4][2], tableMarkers[4][3], "cylinder", tableMarkers[4][4], 255, 150, 0, 150, v)
			setElementData (marker1, "LVAAmmo:startLoad", true)
			setElementData (marker2, "LVAAmmo:skladAmmo", true)
			setElementData (marker3, "LVAAmmo:startUnload", true)
			setElementData (marker4, "LVAAmmo:skladFrac", true)
		end
	else
		outputChatBox ("Кто то уже развозит боеприпасы!", pl, 255, 155, 0)
	end
elseif cmd == "loadammo_2" then
	if not checkJobLSPD() then
		for i, v in ipairs (getElementsByType ("player")) do
			if not checkPlLVA (v) then return end
			local marker1 = createMarker (tableMarkers[1][1], tableMarkers[1][2], tableMarkers[1][3], "cylinder", tableMarkers[1][4], 255, 150, 0, 150, v)
			local marker2 = createMarker (tableMarkers[2][1], tableMarkers[2][2], tableMarkers[2][3], "cylinder", tableMarkers[2][4], 255, 150, 0, 150, v)
			local marker3 = createMarker (tableMarkers[3][1], tableMarkers[3][2], tableMarkers[3][3], "cylinder", tableMarkers[3][4], 255, 150, 0, 150, v)
			local marker4 = createMarker (tableMarkers[5][1], tableMarkers[5][2], tableMarkers[5][3], "cylinder", tableMarkers[5][4], 255, 150, 0, 150, v)
			setElementData (marker1, "LVAAmmo:startLoad", true)
			setElementData (marker2, "LVAAmmo:skladAmmo", true)
			setElementData (marker3, "LVAAmmo:startUnload", true)
			setElementData (marker4, "LVAAmmo:skladFrac", true)
		end
	else
		outputChatBox ("Кто то уже развозит боеприпасы!", pl, 255, 155, 0)
	end
end
end
end
addCommandHandler ("loadammo_1", startLoadMarkers)
addCommandHandler ("loadammo_2", startLoadMarkers)

function stopLoadMarkers ()
for i, v in ipairs (getElementsByType ("marker")) do
	if isElement (v) then
		if getElementData (v, "LVAAmmo:startLoad") then
			destroyElement (v)
		end
	end
	if isElement (v) then
		if getElementData (v, "LVAAmmo:skladAmmo") then
			destroyElement (v)
		end
	end
	if isElement (v) then
		if getElementData (v, "LVAAmmo:startUnload") then
			destroyElement (v)
		end
	end
	if isElement (v) then
		if getElementData (v, "LVAAmmo:skladFrac") then
			destroyElement (v)
		end
	end
	if isElement (v) then
		if getElementData (v, "LVAAmmo:VehMarker") then
			destroyElement (v)
		end
	end
end
end
addCommandHandler ("loadoff", stopLoadMarkers)

addEventHandler ("onPlayerMarkerHit", root, function(marker)
if not isElement (marker) then return end
	if getElementData (marker, "LVAAmmo:startLoad") or getElementData (marker, "LVAAmmo:startUnload") then
		if not veh(source) then return end
		if not checkPlLVA (source) then return end
		if getElementData( veh(source), "LVAAmmo:Veh" ) then return end -- Проверка на то что маркер уже существует, чтобы не создалось 2
		local x, y, z = getElementPosition (veh(source))
		local marker = createMarker (x, y, z, "arrow", 1.5, 255, 255, 0, 150)
		attachElements (marker, veh(source), 0, -5.5, 0.3)
		setElementData (veh(source), "LVAAmmo:Veh", marker)
		setElementData (marker, "LVAAmmo:VehMarker", veh(source))
	elseif getElementData (marker, "LVAAmmo:skladAmmo") then
		if veh(source) then return end
		if not checkPlLVA (source) then return end
		if getGruz() then return end -- Проверка на то что ящик уже существует, чтобы не создалось 2
		GruzYshik ()
		triggerClientEvent("loadammo:CallCheck", getRootElement(), source, true)
		trueControl ()
	elseif getElementData (marker, "LVAAmmo:VehMarker") then
		if veh(source) then return end
		if not checkPlLVA (source) then return end
		local barracks = getElementAttachedTo(marker)
		local m = getMarkerWithingMarker (barracks)
		if getElementData (m, "LVAAmmo:startLoad") then
			if getGruz () then
				if not getElementData (source, "load:job") then
					local gruz = getElementData (source, "Gruz:Ammo")
					detachElementFromBone(gruz)
					destroyElement(gruz)
					removeElementData (source, "Gruz:Ammo")
					triggerClientEvent("loadammo:CallCheck", getRootElement(), source, false)
					falseControl ()
					local barracks = getElementAttachedTo(marker)
					setElementData (barracks, "LVAAmmo:Load", (getElementData (barracks, "LVAAmmo:Load") or 0) + slot)
					if getElementData (barracks, "LVAAmmo:Load") >= maxSlots then
						setElementData (barracks, "LVAAmmo:Load", maxSlots)
						outputChatBox ("Грузовик загружен!", source, 255, 150, 0)
					end
				end
			end
		end
		if getElementData (m, "LVAAmmo:startUnload") then
			if not getGruz () then
				if not getElementData (source, "load:job") then
					local barracks = getElementAttachedTo(marker)
					if getElementData (barracks, "LVAAmmo:Load") > 0 then
						GruzYshik ()
						triggerClientEvent("loadammo:CallCheck", getRootElement(), source, true)
						trueControl ()
						setElementData (barracks, "LVAAmmo:Load", (getElementData (barracks, "LVAAmmo:Load") or 0) - slot)
						if getElementData (barracks, "LVAAmmo:Load") <= 0 then
							setElementData (barracks, "LVAAmmo:Load", 0)
						end
					end
				end
			end
		end
	elseif getElementData (marker, "LVAAmmo:skladFrac") then
		if veh(source) then return end
		if not checkPlLVA (source) then return end
		if getGruz () then
			local gruz = getElementData (source, "Gruz:Ammo")
				detachElementFromBone(gruz)
				destroyElement(gruz)
				removeElementData (source, "Gruz:Ammo")
			triggerClientEvent("loadammo:CallCheck", getRootElement(), source, false)
			falseControl ()
			setElementData (getMarker(), "LVAAmmo:fracAmmo", (getElementData (getMarker(), "LVAAmmo:fracAmmo") or 0) + slot) --Тут должен пополняться склад оружия (маркер)
			if getElementData (getMarker(), "LVAAmmo:fracAmmo") >= maxSlotsFrac then
				setElementData (getMarker(), "LVAAmmo:fracAmmo", maxSlotsFrac)
				outputChatBox ("Склад полон!", source, 255, 150, 0)
			end
		end
	end
end)

-- В этом эвенте source это маркер, element это тот кто покинул маркер (игрок, транспорт и т.п.)
addEventHandler( "onMarkerLeave", root, function( element )
	local gruzMarker = getElementData( element, "LVAAmmo:Veh" )
	-- Если грузовик покидает маркер погрузки/выгрузки
	if gruzMarker and ( getElementData( source, "LVAAmmo:startLoad" ) or getElementData( source, "LVAAmmo:startUnload" ) ) then
		if isElement( gruzMarker ) then destroyElement( gruzMarker ) end -- удаляем маркер, если он существует
		removeElementData( element, "LVAAmmo:Veh" ) -- Удаляем с грузовика ссылку на маркер
	end
end )			
				
function GruzYshik()
    local x,y,z = getElementPosition( source )
	local gruz = createObject( 1271, x, y, z )
    --Gruz[source] = createObject(1271,x,y,z)
	setElementData( source, "Gruz:Ammo", gruz )
	--local gruz = getElementData (source, "Gruz:Ammo")
    setElementCollisionsEnabled( gruz, false )
    setObjectScale( gruz, 0.7 )
    attachElementToBone( gruz, source, 4, -0.1, 0.55, -0.45, -90, 0, 0 )
end

function getGruz ()
if getElementData (source, "Gruz:Ammo") then
	return true
else
	return false
end
end

function trueControl()
toggleControl(source, "enter_exit", false )
toggleControl(source, "jump", false )
toggleControl(source, "fire", false )
toggleControl(source, "sprint", false )
toggleControl(source, "aim_weapon", false )
toggleControl(source, "next_weapon", false )
toggleControl(source, "previous_weapon", false )
end

function falseControl()
toggleControl(source, "enter_exit", true )
toggleControl(source, "jump", true )
toggleControl(source, "fire", true )
toggleControl(source, "sprint", true )
toggleControl(source, "aim_weapon", true )
toggleControl(source, "next_weapon", true )
toggleControl(source, "previous_weapon", true )
end

function checkJobLVA ()
for i, v in ipairs (getElementsByType ("marker")) do
	if getElementData (v, "LVAAmmo:startLoadLVA") then
		return true
	end
end
return false
end

function checkJobLSPD ()
for i, v in ipairs (getElementsByType ("marker")) do
	if getElementData (v, "LVAAmmo:startLoad") then
		return true
	end
end
return false
end