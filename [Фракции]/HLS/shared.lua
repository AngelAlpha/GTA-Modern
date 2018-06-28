positionVeh = {
{416, 1180.20281982422, -1338.4025878906, 13.640625, 0, 0, 270, "X235AT"},
{416, 1123.3420410156, -1328.3072509766, 13.306810379028, 0, 0, 0, "A235TT"},
{416, 1097.3420410156, -1328.3072509766, 13.306810379028, 0, 0, 0, "E125AX"},
{416, 1110.3420410156, -1328.3072509766, 13.306810379028, 0, 0, 0, "A525YT"},
{416, 1180.0279541016, -1308.5598144531, 13.814081192017, 0, 0, 270, "E521EY"},
}

smb =
{
	'A',
	'B',
	'C',
	'Y',
	'O',
	'P',
	'T',
	'E',
	'X',
	'M',
	'H',
	'K'
}

function generateNumbers (reg)
local num = ""
local symb1 = smb[math.random(1, #smb)]
local symb2 = math.random(1000, 9999)
num = symb1..symb2..(tostring(reg))
return num
end

function getVehFromKluch (k)
for i, v in ipairs (getElementsByType ("vehicle")) do
	for j, m in pairs (getAllElementData(v)) do
		if string.find (j, "hospitalCar") then
			if getElementData (v, j) == k then
				return v
			end
		end
	end
end
end

function getPlayerKluch (pl)
for i, v in pairs (getAllElementData(pl)) do
	if string.find (i, "KluchHLS00") and v == true then
		return i
	end
end
end

function getNumVeh (index)
print (tostring(positionVeh[index][8]))
end