helpwindow = guiCreateWindow(241, 123, 934, 547, " • Информация • ", false)
guiWindowSetSizable(helpwindow, false)

helpmemo = guiCreateMemo(200, 18, 725, 520, "", false, helpwindow)
guiMemoSetReadOnly(helpmemo, true)
adminsbtn = guiCreateButton(9, 20, 186, 38, "• Персонал •", false, helpwindow)
guiSetProperty(adminsbtn, "NormalTextColour", "FF8B008B")
commandsbtn = guiCreateButton(9, 69, 186, 38, "• FAQ •", false, helpwindow)
guiSetProperty(commandsbtn, "NormalTextColour", "FF0000FF")
infbtn = guiCreateButton(9, 120, 186, 38, "• Донат •", false, helpwindow)
guiSetProperty(infbtn, "NormalTextColour", "FF00BFFF")
--guiSetProperty(hombtn, "NormalTextColour", "FFFFFFFF")
guiSetVisible(helpwindow, false)
rulesbtn = guiCreateButton(9, 171, 186, 38, "• Правила для админов •", false, helpwindow)
guiSetProperty(rulesbtn, "NormalTextColour", "FF00FF00")
rulebtn = guiCreateButton(9, 222, 186, 38, "• Правила для игроков •", false, helpwindow)
guiSetProperty(rulebtn, "NormalTextColour", "FFFFD700")
rulbtn = guiCreateButton(9, 273, 186, 38, "• Правила для полиции •", false, helpwindow)
guiSetProperty(rulbtn, "NormalTextColour", "FFFFA500")
rubtn = guiCreateButton(9, 324, 186, 38, "• Правила для Гл админов •", false, helpwindow)
guiSetProperty(rubtn, "NormalTextColour", "FFFF0000")
--close1 = guiCreateButton (9, 380, 186, 38, "Закрыть", false, helpwindow)
--guiSetProperty(close1, "NormalTextColour", "FF9933ff")

function open() 
if (guiGetVisible (helpwindow) == false) then 
guiSetVisible(helpwindow, true) 
showCursor(true) 
local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(helpwindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(helpwindow,x,y,false)
--centerWindow(helpwindow)
elseif (guiGetVisible (helpwindow) == true) then 
guiSetVisible(helpwindow, false) 
showCursor(false) 
end 
end 
bindKey ("F9", "down", open)


function rules ()
rulestxt = fileOpen("Rules.txt", true)
rulestxt1 = fileRead(rulestxt, 50000)
guiSetText(helpmemo, rulestxt1)
end
addEventHandler("onClientGUIClick", rulesbtn, rules)

function rule ()
rulestxt = fileOpen("Rule.txt", true)
rulestxt1 = fileRead(rulestxt, 50000)
guiSetText(helpmemo, rulestxt1)
end
addEventHandler("onClientGUIClick", rulebtn, rule)

function rul ()
rulestxt = fileOpen("Rul.txt", true)
rulestxt1 = fileRead(rulestxt, 50000)
guiSetText(helpmemo, rulestxt1)
end
addEventHandler("onClientGUIClick", rulbtn, rul)

function ru ()
rulestxt = fileOpen("Ru.txt", true)
rulestxt1 = fileRead(rulestxt, 50000)
guiSetText(helpmemo, rulestxt1)
end
addEventHandler("onClientGUIClick", rubtn, ru)

function commands ()
rulestxt = fileOpen("Commands.txt", true)
rulestxt1 = fileRead(rulestxt, 50000)
guiSetText(helpmemo, rulestxt1)
end
addEventHandler("onClientGUIClick", commandsbtn, commands)

function information ()
rulestxt = fileOpen("Information.txt", true)
rulestxt1 = fileRead(rulestxt, 50000)
guiSetText(helpmemo, rulestxt1)
end
addEventHandler("onClientGUIClick", infbtn, information)

function admins ()
rulestxt = fileOpen("Admins.txt", true)
rulestxt1 = fileRead(rulestxt, 50000)
guiSetText(helpmemo, rulestxt1)
end
addEventHandler("onClientGUIClick", adminsbtn, admins)