local markerLVA = createMarker (tableMarkers[6][1], tableMarkers[6][2], tableMarkers[6][3], "cylinder", tableMarkers[6][4], 255, 150, 0, 150)
local markerLSPD = createMarker (tableMarkers[7][1], tableMarkers[7][2], tableMarkers[7][3], "cylinder", tableMarkers[7][4], 255, 150, 0, 150)
setElementData (markerLVA, "LVAAmmo:fracAmmoLVA", 500)
setElementData (markerLSPD, "LVAAmmo:fracAmmoLSPD", 500)

addEventHandler ("onMarkerHit", markerLVA, function (el)
if checkPlLVA (el) then
	triggerClientEvent (el, "loadammo:showLVASklad", el)
end
end)

addEventHandler ("onMarkerHit", markerLSPD, function (el)
if checkPlLSPD (el) then
	triggerClientEvent (el, "loadammo:showLSPDSklad", el)
end
end)

function esyaAl2LVA( )
local slot = getElementData (markerLVA, "LVAAmmo:fracAmmoLVA")
    if slot >= tableWeapon["Бронежилет"] then
	    outputChatBox("#009acdВы взяли бронежилет со склада. Списано #008b00"..tableWeapon["Бронежилет"].."#cfcfcf единиц со склада!" , source, 255, 255, 255, true )
        setPedArmor( source, 100 )
		setElementData (markerLVA, "LVAAmmo:fracAmmoLVA", slot - tonumber(tableWeapon["Бронежилет"]))
		triggerClientEvent (source, "loadammo:updateAmmoLVA", source)
	else
		outputChatBox( "#009acdНа складе не достаточно материалов!", source, 255, 255, 255, true  )	
	end
end
addEvent ("loadammo:zirhAlLVA", true)
addEventHandler ("loadammo:zirhAlLVA", root, esyaAl2LVA)

function esyaAl2LSPD( )
local slot = getElementData (markerLSPD, "LVAAmmo:fracAmmoLSPD")
    if slot >= tableWeapon["Бронежилет"] then
	    outputChatBox("#009acdВы взяли бронежилет со склада. Списано #008b00"..tableWeapon["Бронежилет"].."#cfcfcf единиц со склада!" , source, 255, 255, 255, true )
        setPedArmor( source, 100 )
		setElementData (markerLSPD, "LVAAmmo:fracAmmoLSPD", slot - tonumber(tableWeapon["Бронежилет"]))
		triggerClientEvent (source, "loadammo:updateAmmoLSPD", source)
	else
		outputChatBox( "#009acdНа складе не достаточно материалов!", source, 255, 255, 255, true  )	
	end
end
addEvent ("loadammo:zirhAlLSPD", true)
addEventHandler ("loadammo:zirhAlLSPD", root, esyaAl2LSPD)

local Silahlar = {
	[22] = "Пистолет",
	[23] = "Пистолет с глушителем",
	[24] = "Дигл",
	[25] = "Дробовик",
	[26] = "Обрез",
	[27] = "SPAZ-12",
	[28] = "Uzi",
	[29] = "MP5",
	[32] = "Tec-9",
	[30] = "AK47",
	[31] = "M4A1",
	[34] = "Винтовка"
}

function silahAlLVA( gerekenPara, Silah, Mermi, Yetenek, miktar )
local slot = getElementData (markerLVA, "LVAAmmo:fracAmmoLVA")
local silahN = getWeaponNameFromID( Silah )
    if slot >= gerekenPara then
	    outputChatBox( "#009acdВы взяли#008b00 '".. ( Silahlar[ Silah ] ) .."'#cfcfcf, со склада списано #008b00".. tableWeapon[Silahlar[Silah]] .." #cfcfcfпатрон! ", source, 255, 255, 255, true )
        giveWeapon( source, Silah, Mermi )
		setPedStat( source, Yetenek, miktar )
		setElementData (markerLVA, "LVAAmmo:fracAmmoLVA", slot - tonumber(tableWeapon[Silahlar[Silah]]))
		triggerClientEvent (source, "loadammo:updateAmmoLVA", source)
	else
	    outputChatBox( "#009acdНа складе не достаточно патрон для #cd0000'".. ( Silahlar[ Silah ] ) .."'#cfcfcf!", source, 255, 255, 255, true  )

	end
end
addEvent( "loadammo:satınAlLVA", true )
addEventHandler( "loadammo:satınAlLVA", root, silahAlLVA )

function silahAlLSPD( gerekenPara, Silah, Mermi, Yetenek, miktar )
local slot = getElementData (markerLSPD, "LVAAmmo:fracAmmoLSPD")
local silahN = getWeaponNameFromID( Silah )
    if slot >= gerekenPara then
	    outputChatBox( "#009acdВы взяли#008b00 '".. ( Silahlar[ Silah ] ) .."'#cfcfcf, со склада списано #008b00".. tableWeapon[Silahlar[Silah]] .." #cfcfcfпатрон! ", source, 255, 255, 255, true )
        giveWeapon( source, Silah, Mermi )
		setPedStat( source, Yetenek, miktar )
		setElementData (markerLSPD, "LVAAmmo:fracAmmoLSPD", slot - tonumber(tableWeapon[Silahlar[Silah]]))
		triggerClientEvent (source, "loadammo:updateAmmoLSPD", source)
	else
	    outputChatBox( "#009acdНа складе не достаточно патрон для #cd0000'".. ( Silahlar[ Silah ] ) .."'#cfcfcf!", source, 255, 255, 255, true  )

	end
end
addEvent( "loadammo:satınAlLSPD", true )
addEventHandler( "loadammo:satınAlLSPD", root, silahAlLSPD )