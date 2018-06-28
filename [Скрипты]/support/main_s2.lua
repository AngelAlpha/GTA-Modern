local supportsTable = {
	["bp_rf"] = "wheel_rf_dummy",
	["bp_lf"] = "wheel_lf_dummy",
	["bp_rb"] = "wheel_rb_dummy",
	["bp_lb"] = "wheel_lb_dummy"
}

function isVehicleCompatible(vehicle)
	local supports = 0
	for key, value in pairs(supportsTable) do 
		if getVehicleComponentVisible(vehicle, supportsTable[key]) then
			supports = supports + 1
		end
	end

	if supports == 4 then return true else return false end
end

addEventHandler("onClientPreRender", root, function()

	local streamedVehicles = getElementsByType("vehicle", root, true)
	
	for i, v in ipairs(streamedVehicles) do
		if isVehicleCompatible(v) then
			for support, dummy in pairs(supportsTable) do
				-- Если суппорта передние - вращаем их
				if dummy == "wheel_rf_dummy" or dummy == "wheel_lf_dummy" then
					local rX, rY, rZ = getVehicleComponentRotation(v, dummy, "parent")
					-- Устанавливаем правильную ротацию суппортов по осям X и Y
					if dummy == "wheel_lf_dummy" then rX, rY = 180, 180 else rX, rY = 0, 0 end
					-- Поворачиваем суппорт аналогично колесу
					setVehicleComponentRotation(v, support, rX, rY, rZ, "parent")
				end
			end
		end
	end
end)

function show ()
local streamedVehicles = getElementsByType("vehicle", root, true)
	for i, v in ipairs(streamedVehicles) do
		if getElementData (v, "gus") == true then
			setVehicleComponentVisible (v, "bp_rf", true)
			setVehicleComponentVisible (v, "bp_lf", true)
			setVehicleComponentVisible (v, "bp_rb", true)
			setVehicleComponentVisible (v, "bp_lb", true)
			setVehicleComponentVisible (v, "wheel_rf_dummy", false)
			setVehicleComponentVisible (v, "wheel_lf_dummy", false)
			setVehicleComponentVisible (v, "wheel_rb_dummy", false)
			setVehicleComponentVisible (v, "wheel_lb_dummy", false)
		else
			setVehicleComponentVisible (v, "bp_rf", false)
			setVehicleComponentVisible (v, "bp_lf", false)
			setVehicleComponentVisible (v, "bp_rb", false)
			setVehicleComponentVisible (v, "bp_lb", false)
			setVehicleComponentVisible (v, "wheel_rf_dummy", true)
			setVehicleComponentVisible (v, "wheel_lf_dummy", true)
			setVehicleComponentVisible (v, "wheel_rb_dummy", true)
			setVehicleComponentVisible (v, "wheel_lb_dummy", true)
		end
	end
end
addEventHandler ("onClientRender", root, show)

addCommandHandler ("changeWheel", function()
if getElementModel(getPedOccupiedVehicle(localPlayer)) == 490 then
	if getVehicleComponentVisible (getPedOccupiedVehicle(localPlayer), "bp_rf") then
		setElementData (getPedOccupiedVehicle(localPlayer), "gus", false)
	else
		setElementData (getPedOccupiedVehicle(localPlayer), "gus", true)
	end
end
end)