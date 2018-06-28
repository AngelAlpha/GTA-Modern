--[[
	*Scripted by ZoRRoM^.
	*ZoRRoM^ tarafından kodlanmıştır.
	*Lütfen http://mtasa-tr.com adresini ziyaret edin.
	*Please visit http://mtasa-tr.com adress.
]]

---------------------------------------------------
-- Maks - Min Karakter // Max - Min Characters
---------------------------------------------------
local fix_max_min
fix_max_min = setTimer(function()
	if login_options then
		login_options.max_character = math.max(math.min(login_options.max_character, 23), 3)
		login_options.min_character = math.min(math.max(login_options.min_character, 3), 23)
		login_options.max_character = login_options.max_character < login_options.min_character and login_options.min_character or login_options.max_character
		if isTimer(fix_max_min) then
			killTimer(fix_max_min)
			fix_max_min = nil
		end
	end
end, 500, 0)

---------------------------------------------------
-- Genel Tanımlar // Global Variables
---------------------------------------------------
screenW, screenH = guiGetScreenSize()
gMe = getLocalPlayer()

---------------------------------------------------
-- Ana Tablo // Main Table
---------------------------------------------------
local loginTbl = {
	startX = (screenW-320)/2,
	startY = (screenH-169)/2,
	
	effectPosition = {screenW/2-160, screenW/2},
	
	error = {
		text = "",
		time = 0,
		posY = -40,
		warningSpeed = 3,
		warningDuration = 6000 -- ms
	},
	
	selectedEdit = nil,
	edits = {
		login = {username = "", password = ""},
		register = {username = "", password = ""},
	},
	editRectangleTick = 0,
	backspaceTick = 0,
	tabTick = 0,
	writingTick = 0,
	
	showPass = false,
	saveUserAccountChk = false,
	
	selectedButton = "login",
	
	isPanelActive = true,
	
	sound = false
}
fadeCamera(true)

---------------------------------------------------
-- Giriş Kontrolu // Check Log In
---------------------------------------------------
function loggedin()
	return getElementData(gMe, "loggedin")
end

---------------------------------------------------
-- Ses Çalma // Play Sound
---------------------------------------------------
local do_opt
do_opt = setTimer(function()
	if login_options then
		if not loggedin() then
			if login_options.play_sound.play then
				loginTbl.sound = playSound(login_options.play_sound.sound_path, login_options.play_sound.loop, true)
			end
		end
		
		setPlayerHudComponentVisible("radar", false)
		
		if isTimer(do_opt) then
			killTimer(do_opt)
			do_opt = nil
		end
	end
end, 50, 0)

---------------------------------------------------
-- Mouse Bölgede Mi // Is Mouse On Area
---------------------------------------------------
local function isMouseWithinRangeOf(x1,y1,x2,y2,type)
	if not isCursorShowing() then
		return false
	end
	local cx,cy = getCursorPosition()
	cx,cy = cx*screenW,cy*screenH
	if cx >= x1 and cx <= (type == true and x2 + x1 or x2) and cy >= y1 and cy <= (type == true and y2 + y1 or y2) then
		return true,cx,cy
	else
		return false
	end
end

---------------------------------------------------
-- Karakter Ekleme // Add Character
---------------------------------------------------
addEventHandler("onClientCharacter", root, function(key)
	local key = key:gsub("num_", "")
	if login_options.use_only_ASCII and not (string.byte(key) > 40 and string.byte(key) < 91 or string.byte(key) > 96 and string.byte(key) < 123 or type(tonumber(key)) == "number") then return end -- Yalnızca ASCII karakter için // Only for ASCII characters
	
	loginTbl.writingTick = getTickCount()
	
	if loginTbl.selectedEdit == "login.username" then
		if string.len(loginTbl.edits.login.username) >= login_options.max_character then return end
		loginTbl.edits.login.username = loginTbl.edits.login.username..key
	elseif loginTbl.selectedEdit == "login.password" then
		if string.len(loginTbl.edits.login.password) >= login_options.max_character then return end
		loginTbl.edits.login.password = loginTbl.edits.login.password..key
	elseif loginTbl.selectedEdit == "register.username" then
		if string.len(loginTbl.edits.register.username) >= login_options.max_character then return end
		loginTbl.edits.register.username = loginTbl.edits.register.username..key
	elseif loginTbl.selectedEdit == "register.password" then
		if string.len(loginTbl.edits.register.password) >= login_options.max_character then return end
		loginTbl.edits.register.password = loginTbl.edits.register.password..key
	end
end)

---------------------------------------------------
-- Karakter Çıkarma // Remove Character
---------------------------------------------------
local function removeCharacter()
	loginTbl.writingTick = getTickCount()
	if loginTbl.selectedEdit == "login.username" then
		loginTbl.edits.login.username = string.sub(loginTbl.edits.login.username, 1, string.len(loginTbl.edits.login.username)-1)
	elseif loginTbl.selectedEdit == "login.password" then
		loginTbl.edits.login.password = string.sub(loginTbl.edits.login.password, 1, string.len(loginTbl.edits.login.password)-1)
	elseif loginTbl.selectedEdit == "register.username" then
		loginTbl.edits.register.username = string.sub(loginTbl.edits.register.username, 1, string.len(loginTbl.edits.register.username)-1)
	elseif loginTbl.selectedEdit == "register.password" then
		loginTbl.edits.register.password = string.sub(loginTbl.edits.register.password, 1, string.len(loginTbl.edits.register.password)-1)
	end
end

---------------------------------------------------
-- TAB ile atlama // Do Jump with TAB
---------------------------------------------------
local function doJump()
	loginTbl.writingTick = getTickCount()
	if loginTbl.selectedEdit == "login.username" then
		loginTbl.selectedEdit = "login.password"
	elseif loginTbl.selectedEdit == "login.password" then
		loginTbl.selectedEdit = "login.username"
	elseif loginTbl.selectedEdit == "register.username" then
		loginTbl.selectedEdit = "register.password"
	elseif loginTbl.selectedEdit == "register.password" then
		loginTbl.selectedEdit = "register.username"
	end
end

---------------------------------------------------
-- Dil Metinini Alma // Get Language Text
---------------------------------------------------
local function getText(value)
	return login_options.language[login_options.selected_language][value] or tostring(value)
end

---------------------------------------------------
-- Sistemi İşleme // Render the System
---------------------------------------------------
function renderLogin()
	if isTransferBoxActive() then return end
	if loggedin() then
		close_login()
		return
	end
	if loginTbl.isPanelActive then
		if not isCursorShowing() then
			showCursor(true)
		end
		if isChatVisible() and login_options.hide_chat then
			showChat(false)
		end
		if loginTbl.selectedEdit then
			if guiGetInputMode() ~= "no_binds" then
				guiSetInputMode("no_binds")
			end
		else
			guiSetInputMode("allow_binds")
		end
	end
	if login_options.use_backround_image then
		if screenW/screenH >= 1.6 then
			dxDrawImage(0, 0, screenW, screenH, "images/background.jpg", 0,0,0, tocolor(255,255,255,255), login_options.postGUI)
		else
			local width = screenH*1.77
			startX = (screenW - width)/2
			dxDrawImage(startX, 0, width, screenH, "images/background.jpg", 0,0,0, tocolor(255,255,255,255), login_options.postGUI)
		end
	end
	
	---------------------------------------------------
	-- Kamera Pozisyonu // Camera Position
	---------------------------------------------------
	if login_options.set_camera_position.active_camera then
		setCameraMatrix(unpack(login_options.set_camera_position.position))
	end
	
	---------------------------------------------------
	-- Bar
	---------------------------------------------------
	dxDrawRectangle(loginTbl.startX, loginTbl.startY, 320, 31, tocolor(0, 0, 0, 180), login_options.postGUI)
	dxDrawLine(loginTbl.startX, loginTbl.startY, loginTbl.startX+320, loginTbl.startY, tocolor(255, 255, 255, 255), 2, login_options.postGUI)
	dxDrawLine(loginTbl.startX, loginTbl.startY+31, loginTbl.startX+320, loginTbl.startY+31, tocolor(255, 255, 255, 255), 2, login_options.postGUI)
	
	local color = login_options.theme_color
	color[4] = 255
	color = tocolor(unpack(color))
	
	local onButton = isMouseWithinRangeOf(loginTbl.startX, loginTbl.startY, 160, 30, true) and "login" or isMouseWithinRangeOf(loginTbl.startX+160, loginTbl.startY, 160, 30, true) and "register"
	
	dxDrawText(getText(1), loginTbl.startX, loginTbl.startY, loginTbl.startX+160, loginTbl.startY+30, onButton == "login" and color or loginTbl.selectedButton == "login" and color or tocolor(255, 255, 255, 255), login_options.font_opt.scale, login_options.font_opt.font, "center", "center", false, false, login_options.postGUI, false, false)
	dxDrawText(getText(2), loginTbl.startX+160, loginTbl.startY, loginTbl.startX+320, loginTbl.startY+30, onButton == "register" and color or loginTbl.selectedButton == "register" and color or tocolor(255, 255, 255, 255), login_options.font_opt.scale, login_options.font_opt.font, "center", "center", false, false, login_options.postGUI, false, false)
	
	---------------------------------------------------
	-- Efekt // Effect
	---------------------------------------------------
	local s = loginTbl.effectPosition
	for i=1,login_options.effect_speed do
		if loginTbl.selectedButton == "login" then
			local firstBar = loginTbl.startX < s[1] and true or false
			if firstBar then
				s[1] = s[1] < loginTbl.startX and s[1] + 1 or s[1] > loginTbl.startX and s[1] - 1 or s[1]
				s[2] = s[1] == loginTbl.startX and (s[2] < loginTbl.startX+160 and s[2] + 1 or s[2] > loginTbl.startX+160 and s[2] - 1) or s[2]
			else
				s[1] = s[2] == loginTbl.startX+160 and (s[1] < loginTbl.startX and s[1] + 1 or s[1] > loginTbl.startX and s[1] - 1) or s[1]
				s[2] = s[2] < loginTbl.startX+160 and s[2] + 1 or s[2] > loginTbl.startX+160 and s[2] - 1 or s[2]
			end
		elseif loginTbl.selectedButton == "register" then
			local firstBar = loginTbl.startX+160 < s[1] and true or false
			if firstBar then
				s[1] = s[1] < loginTbl.startX+160 and s[1] + 1 or s[1] > loginTbl.startX+160 and s[1] - 1 or s[1]
				s[2] = s[1] == loginTbl.startX+160 and (s[2] < loginTbl.startX+320 and s[2] + 1 or s[2] > loginTbl.startX+320 and s[2] - 1) or s[2]
			else
				s[1] = s[2] == loginTbl.startX+320 and (s[1] < loginTbl.startX+160 and s[1] + 1 or s[1] > loginTbl.startX+160 and s[1] - 1) or s[1]
				s[2] = s[2] < loginTbl.startX+320 and s[2] + 1 or s[2] > loginTbl.startX+320 and s[2] - 1 or s[2]
			end
		end
	end
	dxDrawLine(s[1], loginTbl.startY, s[2], loginTbl.startY, color, 2, login_options.postGUI)
	dxDrawLine(s[1], loginTbl.startY+31, s[2], loginTbl.startY+31, color, 2, login_options.postGUI)
	
	---------------------------------------------------
	-- Seçilmiş Buton İşlevleri // Selected Button Functions
	---------------------------------------------------
	local inLogRegButton = isMouseWithinRangeOf(loginTbl.startX+92, loginTbl.startY+140, 124, 20, true)
	loginTbl.showPassButton = {loginTbl.startX+290, loginTbl.startY+109, 18, 18, true}
	loginTbl.showPass = isMouseWithinRangeOf(unpack(loginTbl.showPassButton)) and getKeyState("mouse1") or false
	
	if loginTbl.selectedButton == "login" then
		dxDrawRectangle(loginTbl.startX, loginTbl.startY+35, 320, 134, tocolor(0, 0, 0, 180), login_options.postGUI)
		
		dxDrawText(getText(3), loginTbl.startX+10, loginTbl.startY+42, loginTbl.startX+296, loginTbl.startY+57, tocolor(255, 255, 255, 255), login_options.font_opt.scale, login_options.font_opt.font, "center", "top", false, false, login_options.postGUI, false, false)
		dxDrawRectangle(loginTbl.startX+10, loginTbl.startY+60, 300, 22, tocolor(255, 255, 255, 200), login_options.postGUI)
		dxDrawText(loginTbl.edits.login.username, loginTbl.startX+20, loginTbl.startY+60, loginTbl.startX+296, loginTbl.startY+82, tocolor(0, 0, 0, 255), login_options.font_opt.scale, login_options.font_opt.font, "left", "center", false, false, login_options.postGUI, false, false)
			
		dxDrawText(getText(4), loginTbl.startX+10, loginTbl.startY+89, loginTbl.startX+296, loginTbl.startY+104, tocolor(255, 255, 255, 255), login_options.font_opt.scale, login_options.font_opt.font, "center", "top", false, false, login_options.postGUI, false, false)
		dxDrawRectangle(loginTbl.startX+10, loginTbl.startY+107, 300, 22, tocolor(255, 255, 255, 200), login_options.postGUI)
		dxDrawText(loginTbl.showPass and loginTbl.edits.login.password or string.rep("*", #loginTbl.edits.login.password), loginTbl.startX+20, loginTbl.startY+107, loginTbl.startX+296, loginTbl.startY+129, tocolor(0, 0, 0, 255), login_options.font_opt.scale, login_options.font_opt.font, "left", "center", false, false, login_options.postGUI, false, false)
			
		local x, y, w, h = unpack(loginTbl.showPassButton)
		local showPassRectangle = loginTbl.showPass and tocolor(0, 0, 0, 200) or tocolor(0, 0, 0, 0)
		dxDrawRectangle(x-2, y-2, w+4, h+4, showPassRectangle, login_options.postGUI)

		local showPassImage = loginTbl.showPass and tocolor(255, 255, 255, 255) or isMouseWithinRangeOf(x, y, w, h, true) and color or tocolor(0, 0, 0, 255)
		dxDrawImage(x, y, w, h, "images/password.png", 0, 0, 0, showPassImage, login_options.postGUI)
		
		dxDrawRectangle(loginTbl.startX+98, loginTbl.startY+139, 124, 20, tocolor(login_options.theme_color[1], login_options.theme_color[2], login_options.theme_color[3], 200), login_options.postGUI)
		dxDrawText(getText(1), loginTbl.startX+99, loginTbl.startY+140, loginTbl.startX+223, loginTbl.startY+160, tocolor(0, 0, 0, inLogRegButton and 180 or 255), login_options.font_opt.scale, login_options.font_opt.font, "center", "center", false, false, login_options.postGUI, false, false)
		dxDrawText(getText(1), loginTbl.startX+98, loginTbl.startY+139, loginTbl.startX+222, loginTbl.startY+159, tocolor(255, 255, 255, inLogRegButton and 180 or 255), login_options.font_opt.scale, login_options.font_opt.font, "center", "center", false, false, login_options.postGUI, false, false)
		
		local color = isMouseWithinRangeOf(loginTbl.startX+10, loginTbl.startY+140, 58, 15, true) and color or tocolor(255, 255, 255, 200)
		dxDrawText(getText(10), loginTbl.startX+30, loginTbl.startY+140, loginTbl.startX+68, loginTbl.startY+155, color, login_options.font_opt.scale, login_options.font_opt.font, "left", "center", true, false, login_options.postGUI, false, false)
		dxDrawRectangle(loginTbl.startX+10, loginTbl.startY+140, 15, 15, tocolor(255, 255, 255, 200), login_options.postGUI)
		if loginTbl.saveUserAccountChk then
			dxDrawImage(loginTbl.startX+11, loginTbl.startY+141, 13, 13, "images/checkbox.png", 0, 0, 0, tocolor(0, 0, 0, 200), login_options.postGUI)
		end

	elseif loginTbl.selectedButton == "register" then
		dxDrawRectangle(loginTbl.startX, loginTbl.startY+35, 320, 134, tocolor(0, 0, 0, 180), login_options.postGUI)
		
		dxDrawText(getText(3), loginTbl.startX+10, loginTbl.startY+42, loginTbl.startX+296, loginTbl.startY+57, tocolor(255, 255, 255, 255), login_options.font_opt.scale, login_options.font_opt.font, "center", "top", false, false, login_options.postGUI, false, false)
		dxDrawRectangle(loginTbl.startX+10, loginTbl.startY+60, 300, 22, tocolor(255, 255, 255, 200), login_options.postGUI)
		dxDrawText(loginTbl.edits.register.username, loginTbl.startX+20, loginTbl.startY+60, loginTbl.startX+296, loginTbl.startY+82, tocolor(0, 0, 0, 255), login_options.font_opt.scale, login_options.font_opt.font, "left", "center", false, false, login_options.postGUI, false, false)
			
		dxDrawText(getText(4), loginTbl.startX+10, loginTbl.startY+89, loginTbl.startX+296, loginTbl.startY+104, tocolor(255, 255, 255, 255), login_options.font_opt.scale, login_options.font_opt.font, "center", "top", false, false, login_options.postGUI, false, false)
		dxDrawRectangle(loginTbl.startX+10, loginTbl.startY+107, 300, 22, tocolor(255, 255, 255, 200), login_options.postGUI)
		dxDrawText(loginTbl.showPass and loginTbl.edits.register.password or string.rep("*", #loginTbl.edits.register.password), loginTbl.startX+20, loginTbl.startY+107, loginTbl.startX+296, loginTbl.startY+129, tocolor(0, 0, 0, 255), login_options.font_opt.scale, login_options.font_opt.font, "left", "center", false, false, login_options.postGUI, false, false)
			
		local x, y, w, h = unpack(loginTbl.showPassButton)
		local showPassRectangle = loginTbl.showPass and tocolor(0, 0, 0, 200) or tocolor(0, 0, 0, 0)
		dxDrawRectangle(x-2, y-2, w+4, h+4, showPassRectangle, login_options.postGUI)

		local showPassImage = loginTbl.showPass and tocolor(111, 111, 255, 255) or isMouseWithinRangeOf(x, y, w, h, true) and color or tocolor(0, 0, 0, 255)
		dxDrawImage(x, y, w, h, "images/password.png", 0, 0, 0, showPassImage)
		
		dxDrawRectangle(loginTbl.startX+98, loginTbl.startY+139, 124, 20, tocolor(login_options.theme_color[1], login_options.theme_color[2], login_options.theme_color[3], 200), login_options.postGUI)
		dxDrawText(getText(2), loginTbl.startX+99, loginTbl.startY+140, loginTbl.startX+223, loginTbl.startY+160, tocolor(0, 0, 0, inLogRegButton and 180 or 255), login_options.font_opt.scale, login_options.font_opt.font, "center", "center", false, false, login_options.postGUI, false, false)
		dxDrawText(getText(2), loginTbl.startX+98, loginTbl.startY+139, loginTbl.startX+222, loginTbl.startY+159, tocolor(255, 255, 255, inLogRegButton and 180 or 255), login_options.font_opt.scale, login_options.font_opt.font, "center", "center", false, false, login_options.postGUI, false, false)
	end
	
	--dxDrawText("Scripted by\nZoR#26782aRoM^", loginTbl.startX+315, loginTbl.startY+139, loginTbl.startX+315, loginTbl.startY+159, tocolor(255, 255, 255, 255), (login_options.font_opt.scale/10)*8, login_options.font_opt.font, "right", "center", false, false, login_options.postGUI, true, false)
	
	---------------------------------------------------
	-- Uyarı // Warning
	---------------------------------------------------
	if loginTbl.error.time - getTickCount() > 0 then
		loginTbl.error.posY = loginTbl.error.posY + loginTbl.error.warningSpeed < 0 and loginTbl.error.posY + loginTbl.error.warningSpeed or 0
	else
		loginTbl.error.posY = loginTbl.error.posY - loginTbl.error.warningSpeed > -40 and loginTbl.error.posY - loginTbl.error.warningSpeed or -40
	end
	dxDrawRectangle(0, loginTbl.error.posY, screenW, 40*login_options.font_opt.scale, tocolor(0, 0, 0, 180), login_options.postGUI)
	dxDrawText(loginTbl.error.text, 10, loginTbl.error.posY, screenW-10, loginTbl.error.posY+40*login_options.font_opt.scale, tocolor(255, 255, 255, 255), login_options.font_opt.scale, login_options.font_opt.font, "center", "center", false, true, login_options.postGUI, false, false)
	
	---------------------------------------------------
	-- Karakter Çıkarma // Remove Character
	---------------------------------------------------
	if getKeyState("backspace") then
		if loginTbl.backspaceTick then
			if getTickCount() - loginTbl.backspaceTick > 500 then
				removeCharacter()
			end
		else
			loginTbl.backspaceTick = getTickCount()
			removeCharacter()
		end
	else
		loginTbl.backspaceTick = false
	end
	
	---------------------------------------------------
	-- TAB ile atlama // Do Jump with TAB
	---------------------------------------------------
	if getKeyState("tab") then
		if loginTbl.tabTick then
			if getTickCount() - loginTbl.tabTick > 500 then
				doJump()
			end
		else
			loginTbl.tabTick = getTickCount()
			doJump()
		end
	else
		loginTbl.tabTick = false
	end
	
	---------------------------------------------------
	-- Metnin Çizgisi // Text's Line
	---------------------------------------------------
	if 1000 - getTickCount() + loginTbl.writingTick < 0 then
		if getTickCount() - loginTbl.editRectangleTick > 650 and getTickCount() - loginTbl.editRectangleTick < 1300 then
			return
		elseif getTickCount() - loginTbl.editRectangleTick > 1300 then
			loginTbl.editRectangleTick = getTickCount()
		end
	else
		loginTbl.editRectangleTick = getTickCount()-650
	end
	if loginTbl.selectedEdit == "login.username" then
		dxDrawRectangle(loginTbl.startX+21+dxGetTextWidth(loginTbl.edits.login.username, login_options.font_opt.scale, login_options.font_opt.font), loginTbl.startY+62, 2, 18, tocolor(0, 0, 0, 200), login_options.postGUI)
	elseif loginTbl.selectedEdit == "login.password" then
		dxDrawRectangle(loginTbl.startX+21+dxGetTextWidth(loginTbl.showPass and loginTbl.edits.login.password or string.rep("*", #loginTbl.edits.login.password), login_options.font_opt.scale, login_options.font_opt.font), loginTbl.startY+109, 2, 18, tocolor(0, 0, 0, 200), login_options.postGUI)
	elseif loginTbl.selectedEdit == "register.username" then
		dxDrawRectangle(loginTbl.startX+21+dxGetTextWidth(loginTbl.edits.register.username, login_options.font_opt.scale, login_options.font_opt.font), loginTbl.startY+62, 2, 18, tocolor(0, 0, 0, 200), login_options.postGUI)
	elseif loginTbl.selectedEdit == "register.password" then
		dxDrawRectangle(loginTbl.startX+21+dxGetTextWidth(loginTbl.showPass and loginTbl.edits.register.password or string.rep("*", #loginTbl.edits.register.password), login_options.font_opt.scale, login_options.font_opt.font), loginTbl.startY+109, 2, 18, tocolor(0, 0, 0, 200), login_options.postGUI)
	end
end
addEventHandler("onClientRender", root, renderLogin)

---------------------------------------------------
-- Uyarı // Warning
---------------------------------------------------
addEvent("setInfoText", true)
local function setInfoText(value, time)
	loginTbl.error.text = getText(value):format(login_options.min_character)
	loginTbl.error.time = getTickCount() + (time or loginTbl.error.warningDuration)
end
addEventHandler("setInfoText", root, setInfoText)

---------------------------------------------------
-- Tıklama // Click
---------------------------------------------------
addEventHandler("onClientClick", root, function(button, state, absoluteX, absoluteY)
	if not loginTbl.isPanelActive then return end
	if button ~= "left" then return end
	if state ~= "down" then return end
	if isMouseWithinRangeOf(loginTbl.startX+10, loginTbl.startY+140, 58, 15, true) then
		loginTbl.saveUserAccountChk = not loginTbl.saveUserAccountChk
	end
	
	loginTbl.selectedButton = isMouseWithinRangeOf(loginTbl.startX, loginTbl.startY, 160, 30, true) and "login" or isMouseWithinRangeOf(loginTbl.startX+160, loginTbl.startY, 160, 30, true) and "register" or loginTbl.selectedButton
	
	loginTbl.selectedEdit = false
	if isMouseWithinRangeOf(loginTbl.startX+10, loginTbl.startY+60, 286, 22, true) then
		loginTbl.selectedEdit = loginTbl.selectedButton..".username"
		loginTbl.editRectangleTick = getTickCount()
	elseif isMouseWithinRangeOf(loginTbl.startX+10, loginTbl.startY+107, 286, 22, true) then
		loginTbl.selectedEdit = loginTbl.selectedButton..".password"
		loginTbl.editRectangleTick = getTickCount()
	elseif isMouseWithinRangeOf(loginTbl.startX+91, loginTbl.startY+139, 124, 20, true) then
		if loginTbl.selectedButton == "register" and (#loginTbl.edits.register.username < login_options.min_character or #loginTbl.edits.register.password < login_options.min_character) then
			setInfoText(8)
			return
		end
		if loginTbl.selectedButton == "register" then
			triggerServerEvent("onAccountManage", localPlayer, loginTbl.selectedButton, loginTbl.edits.register.username, loginTbl.edits.register.password, login_options.login)
		else
			triggerServerEvent("onAccountManage", localPlayer, loginTbl.selectedButton, loginTbl.edits.login.username, loginTbl.edits.login.password, loginTbl.saveUserAccountChk)
		end
	end
end)

---------------------------------------------------
-- Kullanıcı Adı/Şifre Kaydetme // Save Username/Password
---------------------------------------------------
function loadLoginFromXML()
	local userDataXML = xmlLoadFile ("user.xml")
    if not userDataXML then
        userDataXML = xmlCreateFile("user.xml", "login")
    end
    local usernameNode = xmlFindChild (userDataXML, "username", 0)
    local passwordNode = xmlFindChild (userDataXML, "password", 0)
    if usernameNode and passwordNode then
        return xmlNodeGetValue(usernameNode), xmlNodeGetValue(passwordNode)
    else
		return "", ""
    end
    xmlUnloadFile ( userDataXML )
end

local username, password = loadLoginFromXML()
if username ~= "" or password ~= "" then
	loginTbl.saveUserAccountChk = true
	loginTbl.edits.login.username = tostring(username)
	loginTbl.edits.login.password = tostring(password)
end

addEvent("saveLoginToXML", true)
function saveLoginToXML(username, password)
    local userDataXML = xmlLoadFile("user.xml")
    if not userDataXML then
        userDataXML = xmlCreateFile("user.xml", "login")
    end
	if username ~= "" then
		local usernameNode = xmlFindChild(userDataXML, "username", 0)
		if not usernameNode then
			usernameNode = xmlCreateChild(userDataXML, "username")
		end
		xmlNodeSetValue(usernameNode, tostring(username))
	end
	if password ~= "" then
		local passwordNode = xmlFindChild(userDataXML, "password", 0)
		if not passwordNode then
			passwordNode = xmlCreateChild(userDataXML, "password")
		end		
		xmlNodeSetValue(passwordNode, tostring(password))
	end
    xmlSaveFile(userDataXML)
	xmlUnloadFile(userDataXML)
end
addEventHandler("saveLoginToXML", getRootElement(), saveLoginToXML)

addEvent("resetSaveXML", true)
function resetSaveXML()
	local userDataXML = xmlLoadFile("user.xml")
	if not userDataXML then
		userDataXML = xmlCreateFile("user.xml", "login")
	end
	if username ~= "" then
		local usernameNode = xmlFindChild(userDataXML, "username", 0)
		if not usernameNode then
			usernameNode = xmlCreateChild(userDataXML, "username")
		end
	end
	if password ~= "" then
		local passwordNode = xmlFindChild (userDataXML, "password", 0)
		if not passwordNode then
			passwordNode = xmlCreateChild(userDataXML, "password")
		end		
		xmlNodeSetValue(passwordNode, "")
	end
	xmlSaveFile(userDataXML)
	xmlUnloadFile(userDataXML)
end
addEventHandler("resetSaveXML", getRootElement(), resetSaveXML)

---------------------------------------------------
-- Sistemi Kapatma // Close System
---------------------------------------------------
function close_login()
	removeEventHandler("onClientRender", root, renderLogin)
	loginTbl.isPanelActive = false
	showCursor(false)
	guiSetInputMode("allow_binds")
	setTimer(setPlayerHudComponentVisible,100,1,"radar", false)
	
	if login_options.set_camera_position.set_camera_target then
		setCameraTarget(gMe)
	end
	
	if login_options.hide_chat then
		showChat(true)
	end
	if isElement(loginTbl.sound) and login_options.play_sound.stop_sound then
		stopSound(loginTbl.sound)
	end
end
addEvent("closeLogin", true)
addEventHandler("closeLogin", root, close_login)