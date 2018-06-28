markers = {
{738.16907, -1350.31812, 12.97104},
{738.16907, -1344.82898, 12.97104},
{738.16907, -1338.82898, 12.97104},
}
if buildMarkers then
	buildMarkers()
end

local Ogloszenia = {
{738.16907, -1350.31812, 14, "Обмен номерами"},
{738.16907, -1344.82898, 14, "Обмен номерами"},
{738.16907, -1338.82898, 14, "Обмен номерами"},
}

addEventHandler("onClientRender", root, function()
    local rx,ry,rz = getCameraMatrix()
    
    for i,v in ipairs(Ogloszenia) do
        local x,y,z = getElementPosition(localPlayer)
        local distance = getDistanceBetweenPoints3D(rx,ry,rz,v[1],v[2],v[3])
        if distance <= 25 then
            local sx,sy = getScreenFromWorldPosition(v[1],v[2],v[3], 0.06)
            if sx and sy then
                if sx and sy then
                    dxDrawText(v[4], sx, sy, sx, sy, tocolor(0, 0, 0, 255), 1.20, "default", "center", "center", false, false, true, false, false)
                    dxDrawText(v[4], sx, sy-2, sx, sy-2, tocolor(0, 0, 0, 255), 1.20, "default", "center", "center", false, false, true, false, false)
                    dxDrawText(v[4], sx-2, sy, sx-2, sy, tocolor(0, 0, 0, 255), 1.20, "default", "center", "center", false, false, true, false, false)
                    dxDrawText(v[4], sx-2, sy, sx-2, sy-2, tocolor(0, 0, 0, 255), 1.20, "default", "center", "center", false, false, true, false, false)
                    dxDrawText(v[4], sx-1, sy-1, sx-1, sy-1, tocolor(255, 255, 255, 255), 1.20, "default", "center", "center", false, false, true, false, false)
                end
            end
        end
    end
end)