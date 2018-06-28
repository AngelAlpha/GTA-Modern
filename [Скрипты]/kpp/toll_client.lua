
local enableImpulses = true     -- If set to false players will not be able to purchase impulses
-- End of settings

function centerTollGUI (theWindow)
    local screenW, screenH = guiGetScreenSize ()
    local windowW, windowH = guiGetSize (theWindow,false)
    local x, y = (screenW - windowW) / 2, (screenH - windowH) / 2
    guiSetPosition (theWindow, x, y, false)
end

-- Toll GUI
local tollGUI = guiCreateStaticImage(100,100,650,650,'img/1.png',false)
centerTollGUI (tollGUI)
guiWindowSetMovable(tollGUI,false)
guiWindowSetSizable(tollGUI,false)
guiSetVisible (tollGUI, false)

local tollinfo = guiCreateStaticImage(70,430,500,30,'img/b.png',false,tollGUI)
local tollinfoPrice = guiCreateLabel(0, 0, 0, 0,"",true,tollGUI)
local tollPay = guiCreateStaticImage(200,470,250,80,'img/opl.png',false,tollGUI)

local tollClose = guiCreateStaticImage(550,100,50,50,'img/k.png',false,tollGUI)
-- Impulses GUI
local impulsesGUI = guiCreateWindow(0.31, 0.24, 0.35, 0.22, "Купить абонемен", true)
guiWindowSetSizable(impulsesGUI, false)
guiWindowSetMovable(impulsesGUI,false)
guiSetVisible (impulsesGUI, false)
centerTollGUI (impulsesGUI)
local impulsesAdd = guiCreateButton(0.18, 0.21, 0.65, 0.20, "Купить", true, impulsesGUI)
local impulsesCurrent = guiCreateMemo(0.39, 0.49, 0.16, 0.20, "0", true, impulsesGUI)
guiMemoSetReadOnly(impulsesCurrent, true)
local impulsesInfo = guiCreateLabel(0.25, 0.53, 0.13, 0.11, "Кол.:", true, impulsesGUI)
local impulsesRemove = guiCreateButton(0.19, 0.72, 0.65, 0.20, "Удалить один", true, impulsesGUI)
local impulsesClose = guiCreateButton(0.90, 0.14, 0.08, 0.15, "X", true, impulsesGUI)    

addEvent ("manageTollGUI", true)
addEventHandler ("manageTollGUI", root,
    function (state, tollPrice, guest)
        tollPrice = tonumber (tollPrice)
        if state == 1 then
            if not guiGetVisible (tollGUI) then
                guiSetVisible (tollGUI, true)
                showCursor (true)
                guiSetText (tollinfoPrice, tostring (tollPrice))
                guiSetText (impulsesAdd, "Добавить один ($"..tollPrice..")")
                guiSetText (impulsesCurrent, "0")
                if enableImpulses == false or guest then
                    guiSetEnabled (tollImpulses, false)
                elseif enableImpuses == true then
                    guiSetEnabled (tollImpulses, true)
                end
            end
        elseif state == 2 then
            if guiGetVisible (tollGUI) then
                guiSetVisible (tollGUI, false)
                showCursor (false)
            end
        end
    end
)

-- Handles GUI Clicks
addEventHandler ("onClientGUIClick", root,
    function (button, state)
        if button == "left" and state == "up" then
            if source == tollPay then
                local vehicleController = getVehicleController (getPedOccupiedVehicle (localPlayer))
                if vehicleController == localPlayer and getPlayerMoney (vehicleController) < tonumber (guiGetText (tollinfoPrice)) then 
                    outputChatBox ("У вас не достаточно денег.", 255, 0, 0)
                    guiSetVisible (tollGUI, false)
                    showCursor (false)
                else
                    triggerServerEvent ("tollPaid", localPlayer)
                    playSoundFrontEnd (5)
                    guiSetVisible (tollGUI, false)
                    showCursor (false)
                end
            elseif source == tollClose then
                guiSetVisible (tollGUI, false)
                showCursor (false)
            elseif source == tollImpulses then
                guiSetVisible (tollGUI, false)
                guiSetVisible (impulsesGUI, true)
            elseif source == impulsesClose then
                guiSetVisible (tollGUI, true)
                guiSetVisible (impulsesGUI, false)
            elseif source == impulsesAdd then
                if getPlayerMoney (getVehicleController (getPedOccupiedVehicle (localPlayer))) < tonumber (guiGetText (tollinfoPrice)) then
                outputChatBox ("У вас не достаточно средств!", 255, 255, 255)
                    guiSetVisible (impulsesGUI, false)
                    showCursor (false)
                else
                    triggerServerEvent ("manageImpulses", localPlayer, 1)
                    guiSetText (impulsesCurrent, tonumber (guiGetText (impulsesCurrent)) + 1)
                end
            elseif source == impulsesRemove then
                if getVehicleController (getPedOccupiedVehicle (localPlayer)) == localPlayer then
                    if tonumber (guiGetText (impulsesCurrent)) > 0 then
                        guiSetText (impulsesCurrent, tonumber (guiGetText (impulsesCurrent)) - 1)
                        triggerServerEvent ("manageImpulses", localPlayer, 2)
                    end
                end
            end
        end
    end
)

