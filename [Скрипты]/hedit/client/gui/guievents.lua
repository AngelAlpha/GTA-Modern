local abs = math.abs
local scrollbarColor = tocolor(255, 255, 255, 50)
local SCROLLBAR_THRESHOLD = 10 -- in pixels

function onMove ( _, _, cX, cY )
    if not (pressedButton and scrollbar and tobool(getUserConfig("dragmeterEnabled"))) then return end

    if not scrollbar.thresholdReached then
        if not( abs(scrollbar.clickX - cX) > SCROLLBAR_THRESHOLD )then return end
        -- execute belowif outside threshold...
        scrollbar.thresholdReached = true
        showScrollbar = true

        -- Calculate virtual scrollbar x value (is the originX-(width/2)
        scrollbar.virtualX = cX - (scrollbar.size[1]*scrollbar.position)
        scrollbar.virtualX2 = scrollbar.virtualX + scrollbar.size[1]
    end

    local progress = (cX-scrollbar.virtualX)/(scrollbar.virtualX2-scrollbar.virtualX)
    if (progress >= 0) and (progress <= 1) then
        scrollbar.position = progress
        local a, b = scrollbar.min, scrollbar.max
        local propertyValue = progress*(b-a)+a
        guiSetText(pressedButton, math.round(propertyValue, 0))
    else
        -- Allow overflows to snap to nearest boundary
        guiSetText(pressedButton, (progress < 0) and scrollbar.min or scrollbar.max)
    end
end

function onRender()
    if showScrollbar and scrollbar then
        local x, y = unpack(pressedButtonPosition)
        local width = scrollbar.position * scrollbar.size[1]

        -- Draw scroll box
        dxDrawRectangle(x, y, width, scrollbar.size[2], scrollbarColor, true)

        -- Draw pin point
        dxDrawLine(x+width, y, x+width, y-5, tocolor(255, 0, 0, 255), 3, true)

        -- DEBUG: Draw bounding box
        Debug.dxDrawRectangle(scrollbar.virtualX, y+20, scrollbar.size[1], scrollbar.size[2], scrollbar.color, true)
    else
        showScrollbar = false
    end
end

function onClick ( button, state )
    if pressedButton then
        local buttonText, abort = guiGetText(pressedButton)
        if scrollbar and (scrollbar.old ~= buttonText) and isElement(pVehicle) then
            prepareHandlingValue(pVehicle, guiGetElementProperty(pressedButton), buttonText)
            abort = true
        end
        scrollbar = nil
        pressedButton = nil
        pressedButtonPosition = nil
        if abort then return end
    end

    if not pointedButton then return end

    local source = pointedButton
    local parent = guiGetElementParent ( source )
    local event = guiGetElementEvents ( source )
    local info = guiGetElementInfo ( source )
    local state = (state == "down") and true or false

    if state and (button == "left") and (parent == "viewItem") and tobool(getUserConfig("dragmeterEnabled")) then
        local inputType = guiGetElementInputType ( source )
        local property = guiGetElementProperty ( source )

        if not property then return end
        local propertyType = getHandlingPropertyValueType ( property )
        
        -- Limit propertyType to float/integer
        if (inputType == "config") and (propertyType == "Float") or (propertyType == "Integer") then
            local mx, my = getCursorPosition()
            
            pressedButton = source
            pressedButtonPosition = {guiGetPosition(source, false)}

            element = source
            while getElementType(getElementParent(element)) ~= "guiroot" do
                element = getElementParent(element)
                local x, y = guiGetPosition(element, false)
                pressedButtonPosition[1], pressedButtonPosition[2] = pressedButtonPosition[1] + x, pressedButtonPosition[2] + y
            end

            local a, b = getHandlingLimits( guiGetElementProperty(pressedButton) )
            local x = tonumber(guiGetText(pressedButton))

            scrollbar = {
                clickX = mx * scrX,
                position = (x-a)/(b-a),
                size = {guiGetSize(pressedButton, false)},
                old = guiGetText(pressedButton),
                min = a,
                max = b,
                thresholdReached = false,
            }
        end
        return
    elseif state then
        -- I was going to change everything to do a check to see if its up or down..
        -- Too much hassle. Just going to kill the function here.
        return
    end

    if (button == "left") then

        if parent == "menuButton" then
            guiToggleUtilityDropDown ( info )
    
        elseif parent == "menuItem" then
            guiShowView ( info )
            
        elseif parent == "viewButton" then
            if (info == "undo") or (info == "redo") then
                outputChatBox(info)
            else
                guiShowView ( info )
            end
            
        elseif parent == "viewItem" then
            local inputType = guiGetElementInputType ( source )

            local property = guiGetElementProperty ( source )
            
            if property then
            
                if (inputType == "config") and (getElementType(source) == "gui-button") then
                    
                    destroyEditBox ( )
                    
                    local x,y = guiGetPosition ( source, false )
                    local w,h = guiGetSize ( source, false )
                    local text = guiGetText ( source )
                    
                    guiSetVisible ( source, false )
                    
                    hiddenEditBox = source
                    openedEditBox = guiCreateEdit ( x, y, w, h, text, false, heditGUI.window )
                    
                    guiSetFont ( openedEditBox, guiGetFont ( source ) )
                    
                    guiBringToFront ( openedEditBox )
                    guiEditSetCaretIndex ( openedEditBox, string.len ( text ) )
                    
                    if property == "maxVelocity" then
						if getElementModel (getPedOccupiedVehicle(localPlayer)) == 502 then
							min,max = 0.1, 360
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 400 then
							min,max = 0.1, 280
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 415 then
							min,max = 0.1, 430
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 507 then
							min,max = 0.1, 280
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 541 then
							min,max = 0.1, 330
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 585 then
							min,max = 0.1, 240
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 466 then
							min,max = 0.1, 210
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 604 then
							min,max = 0.1, 215
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 492 then
							min,max = 0.1, 280
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 551 then
							min,max = 0.1, 287
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 410 then
							min,max = 0.1, 260
						
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 555 then
							min,max = 0.1, 245
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 565 then
							min,max = 0.1, 220
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 542 then
							min,max = 0.1, 260
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 562 then
							min,max = 0.1, 270
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 420 then
							min,max = 0.1, 230
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 445 then
							min,max = 0.1, 240
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 580 then
							min,max = 0.1, 200
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 506 then
							min,max = 0.1, 290
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 558 then
							min,max = 0.1, 300
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 402 then
							min,max = 0.1, 260
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 503 then
							min,max = 0.1, 287
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 439 then
							min,max = 0.1, 160
						
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 561 then
							min,max = 0.1, 190
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 546 then
							min,max = 0.1, 170
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 411 then
							min,max = 0.1, 320
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 547 then
							min,max = 0.1, 230
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 409 then
							min,max = 0.1, 220
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 429 then
							min,max = 0.1, 290
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 458 then
							min,max = 0.1, 270
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 516 then
							min,max = 0.1, 190
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 579 then
							min,max = 0.1, 210
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 418 then
							min,max = 0.1, 220
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 543 then
							min,max = 0.1, 200
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 489 then
							min,max = 0.1, 230
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 566 then
							min,max = 0.1, 190
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 589 then
							min,max = 0.1, 280
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 567 then
							min,max = 0.1, 180
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 494 then
							min,max = 0.1, 230
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 560 then
							min,max = 0.1, 240
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 527 then
							min,max = 0.1, 260
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 401 then
							min,max = 0.1, 255
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 404 then
							min,max = 0.1, 220
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 559 then
							min,max = 0.1, 260
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 405 then
							min,max = 0.1, 130
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 438 then
							min,max = 0.1, 130
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 479 then
							min,max = 0.1, 130
							
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 540 then
							min,max = 0.1, 130
						elseif getElementModel (getPedOccupiedVehicle(localPlayer)) == 419 then
							min,max = 0.1, 130
						else
							min,max = getHandlingLimits (property)
						end
					else
						min,max = getHandlingLimits (property)
					end
					
					
                    local propType = getHandlingPropertyValueType ( property ) .. ( min and ": " .. tostring ( min ) .. " - " .. tostring ( max ) or "" )
                    local propInfo = getHandlingPropertyValueInformation ( property )
                    
                    guiSetStaticInfoText ( propType, propInfo )
                    
                    
                    
                elseif inputType == "infolabel" and isHandlingPropertyHexadecimal ( property ) then
                    
                    if pVehicle then
                        
                        guiSetEnabled ( source, false ) -- Spam prevention, stop players to click the button till wierd stuff happens. Need a better spam protection.
                        setTimer ( guiSetEnabled, 500, 1, source, true )

                        local enabled = guiCheckBoxGetSelected ( source )
                        local config = getVehicleHandling ( pVehicle )[property]
                        local reversedHex = string.reverse ( config )..string.rep ( "0", 8 - string.len ( config ) )
                        local byte = 1
                        local str = ""
                        
                        for value in string.gmatch ( reversedHex, "." ) do
                            
                            if byte == info.byte then

                                local curValue = tonumber ( "0x"..value )
                                local addValue = tonumber ( info.value )
                                local calc

                                if enabled then
                                    calc = curValue + addValue
                                else
                                    calc = curValue - addValue
                                end

                                if calc < 0 then
                                    calc = 0
                                end
                                
                                local newValue = string.format ( "%X", calc )

                                value = newValue

                            end
                            
                            str = str..value
                            byte = byte + 1
                        end
                        
                        setVehicleHandling ( pVehicle, property, string.reverse ( str ) )

                        
                        
                    else
                        
                        -- No vehicle
                        
                    end
                    
                end
                
            end
            
        end
        
    elseif (button == "right") then
        
        if pressedKey then -- Check whether CTRL or SHIFT is valid pressed with a right-mouse-click
            
            local property = guiGetElementProperty ( source )
            local value = guiGetText ( pointedButton )
            prepareHandlingValue ( pVehicle, property, value )
            
        end
        
    end
    
    if (parent ~= "menuButton") then
        guiToggleUtilityDropDown ( currentUtil )
    end
    
    if event and event.onClick then
        event.onClick ( source, button )
    end
    
    return true
end

function onDoubleClick ( )
    local event = guiGetElementEvents ( source )

    if event and event.onDoubleClick then
        event.onDoubleClick ( source, button )
    end
    
    return true
end


-- mouse enter, not edit enter!
function onEnter ( )
    local parent = guiGetElementParent ( source )
    local event = guiGetElementEvents ( source )
    local inputType = guiGetElementInputType ( source )
    local elementInfo = guiGetElementInfo ( source )
    setPointedElement ( source, true )
    
    if parent == "menuButton" and currentUtil then
        local util = guiGetElementInfo ( source )
        
        if util ~= currentUtil then
            guiToggleUtilityDropDown ( util )
        end
        
    elseif parent == "viewButton" or parent == "menuItem" then
    
        guiSetInfoText ( getViewLongName(elementInfo), "" )
    
    elseif parent == "viewItem" then
        
        if inputType == "infolabel" then
        
            local property,name,info = guiGetElementProperty ( source ),nil,nil
            
            if isHandlingPropertyHexadecimal ( property ) then
                local byte, value = elementInfo.byte, elementInfo.value
                name = getHandlingPropertyByteName ( property, byte, value )
                info = getHandlingPropertyByteInformation ( property, byte, value )
            else
                name = getHandlingPropertyFriendlyName ( property )
                info = getHandlingPropertyInformationText ( property )
            end
            
            guiSetInfoText ( name, info )
            
        elseif inputType == "config" then
            
            guiSetInfoText ( getText ( "clickToEdit" ), getText ( "enterToSubmit" ) )
            
        elseif inputType == "special" then
            
            
        end
        
    elseif parent == "special" then
        
        if elementInfo == "minilog" and guiGetText ( source ) ~= "" then
            
            guiSetInfoText ( getText ( "clickToViewFullLog" ), "" )
            
        end
        
    end
    
    
    
    if event and event.onEnter then
        event.onEnter ( source )
    end
    
    return true
end





function onLeave ( )
    local parent = guiGetElementParent ( source )
    local event = guiGetElementEvents ( source )
    
    setPointedElement ( source, false )
    
    guiResetInfoText ( )
    
    if event and event.onLeave then
        event.onLeave ( source )
    end

    return true
end





function onFocus ( )
    local parent = guiGetElementParent ( source )
    local event = guiGetElementEvents ( source )
    
    
    
    if event and event.onFocus then
        event.onFocus ( source )
    end
    
    return true
end





function onBlur ( )
    local parent = guiGetElementParent ( source )
    local event = guiGetElementEvents ( source )
    
    
    
    if event and event.onBlur then
        event.onBlur ( source )
    end
    
    return true
end





function onEditBoxAccept ( box )
    local parent = guiGetElementParent ( source )
    local event = guiGetElementEvents ( box )
    
    
    
    if box == openedEditBox then
        
        if isElement ( pVehicle ) then
        
            local content = guiGetText ( box )
            
            destroyEditBox ( )
            
            local property = guiGetElementProperty ( hiddenEditBox )
            
            prepareHandlingValue ( pVehicle, property, content )
        
        else
            
            -- when not vehicle
            
        end
        
    end

    if event and event.onEditBoxAccept then
        event.onEditBoxAccept ( box )
    end
    
    return true
end





function onComboBoxAccept ( )
    local parent = guiGetElementParent ( source )
    local event = guiGetElementEvents ( source )
    local property = guiGetElementProperty ( source )
    
    
    if parent == "viewItem" and property then
        
        if pVehicle then
        
            local selected = guiComboBoxGetSelected ( source )
            
            if selected > -1 then
            
                local text = guiComboBoxGetItemText ( source, selected )
                local value = nil
                if handlingLimits[property] and handlingLimits[property].options then
                    value = handlingLimits[property].options[selected+1]
                end
                
                prepareHandlingValue ( pVehicle, property, value )
                
            end
        
        end
        
    end
    
    if event and event.onComboBoxAccept then
        event.onComboBoxAccept ( source )
    end
    
    return true
end