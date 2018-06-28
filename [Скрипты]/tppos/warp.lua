local player = getLocalPlayer()


GUIEditor = {
    gridlist = {},
    button = {},
    label = {},
    edit = {}
}

        okno = guiCreateGridList(488, 181, 571, 476, false)
        guiSetAlpha(okno, 0.87)
		guiSetVisible ( okno, false )

        GUIEditor.label[4] = guiCreateLabel(0, 89, 571, 45, "X :", false, okno)
        guiLabelSetHorizontalAlign(GUIEditor.label[4], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[4], "center")
        GUIEditor.label[5] = guiCreateLabel(0, 176, 571, 45, "Y :", false, okno)
        guiLabelSetHorizontalAlign(GUIEditor.label[5], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[5], "center")
        x1 = guiCreateEdit(203, 134, 161, 35, "", false, okno)
        y1 = guiCreateEdit(203, 221, 161, 35, "", false, okno)
        GUIEditor.label[6] = guiCreateLabel(0, 256, 571, 45, "Z :", false, okno)
        guiLabelSetHorizontalAlign(GUIEditor.label[6], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[6], "center")
        z1 = guiCreateEdit(203, 301, 161, 35, "", false, okno)
        GUIEditor.button[1] = guiCreateButton(112, 360, 166, 59, "Teleport", false, okno)

        GUIEditor.button[2] = guiCreateButton(297, 360, 166, 59, "Zamknij", false, okno)



    function draw()
        dxDrawRectangle(446, 214, 657, 50, tocolor(241, 0, 0, 255), true)
        dxDrawText("Warp System", 490, 216, 1060, 259, tocolor(0, 0, 0, 255), 1.00, "bankgothic", "center", "center", false, false, true, false, false)
        dxDrawText("Warp System", 490, 214, 1060, 257, tocolor(0, 0, 0, 255), 1.00, "bankgothic", "center", "center", false, false, true, false, false)
        dxDrawText("Warp System", 488, 216, 1058, 259, tocolor(0, 0, 0, 255), 1.00, "bankgothic", "center", "center", false, false, true, false, false)
        dxDrawText("Warp System", 488, 214, 1058, 257, tocolor(0, 0, 0, 255), 1.00, "bankgothic", "center", "center", false, false, true, false, false)
        dxDrawText("Warp System", 489, 215, 1059, 258, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, true, false, false)
        dxDrawText("Stworzone przez :\n@Creative", 488, 599, 584, 657, tocolor(255, 255, 255, 255), 0.30, "bankgothic", "center", "center", false, false, true, false, false)
    end
	
	function otworz ()
	guiSetVisible ( okno, true )
	showCursor ( true )
	addEventHandler ( "onClientRender", getRootElement(), draw )
	end
	addCommandHandler ( "tppos", otworz )
	
	function zamknij ()
	guiSetVisible ( okno, false )
	showCursor ( false )
	removeEventHandler ( "onClientRender", getRootElement(), draw )
	end
	addEventHandler ( "onClientGUIClick", GUIEditor.button[2], zamknij, false )
	
	
	function tele()
	local x = guiGetText ( x1 )
	local y = guiGetText ( y1 )
	local z = guiGetText ( z1 )
	setElementPosition ( player, x, y, z )
	outputChatBox ( "Zostałeś przeteleportowany na współrzędne :", 255, 255, 255 )
	outputChatBox ( "X : "..x.."", 255, 255, 255 )
	outputChatBox ( "Y : "..y.."", 255, 255, 255 )
	outputChatBox ( "Z : "..z.."", 255, 255, 255 )
	guiSetText ( x1, "" )
	guiSetText ( y1, "" )
	guiSetText ( z1, "" )
	end
	addEventHandler ( "onClientGUIClick", GUIEditor.button[1], tele, false )