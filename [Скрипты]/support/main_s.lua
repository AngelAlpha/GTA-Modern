local supportsTable = {
	["hub_rf"] = "wheel_rf_dummy",
	["hub_lf"] = "wheel_lf_dummy",
	["hub_rr"] = "wheel_rb_dummy",
	["hub_lr"] = "wheel_lb_dummy"
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
				-- Регулируем позицию суппортов относительно колеса
				local dX, dY, dZ = getVehicleComponentPosition(v, dummy, "parent")
				local sX, sY, sZ = getVehicleComponentPosition(v, support, "parent")
				if sX and sY and dZ then
					setVehicleComponentPosition(v, support, sX, sY, dZ, "parent")
				end
			end
		end
	end
end)