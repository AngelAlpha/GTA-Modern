local dataTable = {
    "cars",
	"passangers",
	"moto",
	"gruz"
}

function onResourceStart ()
    db = dbConnect( "sqlite", "save/database.db" ) --Создание подключения типа sqlite, используется для хранения на локльном диске (хосте)
	dbExec(db, "CREATE TABLE IF NOT EXISTS autoschool (data, login)") --Создание таблицы с названием autoschool, в скобках названия всех ячеек, нужных тебе
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), onResourceStart)

function savePlayerData (player)
	local lic_cars = (getElementData(player, dataTable[1]) or false)
	local lic_pass = (getElementData(player, dataTable[2]) or false)
	local lic_moto = (getElementData(player, dataTable[3]) or false)
	local lic_gruz = (getElementData(player, dataTable[4]) or false)
	playerData = {lic_cars, lic_pass, lic_moto, lic_gruz}

	local account = getAccountName(getPlayerAccount(player))
	local query = dbQuery(db,"SELECT * FROM autoschool WHERE login = ?", account) --Ищем в таблице autoschool в ячейке логинов ячейку с именем аккаунта из пред. строки
    local result = dbPoll(query, -1) --Преобразуем пред.строку в обыкновенную строку, которую видит lua
	if #result ~= 0 then --Если запись уже существует
	    dbExec(db, "UPDATE autoschool SET data = ? WHERE login = ? ", toJSON(playerData), account) --Т.к. запись есть, обновленяем таблицу autoschool, ячейку data, где логин = ?
	else
	    dbExec(db, "INSERT INTO autoschool VALUES(?, ?)", toJSON(playerData), account) --Т.к. запись не найдена, добавляем новую строку с нашим игроков в таблицу
	end
end

function loadPlayerData (player)
    local account = getAccountName(getPlayerAccount(player))
    local query = dbQuery(db,"SELECT * FROM autoschool WHERE login = ?", account) --Ищем в таблице autoschool в ячейке логинов ячейку с именем аккаунта из пред. строки
    local result = dbPoll(query, -1) --Преобразуем пред.строку в обыкновенную строку, которую видит lua
	if #result ~= 0 then --Если запись уже существует
	    local data = result[1]["data"] --Берем ячейку [data] нашего игрока
		local data = fromJSON(data)
	    setElementData(player, dataTable[1], data[1])
		setElementData(player, dataTable[2], data[2])
		setElementData(player, dataTable[3], data[3])
		setElementData(player, dataTable[4], data[4])
	else
	    setElementData(player, dataTable[1], false)
		setElementData(player, dataTable[2], false)
		setElementData(player, dataTable[3], false)
		setElementData(player, dataTable[4], false)
	end
end

function onPlayerLogin ()
    loadPlayerData (source)
end
addEventHandler("onPlayerLogin", getRootElement(), onPlayerLogin)

function onPlayerQuit ()
    savePlayerData (source)
end
addEventHandler("onPlayerQuit", getRootElement(), onPlayerQuit)

function onResourceStart ()
    for i, player in ipairs (getElementsByType("player")) do
	    loadPlayerData (player)
	end
end
addEventHandler("onResourceStart", getResourceRootElement( getThisResource() ), onResourceStart)

function onResourceStop ()
    for i, player in ipairs (getElementsByType("player")) do
	    savePlayerData (player)
	end
end
addEventHandler("onResourceStop", getResourceRootElement( getThisResource() ), onResourceStop)