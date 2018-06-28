radio1Price = 1
radio2Price = 3
radio3Price = 5
radio4Price = 2		
local font = guiCreateFont ("3574.ttf", 22)
local font2 = guiCreateFont ("3574.ttf", 13)
		local screenW, screenH = guiGetScreenSize()
        window = guiCreateWindow((screenW - 282) / 2, (screenH - 218) / 2, 330, 218, "АЗС", false)
        guiWindowSetSizable(window, false)
		guiSetVisible(window, false)

        FuelBuy = guiCreateLabel(30, 28, 108, 37, "0.0", false, window)
		guiSetFont (FuelBuy, font)
		guiLabelSetVerticalAlign(FuelBuy, "center")
		guiLabelSetHorizontalAlign(FuelBuy, "left")
		
        label_1 = guiCreateLabel(88, 28, 60, 37, "Литров", false, window)
        guiSetFont(label_1, font2)
        guiLabelSetVerticalAlign(label_1, "center")
		guiLabelSetHorizontalAlign(label_1, "left")
        PriceFuel = guiCreateLabel(10, 75, 262, 27, "Стоимость:", false, window)
        guiSetFont(PriceFuel, "default-bold-small")
        guiLabelSetVerticalAlign(PriceFuel, "center")
		guiSetFont (PriceFuel, font2)
		
        Ostatok = guiCreateLabel(10, 112, 262, 27, "Остаток:", false, window)
        guiSetFont(Ostatok, "default-bold-small")
        guiLabelSetVerticalAlign(Ostatok, "center")
		guiSetFont (Ostatok, font2)
		
		InFuel = guiCreateLabel(10, 149, 262, 27, "В баке:", false, window)
        guiSetFont(InFuel, "default-bold-small")
        guiLabelSetVerticalAlign(InFuel, "center")
		guiSetFont (InFuel, font2)
		
        Close = guiCreateButton(10, 184, 118, 38, "Закрыть", false, window)
        guiSetProperty(Close, "NormalTextColour", "FFAAAAAA")
        Buy = guiCreateButton(154, 184, 118, 38, "Заправить", false, window)
        guiSetProperty(Buy, "NormalTextColour", "FFAAAAAA")

		radio1 = guiCreateRadioButton (174, 28, 140, 37, "АИ92 - "..radio1Price.."$\1 Литр", false, window)
		guiSetEnabled (radio1, false)
		
		radio2 = guiCreateRadioButton (174, 65, 140, 37, "АИ95 - "..radio2Price.."$\1 Литр", false, window)
		guiSetEnabled (radio2, false)
		
		radio3 = guiCreateRadioButton (174, 102,140, 37, "АИ98 - "..radio3Price.."$\1 Литр", false, window)
		guiSetEnabled (radio3, false)
		
		radio4 = guiCreateRadioButton (174, 139,140, 37, "Электр. - "..radio4Price.."$\1 кВт/ч", false, window)
		guiSetEnabled (radio4, false)
		
addEvent ("showWindow", true)
addEventHandler ("showWindow", root, function(model)
	guiSetVisible (window, not guiGetVisible(window))
	showCursor (guiGetVisible(window))
	local fuel = getCarFuelType (model)
	if fuel then
		for i, type in pairs (fuel) do
			if tonumber(type) == 92 then
				guiSetEnabled (radio1, true)
			elseif tonumber(type) == 95 then
				guiSetEnabled (radio2, true)
			elseif tonumber(type) == 98 then
				guiSetEnabled (radio3, true)
			elseif tonumber(type) == 99 then
				guiSetEnabled (radio4, true)
			end
		end	
	else
		guiSetEnabled (radio1, true)
	end
	if getElementData (getPedOccupiedVehicle(localPlayer), "fuel") then
		guiSetText(InFuel, "В баке: "..tonumber(math.floor(getCarFuel(getPedOccupiedVehicle(localPlayer)))))
	end
	guiSetText (Ostatok, "Остаток:")
	guiSetText (PriceFuel, "Стоимость:")
	guiSetText (FuelBuy, "0.0")
	addEventHandler ("onClientElementDataChange", root, function(dn)
	if dn == "fuel" then
		if getCarFuel(getPedOccupiedVehicle(localPlayer)) then
		guiSetText(InFuel, "В баке: "..tonumber(math.floor(getCarFuel(getPedOccupiedVehicle(localPlayer)))))
		end
	end
	end)
end)

local fuelPrice
local timer
addEventHandler ("onClientGUIClick", root, function()
if guiGetVisible (window) ~= false then
	addEventHandler ("onClientGUIChanged", FuelBuy, function()
		if guiGetText (FuelBuy) ~= "" or guiGetText (FuelBuy) ~= " " then
			if tonumber(guiGetText (FuelBuy)) > 50 - getElementData (getPedOccupiedVehicle(localPlayer), "fuel") then
				guiSetText (FuelBuy, math.floor(50 - getElementData (getPedOccupiedVehicle(localPlayer), "fuel")))
			end
			local fuel = tonumber(guiGetText (FuelBuy))
			if guiRadioButtonGetSelected (radio1) then
				fuelPrice = tonumber(guiGetText (FuelBuy))*radio1Price
			elseif guiRadioButtonGetSelected (radio2) then
				fuelPrice = tonumber(guiGetText (FuelBuy))*radio2Price
			elseif guiRadioButtonGetSelected (radio3) then
				fuelPrice = tonumber(guiGetText (FuelBuy))*radio3Price
			elseif guiRadioButtonGetSelected (radio4) then
				fuelPrice = tonumber(guiGetText (FuelBuy))*radio4Price
			end
			if fuelPrice then
				local ost = tonumber(getPlayerMoney()) - fuelPrice
				local price = string.gsub(tostring(ost), "^(-?%d+)(%d%d%d)", "%1.%2")
				local price2 = string.gsub(tostring(price), "^(-?%d+)(%d%d%d)", "%1.%2")
				local price3 = string.gsub(tostring(price2), "^(-?%d+)(%d%d%d)", "%1.%2")
				guiSetText (PriceFuel, "Стоимость: "..fuelPrice.."$")
				guiSetText (Ostatok, "Остаток: "..price3.."$")
			end
		end
	end)
	if source == Buy then
		if getVehicleEngineState (getPedOccupiedVehicle(localPlayer)) then exports["PopupSys"]:Draw ("Перед заправкой заглушите двигатель!", "Error") return end
		if not isTimer (timer) then
				local fuelInCar = tonumber(math.floor(getCarFuel(getPedOccupiedVehicle(localPlayer))))
				if tonumber(guiGetText (FuelBuy)) <= (50 - fuelInCar) then
					if guiRadioButtonGetSelected(radio1) or guiRadioButtonGetSelected(radio2) or guiRadioButtonGetSelected(radio3) or guiRadioButtonGetSelected(radio4) then
						if guiGetText (FuelBuy) ~= "0.0" then
							guiSetText (FuelBuy, "0.0")
						end
						timer = setTimer (refuel, 100, 0)
					else
						exports["PopupSys"]:Draw ("Выберите вид топлива.", "Error")
					end
				end
		else
			if guiRadioButtonGetSelected(radio1) then
				triggerServerEvent ("onVehicleRefuel", localPlayer, getPedOccupiedVehicle(localPlayer), _, guiGetText (FuelBuy), tonumber(guiGetText (FuelBuy))*radio1Price, "92")
			elseif guiRadioButtonGetSelected(radio2) then
				triggerServerEvent ("onVehicleRefuel", localPlayer, getPedOccupiedVehicle(localPlayer), _, guiGetText (FuelBuy), tonumber(guiGetText (FuelBuy))*radio2Price, "95")
			elseif guiRadioButtonGetSelected(radio3) then
				triggerServerEvent ("onVehicleRefuel", localPlayer, getPedOccupiedVehicle(localPlayer), _, guiGetText (FuelBuy), tonumber(guiGetText (FuelBuy))*radio3Price, "98")
			elseif guiRadioButtonGetSelected(radio4) then
				triggerServerEvent ("onVehicleRefuel", localPlayer, getPedOccupiedVehicle(localPlayer), _, guiGetText (FuelBuy), tonumber(guiGetText (FuelBuy))*radio4Price, "99")
			end
			killTimer (timer)
		end
	elseif source == Close then
	if isTimer (timer) then exports["PopupSys"]:Draw ("Машина еще заправляется!.", "Error") return end
	guiSetVisible (window, false)
	showCursor (false)
	end
end
end)		

function refuel ()
local text = tonumber(guiGetText (FuelBuy))
local text = text + 0.1
if string.len(text) == 1 then 
	guiSetText (FuelBuy, text..".0")
else
	guiSetText (FuelBuy, text)
end
local fuel = tonumber(guiGetText (FuelBuy))
if guiRadioButtonGetSelected (radio1) then
	fuelPrice = fuel*radio1Price
elseif guiRadioButtonGetSelected (radio2) then
	fuelPrice = fuel*radio2Price
elseif guiRadioButtonGetSelected (radio3) then
	fuelPrice = fuel*radio3Price
elseif guiRadioButtonGetSelected (radio4) then
	fuelPrice = fuel*radio4Price
end
local ost = math.floor(tonumber(getPlayerMoney()) - fuelPrice)
local price = string.gsub(tostring(ost), "^(-?%d+)(%d%d%d)", "%1.%2")
local price2 = string.gsub(tostring(price), "^(-?%d+)(%d%d%d)", "%1.%2")
local price3 = string.gsub(tostring(price2), "^(-?%d+)(%d%d%d)", "%1.%2")
guiSetText (PriceFuel, "Стоимость: "..math.floor(fuelPrice).."$")
guiSetText (Ostatok, "Остаток: "..price3.."$")
local carFuel = tonumber(getElementData (getPedOccupiedVehicle(localPlayer), "fuel"))
if string.len(carFuel+text) == 1 then 
	guiSetText (InFuel, "В баке: "..math.round(carFuel+text, 1)..".0")
else
	guiSetText (InFuel, "В баке: "..math.round(carFuel+text, 1))
end
if (text + carFuel) > 50 then
	killTimer (timer)
	outputChatBox ("Бак полный", 0, 255, 0)
end
if text > 49.9 then
	killTimer (timer)
	outputChatBox ("Бак полный", 0, 255, 0)
end
end

local carFuel = {};

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
    function()
        local xml = xmlLoadFile("carData.xml");
        local xmlNodes = xmlNodeGetChildren(xml);
        for i,node in ipairs(xmlNodes) do
           carFuel[tonumber(xmlNodeGetAttribute(node,'id'))] = tonumber(xmlNodeGetAttribute(node,'fuel'));
        end
        xmlUnloadFile(xml);
    end
)

addEvent("onPedSyphonFuel",true);
function startSyphon()
    if not isPedInVehicle(localPlayer) then
        if isPedOnGround(localPlayer) then
            local px, py, pz = getElementPosition(localPlayer);
            local rot = getPedRotation(localPlayer);
             
            local a = math.rad(90 - rot);
         
            local dx = math.cos(a) * 1.5;
            local dy = math.sin(a) * 1.5;
            local ppx = math.cos(a) * 0.2;
            local ppy = math.sin(a) * 0.2;
         
            local ex = px-dx;
            local ey = py+dy;
            px = px-ppx;
            py = py+ppy;
            hit, x, y, z, elementHit = processLineOfSight(px, py, pz+1, ex, ey, pz);
            if elementHit then
                if getElementType(elementHit) == 'vehicle' then
                    triggerServerEvent('pedSyphonVehicle',localPlayer,elementHit);
                end
            end
        end
    end
end
addEventHandler("onPedSyphonFuel",getRootElement(),startSyphon);
addCommandHandler('syphon',startSyphon)

addEvent("onPedReFuel",true);
function fillHerUp()
    local vehicle = getPedOccupiedVehicle(localPlayer);
    if not isPedInVehicle(localPlayer) then
        if isPedOnGround(localPlayer) then
            local px, py, pz = getElementPosition(localPlayer);
            local rot = getPedRotation(localPlayer);
             
            local a = math.rad(90 - rot);
         
            local dx = math.cos(a) * 1.5;
            local dy = math.sin(a) * 1.5;
            local ppx = math.cos(a) * 0.2;
            local ppy = math.sin(a) * 0.2;
         
            local ex = px-dx;
            local ey = py+dy;
            px = px-ppx;
            py = py+ppy;
            hit, x, y, z, elementHit = processLineOfSight(px, py, pz+1, ex, ey, pz);
            if elementHit then
                if getElementType(elementHit) == 'vehicle' then
                    triggerServerEvent('pedRefuelVehicle',localPlayer,elementHit);
                end
            end
        end
    end
end
addEventHandler("onPedReFuel",getRootElement(),fillHerUp);
addCommandHandler('refuel',fillHerUp)

--[[function drawGUI()
    local vehicle = getPedOccupiedVehicle(localPlayer);
    if vehicle then
        local x,y = guiGetScreenSize();
        if getVehicleType(vehicle) ~= 'Automobile' and getVehicleType(vehicle) ~= 'Bike' and getVehicleType(vehicle) ~= 'Monster Truck' and getVehicleType(vehicle) ~= 'Quad' then return end
        local driver = getVehicleController(vehicle);
        if driver ~= localPlayer then return end --###
        if getVehicleEngineState(vehicle) == false then return end --###
        --dxDrawRectangle(x-53,(y/2)-75,40,142,0x66224466);
        local maxFuel = carFuel[0];
        local curFuel = getElementData(vehicle,'fuel');
        local carHealth = getElementHealth(vehicle)/10;
        if curFuel == false then return end
        if carFuel[getElementModel(vehicle)] then maxFuel = carFuel[getElementModel(vehicle)]; end
        local fuel = (curFuel/maxFuel)*100;
        local colour = nil;
        end
        end
addEventHandler("onClientRender",getRootElement(),drawGUI);]]--


addEventHandler("onClientElementStreamIn",getRootElement(),function ()
    if getElementType(source) ~= 'vehicle' then return end
    if getVehicleType(source) ~= 'Automobile' and getVehicleType(source) ~= 'Bike' and getVehicleType(source) ~= 'Monster Truck' and getVehicleType(source) ~= 'Quad' then return end
    triggerServerEvent('giveVehicleFuelOnSpawn',source);
end);

function getCarFuel(v)
if v then
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
            return fuel;
        end
    elseif getElementType(v) == 'player' then
        local fuel = getElementData(v,'fuel');
        if not fuel then
            setElementData(v,'fuel',0);
            return 0;
        end
        return fuel;
    end
end
end

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end