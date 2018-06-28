db = nil
function initDatabase()
	db = dbConnect("sqlite", "database.db")
	--dbExec(db, "DROP TABLE Vehicles")
	dbExec(db, "CREATE TABLE IF NOT EXISTS database (id, acc, level, reason, time)")
end
initDatabase()

function getFreeID()
	local result = dbPoll(dbQuery(db, "SELECT id FROM database ORDER BY id ASC"), -1)
	newID = false
	for i, id in pairs (result) do
		if id["id"] ~= i then
			newID = i
			break
		end
	end
	if newID then return newID else return #result + 1 end
end

function databaseW ()
local result = dbPoll(dbQuery(db, "SELECT * FROM database ORDER BY id ASC"), -1)
	triggerClientEvent (source, "write", source, result)
end
addEvent ("checkWanted", true)
addEventHandler ("checkWanted", root, databaseW)

function database (type, id, player, level, reason)
if type == "add" then
	local time = getCurrentTime ()
	local acc = getAccountName (getPlayerAccount(player))
	dbExec(db,"INSERT INTO database VALUES(?, ?, ?, ?, ?)", getFreeID(), acc, level, reason, time)
	databaseW ()
elseif type == "remove" then
	dbExec(db,"DELETE FROM database WHERE acc = ?", getAccountName (getPlayerAccount(player)))
	databaseW ()
elseif type == "update" then
	dbExec(db, "UPDATE database SET level = ? WHERE acc = ?", level, getAccountName(getPlayerAccount(player)))
	databaseW ()
end
end
addEvent ("database", true)
addEventHandler ("database", root, database)

function getCurrentTime ()
local data = getRealTime ()
local day = data.monthday
local mounth = data.month + 1
local year = data.year - 100
return day.."."..mounth.."."..year
end

--function login (_, acc)
function login (pl)
local acc = getPlayerAccount (pl)
local result = dbPoll(dbQuery(db, "SELECT level FROM database WHERE acc = ? ORDER BY level ASC", getAccountName(acc)), -1)
for i, v in ipairs (result) do
	setPlayerWantedLevel (getAccountPlayer(acc), v["level"])
end
end
addCommandHandler ("ls", login)
--addEventHandler ("onPlayerLogin", root, login)

function quit ()
local acc = getPlayerAccount (source)
if getPlayerWantedLevel (source) > 0 then
	local reason = getElementData (source, "wanted:reason")
	database ("update", _, source, getPlayerWantedLevel(source), reason)
end
end
addEventHandler ("onPlayerQuit", root, quit)

function save ()
for i, v in ipairs (getElementsByType ("player")) do
	if getPlayerWantedLevel (v) > 0 then
		local acc = getPlayerAccount (v)
		local reason = getElementData (v, "wanted:reason") or ""
		dbExec(db, "UPDATE database SET level = ?, reason = ? WHERE acc = ?", level, reason, acc)
	end
end	
end
setTimer (save, 1000*30, 0)


addEvent ("wantedLevel", true)
addEventHandler ("wantedLevel", root, function(pl, type)
if type == "add" then
	if not getElementData (source, "police:blipAdd") then
		setElementData (source, "police:blipAdd", true)
		setElementData (pl, "police:blip", createBlipAttachedTo (pl, 41, _, _, _, _, _, _, 200000, source))
	end
elseif type == "remove" then
	if getElementData (pl, "police:blip") ~= nil and getElementData (pl, "police:blip") ~= false then
		destroyElement (getElementData (pl, "police:blip"))
		setElementData (source, "police:blipAdd", false)
	end
end
end)