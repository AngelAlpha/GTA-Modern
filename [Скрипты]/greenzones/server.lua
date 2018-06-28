-- By default it adds greenzone to the Freeroam/play standard spawnpoints to prevent spawnkills, you can add greenzone areas to it using the coordinate format
-- Format is: {x = 0, y = 0, z = 0, width = 0, depth = 0, height = 0},
local greenzones = {
	{x = -2158.43213, y = -78.41707, z = -50, width = 273, depth = 393, height = 500}, -- Grove Street
	{x = -1701.71143, y = 624.26398, z = -50, width = 130, depth = 105, height = 500}, -- LV Pirate ship
	{x = 2237.08325, y = 2429.95288, z = -50, width = 57, depth = 79, height = 500}, -- Wooden house thing
	{x = 1543.27405, y = -1714.1800, z = -50, width = 65, depth = 113, height = 500}, -- San Fierro antenna thing
}

-- initialize all zones on resource start
local z = {}
function initGreenzones()
	if greenzones and #greenzones ~= 0 then
		for _,v in ipairs (greenzones) do
			if v then
				if v.x and v.y and v.z and v.width and v.depth and v.height then
					local c = createColCuboid (v.x, v.y, v.z, v.width, v.depth, v.height)
					local rarea = createRadarArea (v.x, v.y, v.width, v.depth, 0, 255, 0, 150)
					setElementParent (rarea, c)
					if c then
						z[c] = true
						for _,p in ipairs (getElementsWithinColShape(c, "player")) do
							setElementData (p, "greenzone", true)
						end
						addEventHandler ("onElementDestroy", c,
							function()
								if z[source] then
									z[source] = nil
								end
							end
						)
						addEventHandler ("onColShapeHit", c,
							function (h, d)
								if h and d and isElement(h) and getElementType (h) == "player" then
									setElementData (h, "greenzone", true)
									--outputChatBox ("* Greenzone * You have entered the greenzone", h, 0, 220, 0)
								end
							end
						)
						addEventHandler ("onColShapeLeave", c,
							function (h, d)
								if h and d and isElement(h) and getElementType (h) == "player" then
									removeElementData (h, "greenzone")
									--outputChatBox ("* Greenzone * You have left the greenzone", h, 220, 220, 0)
								end
							end
						)
					end
				end
			end
		end
	end
end
addEventHandler ("onResourceStart", resourceRoot, initGreenzones)

function resetGreenzoneData()
	for _,p in ipairs (getElementsByType("player")) do
		if isElement(p) then
			removeElementData (p, "greenzone")
		end
	end
end
addEventHandler ("onResourceStop", resourceRoot, resetGreenzoneData)