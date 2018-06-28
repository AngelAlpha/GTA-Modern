local sx, sy = guiGetScreenSize()
local skinShopTable = { 
	-- Binco
	[1] = { ID = {
		{103, 500},
		{21, 1000},
		{22, 1500},
		{20, 2000},
		{11, 2500},
		{1, 3000},
		{2, 3500},
		{12, 4000},
		{15, 4500},
		{17, 5000},
		{9, 5500},
		{19, 6000},
		{18, 6500},
		{44, 7000},
		{106, 7500},
		{107, 8000},
		{29, 8500},
		{28, 9000},
		{60, 9500},
		{7, 9500},
	},vPosX = 218, vPosY = -101, vPosZ = 1005, vRot = 90, PosX = 207.5, PosY = -101, PosZ = 1005, dim = 3, int = 15, CamX = 214, CamY = -101, CamZ = 1006, lookAtX = 225, lookAtY = -101, lookAtZ = 1005},
	[2] = { ID = {
		{103, 500},
		{21, 1000},
		{22, 1500},
		{20, 2000},
		{11, 2500},
		{1, 3000},
		{2, 3500},
		{12, 4000},
		{15, 4500},
		{17, 5000},
		{9, 5500},
		{19, 6000},
		{18, 6500},
		{44, 7000},
		{106, 7500},
		{107, 8000},
		{29, 8500},
		{28, 9000},
		{60, 9500},
		{7, 9500},
	},vPosX = 218, vPosY = -101, vPosZ = 1005, vRot = 90, PosX = 207.5, PosY = -101, PosZ = 1005, dim = 2, int = 15, CamX = 214, CamY = -101, CamZ = 1006, lookAtX = 225, lookAtY = -101, lookAtZ = 1005},
	[3] = { ID = {
		{103, 500},
		{21, 1000},
		{22, 1500},
		{20, 2000},
		{11, 2500},
		{1, 3000},
		{2, 3500},
		{12, 4000},
		{15, 4500},
		{17, 5000},
		{9, 5500},
		{19, 6000},
		{18, 6500},
		{44, 7000},
		{106, 7500},
		{107, 8000},
		{29, 8500},
		{28, 9000},
		{60, 9500},
		{7, 9500},
	},vPosX = 218, vPosY = -101, vPosZ = 1005, vRot = 90, PosX = 207.5, PosY = -101, PosZ = 1005, dim = 1, int = 15, CamX = 214, CamY = -101, CamZ = 1006, lookAtX = 225, lookAtY = -101, lookAtZ = 1005},
	-- Zip
	[4] = { ID = {
	{103, 500},
		{21, 1000},
		{22, 1500},
		{20, 2000},
		{11, 2500},
		{1, 3000},
		{2, 3500},
		{12, 4000},
		{15, 4500},
		{17, 5000},
		{9, 5500},
		{19, 6000},
		{18, 6500},
		{44, 7000},
		{106, 7500},
		{107, 8000},
		{29, 8500},
		{28, 9000},
		{60, 9500},
		{7, 9500},
	},vPosX = 181, vPosY = -88, vPosZ = 1002, vRot = 90, PosX = 161.2, PosY = -84, PosZ = 1001.5, dim = 3, int = 18, CamX = 176, CamY = -88, CamZ = 1003, lookAtX = 225, lookAtY = -88, lookAtZ = 1001.5},
	[5] = { ID = {
	{103, 500},
		{21, 1000},
		{22, 1500},
		{20, 2000},
		{11, 2500},
		{1, 3000},
		{2, 3500},
		{12, 4000},
		{15, 4500},
		{17, 5000},
		{9, 5500},
		{19, 6000},
		{18, 6500},
		{44, 7000},
		{106, 7500},
		{107, 8000},
		{29, 8500},
		{28, 9000},
		{60, 9500},
		{7, 9500},
	},vPosX = 218, vPosY = -101, vPosZ = 1005, vRot = 90, PosX = 207.5, PosY = -101, PosZ = 1005, dim = 0, int = 15, CamX = 214, CamY = -101, CamZ = 1006, lookAtX = 225, lookAtY = -101, lookAtZ = 1005},
	[6] = { ID = {
		{103, 500},
		{21, 1000},
		{22, 1500},
		{20, 2000},
		{11, 2500},
		{1, 3000},
		{2, 3500},
		{12, 4000},
		{15, 4500},
		{17, 5000},
		{9, 5500},
		{19, 6000},
		{18, 6500},
		{44, 7000},
		{106, 7500},
		{107, 8000},
		{29, 8500},
		{28, 9000},
		{60, 9500},
		{7, 9500},
	},vPosX = 181, vPosY = -88, vPosZ = 1002, vRot = 90, PosX = 161.2, PosY = -84, PosZ = 1001.5, dim = 2, int = 18, CamX = 176, CamY = -88, CamZ = 1003, lookAtX = 225, lookAtY = -88, lookAtZ = 1001.5},
	[7] = { ID = {
		{103, 500},
		{21, 1000},
		{22, 1500},
		{20, 2000},
		{11, 2500},
		{1, 3000},
		{2, 3500},
		{12, 4000},
		{15, 4500},
		{17, 5000},
		{9, 5500},
		{19, 6000},
		{18, 6500},
		{44, 7000},
		{106, 7500},
		{107, 8000},
		{29, 8500},
		{28, 9000},
		{60, 9500},
		{7, 9500},
	},vPosX = 181, vPosY = -88, vPosZ = 1002, vRot = 90, PosX = 161.2, PosY = -84, PosZ = 1001.5, dim = 0, int = 18, CamX = 176, CamY = -88, CamZ = 1003, lookAtX = 225, lookAtY = -88, lookAtZ = 1001.5},
	[8] = { ID = {
		{103, 500},
		{21, 1000},
		{22, 1500},
		{20, 2000},
		{11, 2500},
		{1, 3000},
		{2, 3500},
		{12, 4000},
		{15, 4500},
		{17, 5000},
		{9, 5500},
		{19, 6000},
		{18, 6500},
		{44, 7000},
		{106, 7500},
		{107, 8000},
		{29, 8500},
		{28, 9000},
		{60, 9500},
		{7, 9500},
	},vPosX = 181, vPosY = -88, vPosZ = 1002, vRot = 90, PosX = 161.2, PosY = -84, PosZ = 1001.5, dim = 1, int = 18, CamX = 176, CamY = -88, CamZ = 1003, lookAtX = 225, lookAtY = -88, lookAtZ = 1001.5},
	-- Victim
	[9] = { ID = {
		{103, 500},
		{21, 1000},
		{22, 1500},
		{20, 2000},
		{11, 2500},
		{1, 3000},
		{2, 3500},
		{12, 4000},
		{15, 4500},
		{17, 5000},
		{9, 5500},
		{19, 6000},
		{18, 6500},
		{44, 7000},
		{106, 7500},
		{107, 8000},
		{29, 8500},
		{28, 9000},
		{60, 9500},
		{7, 9500},
	},vPosX = 225, vPosY = -11.5, vPosZ = 1002, vRot = 0, PosX = 217, PosY = -8.9, PosZ = 1001.3, dim = 1, int = 5, CamX = 225, CamY = -6, CamZ = 1003, lookAtX = 225, lookAtY = -90, lookAtZ = 1006},
	-- Ds
	[10] = { ID = {
		{103, 500},
		{21, 1000},
		{22, 1500},
		{20, 2000},
		{11, 2500},
		{1, 3000},
		{2, 3500},
		{12, 4000},
		{15, 4500},
		{17, 5000},
		{9, 5500},
		{19, 6000},
		{18, 6500},
		{44, 7000},
		{106, 7500},
		{107, 8000},
		{29, 8500},
		{28, 9000},
		{60, 9500},
		{7, 9500},
	},vPosX = 208, vPosY = -156, vPosZ = 1000, vRot = 180, PosX = 204, PosY = -160, PosZ = 1000.5, dim = 0, int = 14, CamX = 208, CamY = -161, CamZ = 1001, lookAtX = 209, lookAtY = -80, lookAtZ = 1005},
}

for i, M in ipairs(skinShopTable) do
	pickupSkin = createPickup ( M["PosX"], M["PosY"], M["PosZ"], 3, 1275, 1000 )
	setElementDimension (pickupSkin, M["dim"])
	setElementInterior (pickupSkin, M["int"])
	setElementID(pickupSkin, tostring(i))
end

addEventHandler ("onClientPickupHit", getRootElement(), function(player)
	if player ~= localPlayer then return true end
	i = tonumber(getElementID(source))
	numberSkin = 1
	numberSkinMax = table.maxn(skinShopTable[i]["ID"])
	price = tostring (skinShopTable[i]["ID"][numberSkin][2])
	skinShowPed ( numberSkin )
	setCameraMatrix(skinShopTable[i]["CamX"], skinShopTable[i]["CamY"], skinShopTable[i]["CamZ"], skinShopTable[i]["lookAtX"], skinShopTable[i]["lookAtY"], skinShopTable[i]["lookAtZ"])
	-- GUI
	windowSkin = guiCreateWindow ( (sx-300)/2, sy-90, 300, 80, "Цена: "..price.."$", false )
	guiWindowSetSizable ( windowSkin, false )
	guiWindowSetMovable ( windowSkin, false )
	button_prev = guiCreateButton( 10, 25, 40, 70, "<", false, windowSkin )
	guiSetProperty( button_prev, "NormalTextColour", "ffff9000" )
	guiSetFont(button_prev,"sa-header")
	button_next = guiCreateButton( 250, 25, 40, 70, ">", false, windowSkin )
	guiSetProperty( button_next, "NormalTextColour", "ffff9000" )
	guiSetFont(button_next,"sa-header")
	button_buy = guiCreateButton( 155, 25, 90, 70, "Купить", false, windowSkin )
	guiSetProperty( button_buy, "NormalTextColour", "ffffffff" )
	button_out = guiCreateButton( 55, 25, 90, 70, "Выйти", false, windowSkin )
	guiSetProperty( button_out, "NormalTextColour", "ffffffff" )
	showCursor (true)
end)

addEventHandler("onClientGUIClick", getRootElement(), function()
	if isElement (windowSkin) then
		if source == button_out then
			destroyElement (windowSkin)
			showCursor (false)
			setCameraTarget(getLocalPlayer(),getLocalPlayer())
			if skinPedLook then
				destroyElement (skinPedLook)
			end
		elseif source == button_next then
			numberSkin = numberSkin + 1
			if numberSkin > numberSkinMax then
				numberSkin = 1
			end	
			price = skinShopTable[i]["ID"][numberSkin][2]
			skinShowPed ( numberSkin )
			guiSetText ( windowSkin, "Цена: "..price.."$" )
		elseif source == button_prev then
			numberSkin = numberSkin - 1
			if numberSkin == 0 then
				numberSkin = numberSkinMax
			end	
			price = skinShopTable[i]["ID"][numberSkin][2]
			skinShowPed ( numberSkin )
			guiSetText ( windowSkin, "Цена: "..price.."$" )
		elseif source == button_buy then
			destroyElement (windowSkin)
			showCursor (false)
			setCameraTarget(getLocalPlayer(),getLocalPlayer())
			if skinPedLook then
				destroyElement (skinPedLook)
			end
			id = skinShopTable[i]["ID"][numberSkin][1]
			price = skinShopTable[i]["ID"][numberSkin][2]
			triggerServerEvent("onPlayerSkinChange", getLocalPlayer(), id, price)
		end
	end
end)

function skinShowPed ( numberSkin )
	if isElement (skinPedLook) then
		destroyElement (skinPedLook)
	end
	skinPedLook = createPed ( skinShopTable[i]["ID"][numberSkin][1], skinShopTable[i]["vPosX"], skinShopTable[i]["vPosY"], skinShopTable[i]["vPosZ"], skinShopTable[i]["vRot"] )
	setElementDimension (skinPedLook, skinShopTable[i]["dim"])
	setElementInterior (skinPedLook, skinShopTable[i]["int"])
end


