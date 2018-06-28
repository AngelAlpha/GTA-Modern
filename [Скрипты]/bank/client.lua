local sW,sH = guiGetScreenSize()

window = guiCreateWindow((sW - 337) / 2, (sH - 225) / 2, 337, 225, "Банк", false)
guiWindowSetSizable(window, false)

-- image = guiCreateStaticImage(0.01, 0.03, 1.99, 100, "картинка на фоне окна.jpg",true,window) 
-- guiSetAlpha(image,1) 
-- guiSetProperty(image,"Disabled","true")

tabpanel = guiCreateTabPanel(9, 23, 318, 192, false, window)
tab = guiCreateTab("Снять/Положить", tabpanel)

label_balance = guiCreateLabel(10, 10, 298, 15, "Ваш баланс в банке: 0 $.", false, tab)
label_tax = guiCreateLabel(10, 35, 298, 15, "Процент выручки: "..perchant.."%", false, tab)
label_player = guiCreateLabel(10, 60, 40, 17, "Сумма:", false, tab)

edit1 = guiCreateEdit(50, 60, 150, 21, "0", false, tab)

money_put = guiCreateButton(10, 91, 89, 24, "Положить", false, tab)
money_take = guiCreateButton(109, 91, 89, 24, "Снять", false, tab)
money_close = guiCreateButton(219, 91, 89, 24, "Закрыть", false, tab)

label_transfer = guiCreateTab("Перевести", tabpanel)

gridlist = guiCreateGridList(10, 10, 130, 148, false, label_transfer)
column = guiGridListAddColumn(gridlist, "Игрок", 0.8)

edit2 = guiCreateEdit(200, 31, 100, 21, "0", false, label_transfer)

label_player = guiCreateLabel(150, 10, 158, 17, "Выберите игрока", false, label_transfer)
label_player = guiCreateLabel(150, 31, 40, 17, "Сумма:", false, label_transfer)

money_transfer = guiCreateButton(150, 58, 158, 27, "Перевести", false, label_transfer)
money_close1 = guiCreateButton(220, 130, 89, 24, "Закрыть", false, label_transfer)  

uslugi = guiCreateTab("Услуги", tabpanel)

        panel = guiCreateScrollPane(0, 0, 310, 348, false, uslugi)
		
		label = {}
		button = {}
		
        label[1] = guiCreateLabel(2, 4, 304, 20, "------------  Коммунальные услуги  ------------", false, panel)
        label[2] = guiCreateLabel(10, 24, 226, 22, "Задолженность:", false, panel)
        edit = guiCreateEdit(58, 56, 172, 24, "", false, panel)
        label[3] = guiCreateLabel(10, 56, 48, 24, "Сумма:", false, panel)
        button[1] = guiCreateButton(10, 88, 132, 26, "Оплатить", false, panel)
        button[2] = guiCreateButton(178, 90, 132, 26, "Оплатить все", false, panel) 
		button[3] = guiCreateButton(220, 130, 89, 24, "Закрыть", false, panel)

		guiLabelSetHorizontalAlign(label[1], "center")
		guiLabelSetVerticalAlign(label[2], "center")
		guiLabelSetVerticalAlign(label[3], "center")

guiSetVisible(window,false)

addEventHandler("onClientResourceStart",resourceRoot,
function()
	for i, bank in ipairs(Banks) do
		local marker = createMarker(bank[1],bank[2],bank[3],"cylinder",1,255,0,0,70)
		setElementData(marker,"bank.marker",true,false)
	end
	
	function bankWindowClose()
		guiSetVisible(window,false)
		showCursor(false)
	end
	addEventHandler("onClientGUIClick",money_close1,bankWindowClose,false)
	addEventHandler("onClientGUIClick",money_close,bankWindowClose,false)
	addEventHandler("onClientGUIClick",button[3],bankWindowClose,false)
	
	addEventHandler("onClientGUIClick",money_put,
	function()
		local input_money = tonumber( guiGetText(edit1) )
		if input_money then
			triggerServerEvent("player:moneyPut",localPlayer,input_money)
		end
	end,false)
	
	addEventHandler("onClientGUIClick",money_take,
	function()
		local input_money = tonumber( guiGetText(edit1) )
		if input_money then
			triggerServerEvent("player:moneyTake",localPlayer,input_money)
		end
	end,false)
	
	addEventHandler("onClientGUIClick",button[1],
	function()
		local input_money = tonumber( guiGetText(edit) )
		if input_money then
			triggerServerEvent("player:moneyTakeBank",localPlayer,input_money)
		end
	end,false)
	
	addEventHandler("onClientGUIClick",button[2],
	function()
		local input_money = tonumber(getElementData (localPlayer, "Коммуналка:Дома"))
		if input_money then
			triggerServerEvent("player:moneyTakeBank",localPlayer,input_money)
		end
	end,false)
	
	addEventHandler("onClientGUIClick",money_transfer,
	function()
		local input_money = tonumber( guiGetText(edit2) )
		if input_money then
			local player = guiGridListGetItemData(gridlist,guiGridListGetSelectedItem(gridlist))
			if not player then return false end
			if not isElement(player) then return false end
			triggerServerEvent("player:moneyTransfer",localPlayer,input_money,player,string.gsub(getPlayerName(player),"#%x%x%x%x%x%x",""))
		end
	end,false)
	
	function CheckIsNumberEdit(edit)
		local chars = {}
		for i = 0, 9 do
			chars[tostring(i)] = true
		end
		local text = guiGetText(edit)
		for i = 1, string.len(text) do
			local symbol = string.sub(text,i,i)
			if not chars[symbol] then
				local text = string.gsub(text,symbol,"")
				guiSetText(edit,text)
			end
		end
	end
	addEventHandler("onClientGUIChanged",edit1,CheckIsNumberEdit)
	addEventHandler("onClientGUIChanged",edit2,CheckIsNumberEdit)
	addEventHandler("onClientGUIChanged",edit,CheckIsNumberEdit)
	
	
end)

function updateBankWindow()
	guiSetText(label_balance,"Ваш баланс равен: "..(getElementData(localPlayer,"bank.money") or 0).. "$")
	guiSetText(edit1,"0")
	guiSetText(edit2,"0")
	guiSetText(edit, "0")
	guiSetText(label[2], "Задолженность: "..(getElementData(localPlayer, "Коммуналка:Дома") or 0).. "$")
end
addEvent("updateBankWindow",true)
addEventHandler("updateBankWindow",root,updateBankWindow)

addEventHandler("onClientMarkerHit",getRootElement(),
function(player)
	if player ~= localPlayer or not getElementData(source,"bank.marker") then
		return false
	end
	updateBankWindow()
	addPlayer()
	guiSetVisible(window,true)
	showCursor(true)
end)

function addPlayer()
		local player_row = guiGridListGetSelectedItem(gridlist)
		local players = getElementsByType("player")
		guiGridListClear(gridlist)
		for i, player in ipairs(players) do
			if player ~= localPlayer then
				local row = guiGridListAddRow(gridlist)
				guiGridListSetItemText(gridlist,row,column,string.gsub(getPlayerName(player),"#%x%x%x%x%x%x",""),false,false)
				guiGridListSetItemData(gridlist,row,column,player)
			end
		end
		guiGridListSetSelectedItem(gridlist,player_row,1)
	end

addEventHandler("onClientMarkerLeave",getRootElement(),
function(player)
	if player ~= localPlayer or not getElementData(source,"bank.marker") then
		return false
	end
	guiSetVisible(window,false)
	showCursor(false)
end)


addEventHandler("onClientRender", root, function()
    local rx,ry,rz = getCameraMatrix()
    
    for i,v in ipairs(Banks) do
        local x,y,z = getElementPosition(localPlayer)
        local distance = getDistanceBetweenPoints3D(rx,ry,rz,v[1],v[2],v[3])
        if distance <= 25 then
            local sx,sy = getScreenFromWorldPosition(v[1],v[2],v[3]+1, 0.06)
            if sx and sy then
                if sx and sy then
                    dxDrawText(v[4], sx, sy, sx, sy, tocolor(0, 0, 0, 255), 2, "default", "center", "center", false, false, true, false, false)
                    dxDrawText(v[4], sx, sy-2, sx, sy-2, tocolor(0, 0, 0, 255), 2, "default", "center", "center", false, false, true, false, false)
                    dxDrawText(v[4], sx-2, sy, sx-2, sy, tocolor(0, 0, 0, 255), 2, "default", "center", "center", false, false, true, false, false)
                    dxDrawText(v[4], sx-2, sy, sx-2, sy-2, tocolor(0, 0, 0, 255), 2, "default", "center", "center", false, false, true, false, false)
                    dxDrawText(v[4], sx-1, sy-1, sx-1, sy-1, tocolor(0, 255, 0, 255), 2, "default", "center", "center", false, false, true, false, false)
                end
            end
        end
    end
end)