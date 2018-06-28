positionVeh = {
{596, 1595.1999511719, -1710.4025878906, 5.640625, 0, 0, 0, "A7701"},
{596, 1591.5999511719, -1710.4025878906, 5.640625, 0, 0, 0, "A7702"},
{596, 1574.2028198242, -1710.4025878906, 5.640625, 0, 0, 0, "A7703"},
{596, 1578.2028198242, -1710.4025878906, 5.640625, 0, 0, 0, "A7704"},
{596, 1583.5000000000, -1710.4025878906, 5.640625, 0, 0, 0, "A7705"},
{596, 1583.5000000000, -1710.4025878906, 500.640625, 0, 0, 0, "A7706"},
{596, 1583.5000000000, -1710.4025878906, 500.640625, 0, 0, 0, "A7707"},
{596, 1587.7005953120, -1710.4025878906, 5.640625, 0, 0, 0, "A7708"},
{596, 1570.2028198242, -1710.4025878906, 5.640625, 0, 0, 0, "A7709"},
{596, 1528.5870361328, -1683.6721191406, 5.640625, 0, 0, 270, "A7710"},
{596, 1528.5870361328, -1687.6721191406, 5.640625, 0, 0, 270, "A7711"},
{596, 1601.8604736328, -1704.6721191406, 5.640625, 0, 0, 90, "A7712"},
{596, 1601.8604736328, -1700.6721191406, 5.640625, 0, 0, 90, "A7713"},
{596, 1534.5232391357, -1644.6711425781, 5.640625, 0, 0, 180, "A7714"},
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
		if string.find (j, "policeCar") then
			if getElementData (v, j) == k then
				return v
			end
		end
	end
end
end

function getPlayerKluch (pl)
for i, v in pairs (getAllElementData(pl)) do
	if string.find (i, "KluchLSPD00") and v == true then
		print (i)
		return i
	end
end
end

function getNumVeh (index)
print (tostring(positionVeh[index][8]))
end

function getFreeSeat (veh)
assert(getElementType (veh) == "vehicle", "Bad argument 1 @ getFreeSeat (element expected, got " .. type(veh) .. ")")
for i = 1, getVehicleMaxPassengers (veh) do
	if not getVehicleOccupant (veh, i) then
		return i
	end
end
end

controlTable = { "fire", "aim_weapon", "next_weapon", "previous_weapon", "forwards", "backwards", "left", "right", "zoom_in", "zoom_out",
 "change_camera", "jump", "sprint", "look_behind", "crouch", "action", "walk", "conversation_yes", "conversation_no",
 "group_control_forwards", "group_control_back", "enter_exit", "vehicle_fire", "vehicle_secondary_fire", "vehicle_left", "vehicle_right",
 "steer_forward", "steer_back", "accelerate", "brake_reverse", "radio_next", "radio_previous", "radio_user_track_skip", "horn", "sub_mission",
 "handbrake", "vehicle_look_left", "vehicle_look_right", "vehicle_look_behind", "vehicle_mouse_look", "special_control_left", "special_control_right",
 "special_control_down", "special_control_up" }