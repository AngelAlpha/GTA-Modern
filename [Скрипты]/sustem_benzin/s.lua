local carFuel = {};
local gasStations = {};
local gasStationsBlip = {};
local gasStationsMarkers = {};

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()),
    function()
        local xml = xmlLoadFile("carData.xml");
        local xmlNodes = xmlNodeGetChildren(xml);
        for i,node in ipairs(xmlNodes) do
           carFuel[tonumber(xmlNodeGetAttribute(node,'id'))] = tonumber(xmlNodeGetAttribute(node,'fuel'));
        end
        xmlUnloadFile(xml);
        --[[local xml = xmlLoadFile("garageData.xml");
        --local xmlNodes = xmlNodeGetChildren(xml);
        for i,node in ipairs(xmlNodes) do
            local name = xmlNodeGetAttribute(node,'name');
            local x = tonumber(xmlNodeGetAttribute(node,'x'));
            local y = tonumber(xmlNodeGetAttribute(node,'y'));
            local z = tonumber(xmlNodeGetAttribute(node,'z'));
            --gasStationsBlip[name] = createBlip(x,y,z,51,0,0,0,0,0,0,450);
            local moreKids = xmlNodeGetChildren(node);
            gasStationsMarkers[name] = {};
            for i,v in ipairs(moreKids) do
                local mx = tonumber(xmlNodeGetAttribute(v,'x'));
                local my = tonumber(xmlNodeGetAttribute(v,'y'));
                local mz = tonumber(xmlNodeGetAttribute(v,'z'));
                gasStationsMarkers[name][i] = createMarker(mx,my,mz,'corona',3,255,255,255,255);
                setElementData(gasStationsMarkers[name][i],'gasStation',true);
            end
        end
        xmlUnloadFile(xml);]]--
    end
)
fmarker = {
	["LS_Groove"] = {
		{1943.2846679688,-1767.1337890625,13.390598297119},
		{1943.6569824219,-1771.1690673828,13.390598297119},
		{1943.6009521484,-1774.0064697266,13.390598297119},
		{1943.5159912109,-1778.2513427734,13.390598297119},
		{1939.6678466797,-1778.7008056641,13.390598297119},
		{1939.3937988281,-1774.6412353516,13.390598297119},
		{1939.1806640625,-1771.8409423828,13.3828125},
		{1938.9836425781,-1767.5936279297,13.3828125},
	},
}

markersBenzin = {}

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()),
function ()
    for i, val in pairs (fmarker) do
		for k, v in pairs (val) do
		marker_cel = createMarker ( v[1], v[2], v[3], "corona", 3, 255, 150, 0, 100)
		setElementData(marker_cel,'gasStation',true)
		end
	end
end
)

function fuelUse(p)
local vehicle
if isElement(p) then
	if getElementType (p) == "player" then
		vehicle = getPedOccupiedVehicle(p);
	elseif getElementType (p) == "vehicle" then
		vehicle = p
	end
    if vehicle then
    setTimer(fuelUse,1000,1,p);
        if getVehicleType(vehicle) ~= 'Automobile' and getVehicleType(vehicle) ~= 'Bike' and getVehicleType(vehicle) ~= 'Monster Truck' and getVehicleType(vehicle) ~= 'Quad' then return end
        if getVehicleController(vehicle) ~= p then return end --###
        if getVehicleEngineState(vehicle) == false then return end --###
        
        local fuel = getCarFuel(vehicle)
        if fuel == 0 then setVehicleEngineState(vehicle,false); return end --###
        
        --[[local speedX, speedY, speedZ = getElementVelocity(vehicle);
        vel = (speedX^2 + speedY^2 + speedZ^2)^(0.5)+(math.random(100,1000)/25000);]]
        local newX,newY,newZ = getElementPosition(vehicle);
        local oldX = getElementData(vehicle,'oldX') or newX;
        local oldY = getElementData(vehicle,'oldY') or newY;
        local oldZ = getElementData(vehicle,'oldZ') or newZ;
        local vel = (getDistanceBetweenPoints2D(oldX,oldY,newX,newY)/2500)+(math.random(100,1000)/50000);  --1400 расход топлива чем больше тем меньше
        
        local oldX = setElementData(vehicle,'oldX',newX);
        local oldY = setElementData(vehicle,'oldY',newY);
        local oldZ = setElementData(vehicle,'oldZ',newZ)
        
        --if vel < 0.01 then return end --###
        
        local remainingFuel = takeCarFuel(vehicle,vel);
        if remainingFuel < 0.1 then
            remainingFuel = 0;
            --outputChatBox('Your car has ran out of fuel.',v);
            setVehicleEngineState(vehicle,false);
        end
    end
end
end

function startFuelUse(p,seat,jacked)
    if getVehicleType(source) ~= 'Automobile' and getVehicleType(source) ~= 'Bike' and getVehicleType(source) ~= 'Monster Truck' and getVehicleType(source) ~= 'Quad' then return end
    if seat ~= 0 then return end
    if tonumber(getCarFuel(source)) <= 0 then setVehicleEngineState(source,false); end
    setTimer(fuelUse,1000,1,p);
end
addEventHandler("onVehicleEnter",getRootElement(),startFuelUse)

function switchEngine(playerSource)
    local theVehicle = getPedOccupiedVehicle(playerSource);
    if theVehicle and getVehicleController(theVehicle) == playerSource then
        local state = getVehicleEngineState(theVehicle)
        if state then
            setVehicleEngineState(theVehicle, false);
            ---utputChatBox('Car engine turned off.',playerSource);
        else
            if getCarFuel(theVehicle) <= 0 then return end
            setVehicleEngineState(theVehicle, true);
            --outputChatBox('Car engine turned on.',playerSource);
        end
    end
end
addCommandHandler("",switchEngine);

addEvent('pedSyphonVehicle',true);
function pedSyphon(v)
    if getCarFuel(source) >= carFuel[-1] then outputChatBox("",source); return end
    local n = math.random(100,200)/1000;
    local left = takeCarFuel(v,n);
    local total = addCarFuel(source,n);
    if left <= 0 then outputChatBox("",source); return end
    triggerClientEvent("onPedSyphonFuel",source);
end
addEventHandler('pedSyphonVehicle',getRootElement(),pedSyphon);

addEvent('pedRefuelVehicle',true);
function pedSyphon(v)
    if getCarFuel(source) <= 0 then outputChatBox("",source); return end
    local maxFuel = carFuel[0];
    if carFuel[getElementModel(v)] then
        maxFuel = getFuel[getElementModel(v)];
    end
    if getCarFuel(v) >= maxFuel then
        --outputChatBox("That car is fully refueled.",source); return
    end
    local n = math.random(100,200)/1000;
    local left = takeCarFuel(source,n);
    local total = addCarFuel(v,n);
    triggerClientEvent("onPedReFuel",source);
end
addEventHandler('pedRefuelVehicle',getRootElement(),pedSyphon);

addEvent('onVehicleRefuel',true);
function vehicleRefuel(v,m, gas, money, type)
    --if not getElementData(m,'gasStation') then return end
    if getElementType(v) ~= 'vehicle' then return end
    if getVehicleType(v) ~= 'Automobile' and getVehicleType(v) ~= 'Bike' and getVehicleType(v) ~= 'Monster Truck' and getVehicleType(v) ~= 'Quad' then return end
    local driver = getVehicleOccupants(v);
    if not driver[0] then return end
    --if not isElementWithinMarker(v,m) then return end --###
    local maxFuel = carFuel[0];
		if getPlayerMoney(driver[0]) < tonumber(money) then exports["Popupsys"]:Draw("Недостаточно денег!",driver[0], "Warning"); return end
		if carFuel[getElementModel(v)] then
			maxFuel = carFuel[getElementModel(v)];
		end
		if tonumber(getCarFuel(v)) >= tonumber(maxFuel) then return end
		addCarFuel(v, tonumber(gas));
		takePlayerMoney(driver[0], money);
		if getCarFuel(v) >= maxFuel then outputChatBox("",p); exports["Popupsys"]:Draw("Бак полный!",driver[0], "Info") takeCarFuel(v,getCarFuel(v)-maxFuel); return end
end
addEventHandler('onVehicleRefuel',getRootElement(),vehicleRefuel);

function getVehicleHandlingProperty ( element, property )
    if isElement ( element ) and getElementType ( element ) == "vehicle" and type ( property ) == "string" then -- Make sure there's a valid vehicle and a property string
        local handlingTable = getVehicleHandling ( element ) -- Get the handling as table and save as handlingTable
        local value = handlingTable[property] -- Get the value from the table
        
        if value then -- If there's a value (valid property)
            return value -- Return it
        end
    end
    
    return false -- Not an element, not a vehicle or no valid property string. Return failure
end

function hitTheMarker(e)
	if getElementData(source, "gasStation") == true then
		if getElementType (e) == "vehicle" then
			setElementSpeed (e, 0)
			triggerClientEvent (getVehicleOccupant(e), "showWindow", getVehicleOccupant(e), getElementModel(e))
		end
	end
end
addEventHandler('onMarkerHit',getRootElement(),hitTheMarker);

function setElementSpeed(element, unit, speed)
	if (unit == nil) then unit = 0 end
	if (speed == nil) then speed = 0 end
	speed = tonumber(speed)
	local acSpeed = getElementSpeed(element, unit)
	if (acSpeed~=false) then -- if true - element is valid, no need to check again
		local diff = speed/acSpeed
		if diff ~= diff then return end -- if the number is a 'NaN' return end.
		local x,y,z = getElementVelocity(element)
		setElementVelocity(element,x*diff,y*diff,z*diff)
		return true
	end

	return false
end

function getElementSpeed(theElement, unit)
    -- Check arguments for errors
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    -- Default to m/s if no unit specified and 'ignore' argument type if the string contains a number
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    -- Setup our multiplier to convert the velocity to the specified unit
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    -- Return the speed by calculating the length of the velocity vector, after converting the velocity to the specified unit
    return (Vector3(getElementVelocity(theElement)) * mult).length
end

function getCarFuel(v)
    if getElementType(v) == 'vehicle' then
        if getVehicleType(v) == 'Automobile' or getVehicleType(v) == 'Bike' or getVehicleType(v) == 'Monster Truck' or getVehicleType(v) == 'Quad' then
            local fuel = getElementData(v,'fuel');
            local model = getElementModel(v);
            if not carFuel[model] then model = 0; end
            if not fuel then
                if carFuel[model] then
                    fuel = carFuel[model];
                    setElementData(v,'fuel',carFuel[model]);
                else
                    fuel = carFuel[0];
                    setElementData(v,'fuel',carFuel[0]);
                end
            end
            return tonumber(fuel);
        end
    elseif getElementType(v) == 'player' then
        local fuel = getElementData(v,'fuel');
        if not fuel then
            setElementData(v,'fuel',0);
            return 0;
        end
        return tonumber(fuel);
    end
end

function addCarFuel(v,a)
    if getElementType(v) == 'vehicle' then
        if getVehicleType(v) == 'Automobile' or getVehicleType(v) == 'Bike' or getVehicleType(v) == 'Monster Truck' or getVehicleType(v) == 'Quad' then
            local fuel = getElementData(v,'fuel');
            local model = getElementModel(v);
            if not carFuel[model] then model = 0; end
            if not fuel then
                if carFuel[model] then
                    fuel = carFuel[model];
                    setElementData(v,'fuel',carFuel[model]);
                else
                    fuel = carFuel[0];
                    setElementData(v,'fuel',carFuel[0]);
                end
            end
            fuel = fuel + a;
            if fuel > carFuel[model] then fuel = carFuel[model]; end
            setElementData(v,'fuel',fuel);
            return fuel;
        end
    elseif getElementType(v) == 'player' then
        local fuel = getElementData(v,'fuel');
        if not fuel then
            fuel = 0;
        end
        fuel = fuel + a;
        if fuel > carFuel[-1] then fuel = carFuel[-1]; end
        setElementData(v,'fuel',fuel);
        return fuel;
    end
end

function takeCarFuel(v,a)
    if getElementType(v) == 'vehicle' then
        if getVehicleType(v) == 'Automobile' or getVehicleType(v) == 'Bike' or getVehicleType(v) == 'Monster Truck' or getVehicleType(v) == 'Quad' then
            local fuel = getElementData(v,'fuel');
            local model = getElementModel(v);
            if not carFuel[model] then model = 0; end
                if not fuel then
                if carFuel[model] then
                    fuel = carFuel[model];
                    setElementData(v,'fuel',carFuel[model]);
                else
                    fuel = carFuel[0];
                    setElementData(v,'fuel',carFuel[0]);
                end
            end
            fuel = fuel - a;
            if fuel < 0 then fuel = 0; end
            setElementData(v,'fuel',fuel);
            return fuel;
        end
    elseif getElementType(v) == 'player' then
        local fuel = getElementData(v,'fuel');
        if not fuel then
            fuel = 0;
        end
        fuel = fuel - a;
        if fuel < 0 then fuel = 0; end
        setElementData(v,'fuel',fuel);
        return fuel;
    end
end

addEvent('giveVehicleFuelOnSpawn',true);
addEventHandler('giveVehicleFuelOnSpawn',getRootElement(),function()
    getCarFuel(source);
end);

function onVehicleRespawn(exploded)
if getElementType(source) ~= 'vehicle' then return end
    local model = getElementModel(source);
    if not carFuel[model] then model = 0; end
        if not fuel then
        if carFuel[model] then
            setElementData(source,'fuel',carFuel[model]);
        else
            setElementData(source,'fuel',carFuel[0]);
        end
    end
    return;
end
addEventHandler("onVehicleRespawn",getRootElement(),onVehicleRespawn)