sX, sY = guiGetScreenSize()
W,H = 450, 610
X = sX / 2 - W / 2
Y = sY / 2 - H / 2

-- Fontlar

font = guiCreateFont( "fontlar/font.ttf", 11.5 )
font2 = guiCreateFont( "fontlar/font.ttf", 11 )
-- Panel
arkaplan = guiCreateStaticImage( X, Y, W, H, "img/panel.png", false )
ustpanel = guiCreateStaticImage( 0, 0, 450, 22, "img/panel2.png", false, arkaplan )
ustpanel_L = guiCreateLabel( 0, 0, 450, 22, "Склад ", false, ustpanel )
guiSetFont(ustpanel_L, font2 )
guiSetAlpha( arkaplan, 0.9 )
guiLabelSetHorizontalAlign( ustpanel_L, "center" ) 
guiLabelSetVerticalAlign( ustpanel_L, "center" )
guiSetVisible( arkaplan, false )
showCursor( false )
guiSetEnabled( ustpanel, false )
-- Pistol

pistol_img = guiCreateStaticImage( W/2-100/0.5, 30, 100, 60, "img/22.png", false, arkaplan )
pistol_btngzl = guiCreateStaticImage( W/2-100/0.5, 30+76, 102, 21, "img/panel2.png", false, arkaplan )
pistol_L = guiCreateLabel( W/2-100/0.5, 30+75, 100, 20, "Пистолет", false, arkaplan )
guiSetProperty( pistol_btngzl, "ImageColours", "tl:FFCFCFCF tr:FFCFCFCF bl:FFCFCFCF br:FFCFCFCF" )
guiSetAlpha( pistol_btngzl, 0 )
guiLabelSetHorizontalAlign( pistol_L, "center" ) 
guiSetFont( pistol_L, font )
guiSetEnabled( pistol_btngzl, false )
-- Susturuculu Pistol

sust_pistol_img = guiCreateStaticImage( W/2-100/2, 30, 100, 60, "img/23.png", false, arkaplan )
sust_pistol_btngzl = guiCreateStaticImage( W/2-94.5/2, 30+76, 102, 21, "img/panel2.png", false, arkaplan )
sust_pistol_L = guiCreateLabel( W/2-94/2, 30+75, 100, 20, "Пистолет S", false, arkaplan )
guiSetProperty( sust_pistol_btngzl, "ImageColours", "tl:FFCFCFCF tr:FFCFCFCF bl:FFCFCFCF br:FFCFCFCF" )
guiSetAlpha( sust_pistol_btngzl, 0 )
guiLabelSetHorizontalAlign( sust_pistol_L, "center" ) 
guiSetFont( sust_pistol_L, font )
guiSetEnabled( sust_pistol_btngzl, false )
-- Deagle

deagle_img = guiCreateStaticImage( W/2+100/1, 30, 100, 60, "img/24.png", false, arkaplan )
deagle_btngzl = guiCreateStaticImage( W/2+105.5/1, 30+76, 102, 21, "img/panel2.png", false, arkaplan )
deagle_L = guiCreateLabel( W/2+105.5/1, 30+75, 100, 20, "Дигл", false, arkaplan )
guiSetProperty( deagle_btngzl, "ImageColours", "tl:FFCFCFCF tr:FFCFCFCF bl:FFCFCFCF br:FFCFCFCF" )
guiSetAlpha( deagle_btngzl, 0 )
guiLabelSetHorizontalAlign( deagle_L, "center" ) 
guiSetFont( deagle_L, font )
guiSetEnabled( deagle_btngzl, false )
-- Shotgun

shotgun_img = guiCreateStaticImage( W/2-100/0.5, 30+130, 110, 34, "img/25.png", false, arkaplan )
shotgun_btngzl = guiCreateStaticImage( W/2-100/0.5, 30+130+51, 102, 21, "img/panel2.png", false, arkaplan )
shotgun_L = guiCreateLabel( W/2-100/0.5, 30+130+51, 100, 20, "Дробовик", false, arkaplan )
guiSetProperty( shotgun_btngzl, "ImageColours", "tl:FFCFCFCF tr:FFCFCFCF bl:FFCFCFCF br:FFCFCFCF" )
guiSetAlpha( shotgun_btngzl, 0 )
guiLabelSetHorizontalAlign( shotgun_L, "center" ) 
guiSetFont( shotgun_L, font )
guiSetEnabled( shotgun_btngzl, false )
-- Sawed-Off

sawedoff_img = guiCreateStaticImage( W/2-100/2, 30+130, 110, 34, "img/26.png", false, arkaplan )
sawedoff_btngzl = guiCreateStaticImage( W/2-94.5/2, 30+130+51, 102, 21, "img/panel2.png", false, arkaplan )
sawedoff_L = guiCreateLabel( W/2-94/2, 30+130+51, 100, 20, "Обрез", false, arkaplan )
guiSetProperty( sawedoff_btngzl, "ImageColours", "tl:FFCFCFCF tr:FFCFCFCF bl:FFCFCFCF br:FFCFCFCF" )
guiSetAlpha( sawedoff_btngzl, 0 )
guiLabelSetHorizontalAlign( sawedoff_L, "center" ) 
guiSetFont( sawedoff_L, font )
guiSetEnabled( sawedoff_btngzl, false )
-- Combat Shotgun

combats_img = guiCreateStaticImage( W/2+100/1, 30+130, 110, 34, "img/27.png", false, arkaplan )
combats_btngzl = guiCreateStaticImage( W/2+105.5/1, 30+130+51, 102, 21, "img/panel2.png", false, arkaplan )
combats_L = guiCreateLabel( W/2+105.5/1, 30+130+51, 100, 20, "SPAZ-12", false, arkaplan )
guiSetProperty( combats_btngzl, "ImageColours", "tl:FFCFCFCF tr:FFCFCFCF bl:FFCFCFCF br:FFCFCFCF" )
guiSetAlpha( combats_btngzl, 0 )
guiLabelSetHorizontalAlign( combats_L, "center" ) 
guiSetFont( combats_L, font )
guiSetEnabled( combats_btngzl, false )
-- Uzi

uzi_img = guiCreateStaticImage( W/2-100/0.5, 30+235, 90, 70, "img/28.png", false, arkaplan )
uzi_btngzl = guiCreateStaticImage( W/2-100/0.5, 30+322, 102, 21, "img/panel2.png", false, arkaplan )
uzi_L = guiCreateLabel( W/2-100/0.5, 30+322, 100, 20, "Uzi", false, arkaplan )
guiSetProperty( uzi_btngzl, "ImageColours", "tl:FFCFCFCF tr:FFCFCFCF bl:FFCFCFCF br:FFCFCFCF" )
guiSetAlpha( uzi_btngzl, 0 )
guiLabelSetHorizontalAlign( uzi_L, "center" ) 
guiSetFont( uzi_L, font )
guiSetEnabled( uzi_btngzl, false )

-- MP5

mp5_img = guiCreateStaticImage( W/2-100/2, 30+235, 100, 70, "img/29.png", false, arkaplan )
mp5_btngzl = guiCreateStaticImage( W/2-94.5/2, 30+322, 102, 21, "img/panel2.png", false, arkaplan )
mp5_L = guiCreateLabel( W/2-94.5/2, 30+322, 100, 20, "MP5", false, arkaplan )
guiSetProperty( mp5_btngzl, "ImageColours", "tl:FFCFCFCF tr:FFCFCFCF bl:FFCFCFCF br:FFCFCFCF" )
guiSetAlpha( mp5_btngzl, 0 )
guiLabelSetHorizontalAlign( mp5_L, "center" ) 
guiSetFont( mp5_L, font )
guiSetEnabled( mp5_btngzl, false )
-- Tec-9

tec9_img = guiCreateStaticImage( W/2+100/1, 30+235, 100, 70, "img/32.png", false, arkaplan )
tec9_btngzl = guiCreateStaticImage( W/2+105.5/1, 30+322, 102, 21, "img/panel2.png", false, arkaplan )
tec9_L = guiCreateLabel( W/2+105.5/1, 30+322, 100, 20, "Tec-9", false, arkaplan )
guiSetProperty( tec9_btngzl, "ImageColours", "tl:FFCFCFCF tr:FFCFCFCF bl:FFCFCFCF br:FFCFCFCF" )
guiSetAlpha( tec9_btngzl, 0 )
guiLabelSetHorizontalAlign( tec9_L, "center" ) 
guiSetFont( tec9_L, font )
guiSetEnabled( tec9_btngzl, false )
-- AK47

ak47_img = guiCreateStaticImage( W/2-100/0.5, 30+370, 120, 35, "img/30.png", false, arkaplan )
ak47_btngzl = guiCreateStaticImage( W/2-100/0.5, 30+422, 102, 21, "img/panel2.png", false, arkaplan )
ak47_L = guiCreateLabel( W/2-100/0.5, 30+422, 100, 20, "AK-47", false, arkaplan )
guiSetProperty( ak47_btngzl, "ImageColours", "tl:FFCFCFCF tr:FFCFCFCF bl:FFCFCFCF br:FFCFCFCF" )
guiSetAlpha( ak47_btngzl, 0 )
guiLabelSetHorizontalAlign( ak47_L, "center" ) 
guiSetFont( ak47_L, font )
guiSetEnabled( ak47_btngzl, false )
-- M4A1
m4a1_img = guiCreateStaticImage( W/2-100/2, 30+370, 120, 35, "img/31.png", false, arkaplan )
m4a1_btngzl = guiCreateStaticImage( W/2-94.5/2, 30+422, 102, 21, "img/panel2.png", false, arkaplan )
m4a1_L = guiCreateLabel( W/2-94.5/2, 30+422, 100, 20, "M4A1", false, arkaplan )
guiSetProperty( m4a1_btngzl, "ImageColours", "tl:FFCFCFCF tr:FFCFCFCF bl:FFCFCFCF br:FFCFCFCF" )
guiSetAlpha( m4a1_btngzl, 0 )
guiLabelSetHorizontalAlign( m4a1_L, "center" ) 
guiSetFont( m4a1_L, font )
guiSetEnabled( m4a1_btngzl, false )
-- Sniper

sniper_img = guiCreateStaticImage( W/2+100/1, 30+370, 120, 42, "img/34.png", false, arkaplan )
sniper_btngzl = guiCreateStaticImage( W/2+105.5/1, 30+422, 102, 21, "img/panel2.png", false, arkaplan )
sniper_L = guiCreateLabel( W/2+105.5/1, 30+422, 100, 20, "Винтовка", false, arkaplan )
guiSetProperty( sniper_btngzl, "ImageColours", "tl:FFCFCFCF tr:FFCFCFCF bl:FFCFCFCF br:FFCFCFCF" )
guiSetAlpha( sniper_btngzl, 0 )
guiLabelSetHorizontalAlign( sniper_L, "center" ) 
guiSetFont( sniper_L, font )
guiSetEnabled( sniper_btngzl, false )


-- Çizgi ( Can - Zırh )
cizgi_img = guiCreateStaticImage( W/2-440/2, 30+460, 440, 3, "img/cizgi.png", false, arkaplan )
guiSetProperty( cizgi_img, "ImageColours", "tl:FFcd3333 tr:FFcd3333 bl:FFcd3333 br:FFcd3333" )

-- Zirh
zirh_btngzl = guiCreateStaticImage( 350, 30+500, 70, 42, "img/panel2.png", false, arkaplan )
zirh_L = guiCreateLabel( 360, 30+500, 70, 42, "Бронежилет", false, arkaplan )
zirh_img = guiCreateStaticImage( W/2+35/3, 30+475, 90, 85, "img/zirh.png", false, arkaplan )
guiSetAlpha( zirh_btngzl, 0 )
guiSetAlpha( zirh_img, 0.8 )
guiSetFont( zirh_L, font )

addEventHandler( "onClientMouseEnter", root,

-- Butonlar İçin Mouse İşlevi --
function()
    if source == pistol_L then
	    guiSetAlpha( pistol_btngzl, 0.5 )	
	
	elseif source == sust_pistol_L then
	    guiSetAlpha( sust_pistol_btngzl, 0.5 )
		
	elseif source == deagle_L then
	    guiSetAlpha( deagle_btngzl, 0.5 )	
		
	elseif source == shotgun_L then
	    guiSetAlpha( shotgun_btngzl, 0.5 )	
		
	elseif source == sawedoff_L then
	    guiSetAlpha( sawedoff_btngzl, 0.5 )	
		
	elseif source == combats_L then
	    guiSetAlpha( combats_btngzl, 0.5 )	
		
    elseif source == uzi_L then
	    guiSetAlpha( uzi_btngzl, 0.5 )		

    elseif source == mp5_L then
	    guiSetAlpha( mp5_btngzl, 0.5 )		
		
    elseif source == tec9_L then
	    guiSetAlpha( tec9_btngzl, 0.5 )		
		
	elseif source == ak47_L then
        guiSetAlpha( ak47_btngzl, 0.5 )	
		
	elseif source == m4a1_L then
        guiSetAlpha( m4a1_btngzl, 0.5 )			
		
	elseif source == sniper_L then
        guiSetAlpha( sniper_btngzl, 0.5 )		
		
	elseif source == zirh_L then
        guiSetAlpha( zirh_btngzl, 0.5 )
		
	elseif source == yari_L then	
        guiLabelSetColor( yari_L, 205, 51, 51 )	
		
	end
end)	

-- //	
addEventHandler( "onClientMouseLeave", root,
function()
    if source == pistol_L then
	    guiSetAlpha( pistol_btngzl, 0 )	
	
	elseif source == sust_pistol_L then
	    guiSetAlpha( sust_pistol_btngzl, 0 )
		
	elseif source == deagle_L then
	    guiSetAlpha( deagle_btngzl, 0 )	
		
	elseif source == shotgun_L then
	    guiSetAlpha( shotgun_btngzl, 0 )	
	
	elseif source == sawedoff_L then
	    guiSetAlpha( sawedoff_btngzl, 0 )	
		
	elseif source == combats_L then
	    guiSetAlpha( combats_btngzl, 0 )	
		
    elseif source == uzi_L then
	    guiSetAlpha( uzi_btngzl, 0 )		

    elseif source == mp5_L then
	    guiSetAlpha( mp5_btngzl, 0 )		
		
    elseif source == tec9_L then
	    guiSetAlpha( tec9_btngzl, 0 )		
		
	elseif source == ak47_L then
        guiSetAlpha( ak47_btngzl, 0 )	
		
	elseif source == m4a1_L then
        guiSetAlpha( m4a1_btngzl, 0 )			
		
	elseif source == sniper_L then
        guiSetAlpha( sniper_btngzl, 0 )				

	elseif source == zirh_L then
        guiSetAlpha( zirh_btngzl, 0 )	

	elseif source == yari_L then	
        guiLabelSetColor( yari_L, 255, 255, 255 )			
	end
end)

addEventHandler( "onClientGUIClick", root,
function()
if getElementData (localPlayer, "frac") == "LSPD" then
    if source == pistol_L then
	local para_pistol = tableWeapon["Пистолет"]
        triggerServerEvent( "loadammo:satınAlLSPD", localPlayer, para_pistol, 22, 60, 69, 1000 )
	 
    elseif source == sust_pistol_L then
	local para_spistol = tableWeapon["Пистолет с глушителем"]
	    triggerServerEvent( "loadammo:satınAlLSPD", localPlayer, para_spistol, 23, 60, 70, 1000 )	
	
	elseif source == deagle_L then
	local para_deagle = tableWeapon["Дигл"]	
	    triggerServerEvent( "loadammo:satınAlLSPD", localPlayer, para_deagle, 24, 60, 71, 1000 )	
	
    elseif source == shotgun_L then
	local para_shotgun = tableWeapon["Дробовик"]	
	    triggerServerEvent( "loadammo:satınAlLSPD", localPlayer, para_shotgun, 25, 30, 72, 1000 )

	elseif source == sawedoff_L then	
	local para_sawedoff = tableWeapon["Обрез"]	
        triggerServerEvent( "loadammo:satınAlLSPD", localPlayer, para_sawedoff, 26, 30, 73, 1000 )
		
    elseif source == combats_L then	
	local para_combats = tableWeapon["SPAZ-12"]	
	    triggerServerEvent( "loadammo:satınAlLSPD", localPlayer, para_combats, 27, 30, 74, 1000 )	
		
    elseif source == uzi_L then
	local para_uzi = tableWeapon["Uzi"]	
	    triggerServerEvent( "loadammo:satınAlLSPD", localPlayer, para_uzi, 28, 120, 75, 1000 )	
		
    elseif source == mp5_L then	
	local para_mp5 = tableWeapon["MP5"]	
	    triggerServerEvent( "loadammo:satınAlLSPD", localPlayer, para_mp5, 29, 80, 76, 1000 )
    
    elseif source == tec9_L then 
	local para_tec9 = tableWeapon["Tec-9"]	
	    triggerServerEvent( "loadammo:satınAlLSPD", localPlayer, para_tec9, 32, 120, 75, 1000 )

    elseif source == ak47_L then
	local para_ak47 = tableWeapon["AK47"]	
	    triggerServerEvent( "loadammo:satınAlLSPD", localPlayer, para_ak47, 30, 60, 77, 1000 )
    
    elseif source == m4a1_L then
	local para_m4a1 = tableWeapon["M4A1"]	
	    triggerServerEvent( "loadammo:satınAlLSPD", localPlayer, para_m4a1, 31, 60, 78, 1000 )
    
    elseif source == sniper_L then
	local para_sniper = tableWeapon["Винтовка"]	
	    triggerServerEvent( "loadammo:satınAlLSPD", localPlayer, para_sniper, 34, 30, 79, 1000 )	
    elseif source == zirh_L then
		triggerServerEvent( "loadammo:zirhAlLSPD", localPlayer )
	end
elseif getElementData (localPlayer, "frac") == "LVA" then
	 if source == pistol_L then
	local para_pistol = tableWeapon["Пистолет"]
        triggerServerEvent( "loadammo:satınAlLVA", localPlayer, para_pistol, 22, 60, 69, 1000 )
	 
    elseif source == sust_pistol_L then
	local para_spistol = tableWeapon["Пистолет с глушителем"]
	    triggerServerEvent( "loadammo:satınAlLVA", localPlayer, para_spistol, 23, 60, 70, 1000 )	
	
	elseif source == deagle_L then
	local para_deagle = tableWeapon["Дигл"]	
	    triggerServerEvent( "loadammo:satınAlLVA", localPlayer, para_deagle, 24, 60, 71, 1000 )	
	
    elseif source == shotgun_L then
	local para_shotgun = tableWeapon["Дробовик"]	
	    triggerServerEvent( "loadammo:satınAlLVA", localPlayer, para_shotgun, 25, 30, 72, 1000 )

	elseif source == sawedoff_L then	
	local para_sawedoff = tableWeapon["Обрез"]	
        triggerServerEvent( "loadammo:satınAlLVA", localPlayer, para_sawedoff, 26, 30, 73, 1000 )
		
    elseif source == combats_L then	
	local para_combats = tableWeapon["SPAZ-12"]	
	    triggerServerEvent( "loadammo:satınAlLVA", localPlayer, para_combats, 27, 30, 74, 1000 )	
		
    elseif source == uzi_L then
	local para_uzi = tableWeapon["Uzi"]	
	    triggerServerEvent( "loadammo:satınAlLVA", localPlayer, para_uzi, 28, 120, 75, 1000 )	
		
    elseif source == mp5_L then	
	local para_mp5 = tableWeapon["MP5"]	
	    triggerServerEvent( "loadammo:satınAlLVA", localPlayer, para_mp5, 29, 80, 76, 1000 )
    
    elseif source == tec9_L then 
	local para_tec9 = tableWeapon["Tec-9"]	
	    triggerServerEvent( "loadammo:satınAlLVA", localPlayer, para_tec9, 32, 120, 75, 1000 )

    elseif source == ak47_L then
	local para_ak47 = tableWeapon["AK47"]	
	    triggerServerEvent( "loadammo:satınAlLVA", localPlayer, para_ak47, 30, 60, 77, 1000 )
    
    elseif source == m4a1_L then
	local para_m4a1 = tableWeapon["M4A1"]	
	    triggerServerEvent( "loadammo:satınAlLVA", localPlayer, para_m4a1, 31, 60, 78, 1000 )
    
    elseif source == sniper_L then
	local para_sniper = tableWeapon["Винтовка"]	
	    triggerServerEvent( "loadammo:satınAlLVA", localPlayer, para_sniper, 34, 30, 79, 1000 )	
    elseif source == zirh_L then
		triggerServerEvent( "loadammo:zirhAlLVA", localPlayer )
	end
end
end)

function ackapaLVA()
    if (guiGetVisible( arkaplan ) == false ) then
	    guiSetVisible( arkaplan, true )
		playSoundFrontEnd( 11 )
		showCursor( true )
		guiSetText (ustpanel_L, "Склад LVA "..getElementData (getMarkerLVA(), "LVAAmmo:fracAmmoLVA").."/"..maxSlotsFrac)
    elseif (guiGetVisible( arkaplan ) == true ) then	
	    guiSetVisible( arkaplan, false )
		playSoundFrontEnd( 4 )
		showCursor( false )
	end
end
addEvent ("loadammo:showLVASklad", true)
addEventHandler ("loadammo:showLVASklad", root, ackapaLVA)

function ackapaLSPD()
    if (guiGetVisible( arkaplan ) == false ) then
	    guiSetVisible( arkaplan, true )
		playSoundFrontEnd( 11 )
		showCursor( true )
		guiSetText (ustpanel_L, "Склад LSPD "..getElementData (getMarkerLSPD(), "LVAAmmo:fracAmmoLSPD").."/"..maxSlotsFrac)
    elseif (guiGetVisible( arkaplan ) == true ) then	
	    guiSetVisible( arkaplan, false )
		playSoundFrontEnd( 4 )
		showCursor( false )
	end
end
addEvent ("loadammo:showLSPDSklad", true)
addEventHandler ("loadammo:showLSPDSklad", root, ackapaLSPD)

bindKey("F2", "down", function( )
if (guiGetVisible( arkaplan ) == true ) then	
	guiSetVisible( arkaplan, false )
	playSoundFrontEnd( 4 )
	showCursor( false )
end
end)

addEvent ("loadammo:updateAmmoLVA", true)
addEventHandler ("loadammo:updateAmmoLVA", root, function()
if guiGetVisible (arkaplan) then
	guiSetText (ustpanel_L, "Склад LVA "..getElementData (getMarkerLVA(), "LVAAmmo:fracAmmoLVA").."/"..maxSlotsFrac)
end
end)

addEvent ("loadammo:updateAmmoLSPD", true)
addEventHandler ("loadammo:updateAmmoLSPD", root, function()
if guiGetVisible (arkaplan) then
	guiSetText (ustpanel_L, "Склад LSPD "..getElementData (getMarkerLSPD(), "LVAAmmo:fracAmmoLSPD").."/"..maxSlotsFrac)
end
end)
	