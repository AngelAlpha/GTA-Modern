positionVeh = {
{433, 275.20281982422, 1946.4025878906, 17.640625, 0, 0, 270, "0001AA"},
{433, 275.20281982422, 1952.4025878906, 17.640625, 0, 0, 270, "0002AA"},
{433, 275.20281982422, 1958.4025878906, 17.640625, 0, 0, 270, "0003AA"},
{433, 275.20281982422, 1964.4025878906, 17.640625, 0, 0, 270, "0004AA"},
{433, 275.20281982422, 1983.4025878906, 17.640625, 0, 0, 270, "0005AA"},
{433, 275.20281982422, 1992.4025878906, 17.640625, 0, 0, 270, "0006AA"},
{422, 275.20281982422, 2013.4025878906, 17.640625, 0, 0, 270, "0007AA"},
{422, 275.20281982422, 2019.4025878906, 17.640625, 0, 0, 270, "0008AA"},
{422, 275.20281982422, 2025.4025878906, 17.640625, 0, 0, 270, "0009AA"},
{422, 275.20281982422, 2031.4025878906, 17.640625, 0, 0, 270, "0010AA"},
{500, 225.78205871582, 1879.2763671875, 17.640625, 0, 0, 0, "0011AA"},
{500, 201.78205871582, 1879.2763671875, 17.640625, 0, 0, 0, "0012AA"},
{487, 177.682312011722, 1929.6711425781, 17.640625, 0, 0, 180, "0013AA"},
{487, 244.52323913574, 1925.6711425781, 17.640625, 0, 0, 180, "0014AA"},
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
local symb1 = smb[math.random(1000, #smb)]
local symb2 = math.random(1000, 9999)
num = symb1..symb2..(tostring(reg))
return num
end

function getVehFromKluch (k)
for i, v in ipairs (getElementsByType ("vehicle")) do
	for j, m in pairs (getAllElementData(v)) do
		if string.find (j, "LVACar") then
			if getElementData (v, j) == k then
				return v
			end
		end
	end
end
end

function getPlayerKluch (pl)
for i, v in pairs (getAllElementData(pl)) do
	if string.find (i, "KluchLVA00") and v == true then
		return i
	end
end
end