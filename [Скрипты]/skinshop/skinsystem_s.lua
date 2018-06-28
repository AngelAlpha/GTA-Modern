addEvent("onPlayerSkinChange",true)
addEventHandler("onPlayerSkinChange",getRootElement(),function(skinid, skinprice)
	if getPlayerMoney(source) >= skinprice then
		takePlayerMoney ( source, tonumber(skinprice) )
		setElementModel( source, skinid)
		outputChatBox ("Вы купили скин за "..skinprice.." $", source)
	else
		outputChatBox ("У вас не достаточно денег, для покупки.", source)
	end
end)


