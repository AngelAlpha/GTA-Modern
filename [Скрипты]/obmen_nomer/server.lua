createBlip (752.83362, -1351.79724, 12.9690, 16, 2)

function addTransfer(targetPlayer)
	local sVeh = getPedOccupiedVehicle(source)
	local tVeh = getPedOccupiedVehicle(targetPlayer)

	if isElement(getElementData(targetPlayer,'_exchangeParent')) then
		outputChatBox('Ошибка: Этот игрок уже обменивается',source,255,0,0)
		return
	end
	if isElement(getElementData(source,'_exchangeParent')) then
		outputChatBox('Ошибка: Вы уже обмениваетесь',source,255,0,0)
		return
	end

	setElementData(targetPlayer,'_exchangeParent',source)
	setElementData(source,'_exchangeParent',targetPlayer)

	outputChatBox("Игрок '"..utf8.gsub(getPlayerName(source), "#%x%x%x%x%x%x", "").."' Предложил обменяться номерами. Нажмите 'O' чтобы начать обмен, 'N' чтобы отклонить.",targetPlayer,255,150,0)
	bindKey (targetPlayer, "n", "down", reject)
	bindKey (targetPlayer, "o", "down", getMoreInfo)
end
addEvent('addTransfer',true)
addEventHandler('addTransfer',root,addTransfer)


function setStatusToReady()
	setElementData(source,'_exchangeState',1)

	local parent = getElementData(source,'_exchangeParent')
	triggerClientEvent(parent,'refreshTransferInfo',parent)
	triggerClientEvent(source,'refreshTransferInfo',source)
end

function refreshTransferInfo()
	local parent = getElementData(source,'_exchangeParent')
	triggerClientEvent(parent,'refreshTransferInfo',parent)
	triggerClientEvent(source,'refreshTransferInfo',source)
end
addEvent('refreshTransferInfo',true)
addEventHandler('refreshTransferInfo',root,refreshTransferInfo)

function reject(targetPlayer)
	local transferer = getElementData(targetPlayer,'_exchangeParent')
	if isElement(transferer) then
		outputChatBox('Игрок '..utf8.gsub(getPlayerName(targetPlayer), "#%x%x%x%x%x%x", "")..' Отказался от сделки.',transferer, 255,0,0)
		setElementData(transferer, '_exchangeParent',nil)
		setElementData(targetPlayer,'_exchangeParent',nil)
		triggerClientEvent(targetPlayer,'hideWindows',targetPlayer)
		triggerClientEvent(transferer,'hideWindows',transferer)
		unbindKey (targetPlayer, "n", "down", reject)
	end
end
addEvent('reject',true)
addEventHandler('reject',root,reject)



function getMoreInfo(targetPlayer)
	local transferer = getElementData(targetPlayer,'_exchangeParent')
	if isElement(transferer) then
		setElementData(transferer,'_exchangeParent',targetPlayer)
		triggerClientEvent(targetPlayer,'refreshTransferInfo',targetPlayer)
		triggerClientEvent(transferer,'refreshTransferInfo',transferer)
		unbindKey (targetPlayer, "o", "down", getMoreInfo)
	end
end



function splitString(str)
	local id = string.find(str,'|')
	local nums = string.sub(str,0,id)
	local reg = string.sub(str,id+1,id+3)

	return nums,reg
end

function confirmTransfer()
	local parent = getElementData(source,'_exchangeParent')
	
	local moneyP = getElementData(parent,'_surcharge') or 0
	local moneyS = getElementData(source,'_surcharge') or 0
	
	
	takePlayerMoney(source, moneyS)
	givePlayerMoney(parent, moneyS)

	takePlayerMoney(parent, moneyP)
	givePlayerMoney(source, moneyP)


	local veh1 = getPedOccupiedVehicle(parent)
	local veh2 = getPedOccupiedVehicle(source)
	
	local nums1 = getElementData(veh1,'number:plate')
	local reg1 = getElementData(veh1,'numberType')

	local nums2 = getElementData(veh2,'number:plate')
	local reg2 = getElementData(veh2,'numberType')
	
	setElementData(veh1,'numberType', reg2)
	setElementData(veh1,'number:plate',nums2)

	setElementData(veh2,'numberType', reg1)
	setElementData(veh2,'number:plate',nums1)

	
	outputChatBox('Вы успешно совершили сделку!',source,0,255,0)
	outputChatBox('Вы успешно совершили сделку!',parent,0,255,0)

	triggerClientEvent(parent,'hideWindows',parent)
	triggerClientEvent(source,'hideWindows',source)

	setElementData(parent,'_surcharge',0)
	setElementData(source,'_surcharge',0)

	setElementData(source,'_exchangeParent',nil)
	setElementData(parent,'_exchangeParent',nil)
	setElementData(source,'_exchangeState',0)
	setElementData(parent,'_exchangeState',0)
end
addEvent('confirmTransfer',true)
addEventHandler('confirmTransfer',root,confirmTransfer)


--[[
function accept()
	if not transfers[source] then return end
	transfers[source].accepted = true


	local data = transfers[source]
	local data2 = transfers[data.transferer]
	local ply2 = data.transferer

	if data.accepted == true and data2.accepted == true then
		local veh = getPedOccupiedVehicle(data.trigger)
		if not veh or (getElementData(veh,'Owner') ~= data.trigger) then
			outputChatBox('Ошибка: Игрок предложивший сделку не в машине. Сделка отменена.',source,255,0,0)
			outputChatBox('Ошибка: Игрок предложивший сделку не в машине. Сделка отменена.',ply2,255,0,0)
			reject(source)
			return
		end
		outputChatBox('Вы успешно провели сделку!',source,0,255,0)
		outputChatBox('Вы успешно провели сделку!',ply2,0,255,0)

		givePlayerMoney(source,data.wantedMoney)
		takePlayerMoney(source,data.givingMoney)

		givePlayerMoney(ply2,data2.wantedMoney)
		takePlayerMoney(ply2,data2.givingMoney)

		local trigger = data.trigger
		local oldNums = getElementData(veh,'numbers')
		local oldReg = getElementData(veh,'region')


		if source == data.trigger then
			exports.kautov:setNewNumbers(source, data.vehModel, oldNums,oldReg, data.wantedNumbers or '')--Чел сидящий в машине

			local n,r = splitString(data.wantedNumbers)
			setElementData(veh,'numbers',n)
			setElementData(veh,'region',r)

			local nums = false
			local reg = false
			if data2.givingNumbers then
				nums,reg = splitString(data2.givingNumbers)
			end

			exports.kautov:setNewNumbers(data.transferer, data2.vehModel, oldNums,oldReg, data2.wantedNumbers or '')
		elseif data.transferer == data.trigger then
			exports.kautov:setNewNumbers(data.transferer, data2.vehModel, oldNums,oldReg, data2.wantedNumbers or '')--Чел сидящий в машине
			local n,r = splitString(data2.wantedNumbers)
			setElementData(veh,'numbers',n)
			setElementData(veh,'region',r)
			--Ниже надо найти авто
			local nums = false
			local reg = false

			if data.givingNumbers then
				nums,reg = splitString(data.givingNumbers)
				exports.kautov:setNewNumbers(source, data.vehModel, nums,reg, data.wantedNumbers or '')
			end

			
		end

	end
end
addEvent('accept',true)
addEventHandler('accept',root,accept)]]