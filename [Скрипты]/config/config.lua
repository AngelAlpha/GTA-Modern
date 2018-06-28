tableNo = {
"3dmarker",
"test",
"guieditor",
}


function checkRes (res)
local name = getResourceName (res)
local check = false
for i, v in ipairs (tableNo) do
	if name == v then
		check = true
	end
end
return check
end

function writeAllResNames()
fileDelete ("test.txt")
txt_file = fileCreate("test.txt")
RES = getResources() 
for i, resource in ipairs(RES) do 
if ( getResourceState(resource) == "running" ) then 
fileWrite(txt_file, '\n <resource src="'..getResourceName(resource)..'" startup="1" protected="0" /> ') 
--fileWrite(txt_file, '\n"'..getResourceName(resource)..'",') 
end 
end 
outputChatBox ("*Сохранение...")
fileWrite(txt_file, "\n") 
fileClose(txt_file) 
end 
addCommandHandler("writeResource",writeAllResNames)

function startRes(pl)
local RES1 = getResources()
outputChatBox ("Все ресурсы #00FF00запущены!", pl, 255, 200, 0, true)
	for i, resource1 in ipairs(RES1) do 
		if ( getResourceState(resource1) == "loaded" ) then
			if not checkRes (resource1) then
				startResource (resource1)
			end
		end 
	end 
end 
addCommandHandler("startResource",startRes)

function startResWC(pl)
local RES1 = getResources()
outputChatBox ("Все ресурсы #00FF00запущены (Кроме машин)!", pl, 255, 200, 0, true)
	for i, resource1 in ipairs(RES1) do 
		if ( getResourceState(resource1) == "loaded" ) then
			if string.match(string.lower(getResourceName (resource1)), "car") == "car" then
			else
				if not checkRes (resource1) then
					startResource (resource1)
				end
			end
		end 
	end 
end 
addCommandHandler("startResourceWithoutCar",startResWC)

function startRes(pl)
outputChatBox ("Все ресурсы #FF0000остановлены!", pl, 255, 200, 0, true)
local RES1 = getResources() 
	for i, resource1 in ipairs(RES1) do 
		if ( getResourceState(resource1) == "running" ) then
			if not checkRes (resource1) then
				startResource (resource1)
			end
		end 
	end 
end 
addCommandHandler("stopResource",startRes)

function startCar(pl)
outputChatBox ("Все машины #00FF00запущены!", pl, 255, 200, 0, true)
local res = getResources() 
	for i, resource in ipairs(res) do 
		if ( getResourceState(resource) == "loaded" ) then
			if string.find (string.lower(getResourceName(resource)), "car") then
				if not checkRes (resource) then
					startResource (resource)
				end
			end
		end 
	end 
end 
addCommandHandler("startResourceCar",startCar)

function stopCar(pl)
outputChatBox ("Все машины #FF0000остановлены!", pl, 255, 200, 0, true)
local res = getResources()
	for i, resource in ipairs(res) do 
		if ( getResourceState(resource) == "running" ) then
			if string.find (string.lower(getResourceName(resource)), "car") then
				if not checkRes (resource) then
					startResource (resource)
				end
			end
		end 
	end 
end 
addCommandHandler("stopResourceCar",stopCar)