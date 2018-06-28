numberTypes = 
{
	{"ru","Русские",true,"E777KX47"},
	{"ua","Украинские",true,"AA1234AA"},
	{"kz","Казахские",true,"123AA44"},
	{"by","Белоруские",true,"7777AB-7"},
	{"arm","Армянские",true,"10AB777"},
	{"police","Полицейские",false,"T123477"},
	{"black","Черные",false,"3506EK99"},
	{"bus","Автобусные",false,"АО12350"},
	{"c","Именные",false,"Something"}
}

numberSymbols =
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

local counterPrices = 
{
	[0] = 1000,
	[2] = 2000,
	[3] = 10000,
	[4] = 100000,
	[5] = 1000000,
	[6] = 10000000,
}

function getNumbersData(type)
	for k,v in pairs(numberTypes) do
		if v[1] == type or v[2] == type then
			return v
		end
	end
end

function isCorrectNumber(type,str)
	if type == "ru" then
		if string.find(str,"^([ABCEHKMOPTXY]%d%d%d[ABCEHKMOPTXY][ABCEHKMOPTXY])(%d%d+)$") and #str <= 9 then
			return true
		end
	elseif type == "ua" then
		if string.find(str,"^([ABCEHKMOPTXY][ABCEHKMOPTXY])(%d%d%d%d)([ABCEHKMOPTXY][ABCEHKMOPTXY])$" ) and #str <= 8 then
			return true
		end
	elseif type == "kz" then
		if string.find(str,"^(%d%d%d)(%a%a)(%d%d)$" ) and #str <= 7 then
			return true
		end
	elseif type == "by" then
		if string.find(str,"^(%d%d%d%d)([ABEIKMHOPCTX][ABEIKMHOPCTX][-])(%d)$" ) and #str <= 10 then
			return true
		end
	elseif type == "arm" then
		if string.find(str,"^(%d%d)(%a%a)(%d%d%d)$" ) and #str <= 10 then
			return true
		end
	elseif type == "police" then
		if string.find(str,"^([ABCEHKMOPTXY])(%d%d%d%d%d%d)$" ) and #str <= 8 then
			return true
		end
	elseif type == "bus" then
		if string.find(str,"^([ABCEHKMOPTXY][ABCEHKMOPTXY])(%d%d%d%d%d)$" ) and #str <= 7 then
			return true
		end
	elseif type == "black" then
		if string.find(str,"^(%d%d%d%d)([ABEIKMHOPCTX][ABEIKMHOPCTX])(%d%d)$" ) and #str <= 8 then
			return true
		end
	elseif type == "black" then
		if string.find(str,"^(%d%d%d%d)([ABEIKMHOPCTX][ABEIKMHOPCTX])(%d%d)$" ) and #str <= 8 then
			return true
		end
	elseif type == "c" then
		if utf8.len(str) <= 14 then
			return true
		end
	end
end

function countSymbols(str)
	for k,v in pairs(numberSymbols) do
		local _, count = string.gsub(str, v, "")
		if count > 1 then
			return count
		end
	end
end

function countNumbers(str)
	for i = 0,9 do
		local _, count = string.gsub(str, tostring(i), "")
		if count > 1 then
			return count 
		end
	end
end

function getNumberPrice(str)
	local sum1 = countSymbols(str) or 0
	local sum2 = countNumbers(str) or 0
	--outputChatBox(sum1.." "..sum2)
	return counterPrices[sum1]+counterPrices[sum2]
end