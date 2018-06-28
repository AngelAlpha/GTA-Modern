alpha = 255
r, g, b = 255, 255, 255
size = 1.5
typem = "cylinder"
posx1, posy1, posz1 = 359.5, 188.10000610352, 1007.0999755859
posx2, posy2, posz2 = 362.3, 188.10000610352, 1007.0999755859
posx3, posy3, posz3 = 365.2, 188.10000610352, 1007.0999755859

entradaLS1 = createMarker (posx1, posy1, posz1, typem, size, r, g, b, alpha)
entradaLS2 = createMarker (posx2, posy2, posz2, typem, size, r, g, b, alpha)
entradaLS3 = createMarker (posx3, posy3, posz3, typem, size, r, g, b, alpha)
setElementInterior (entradaLS1, 3)
setElementInterior (entradaLS2, 3)
setElementInterior (entradaLS3, 3)
setElementDimension (entradaLS1, 1)
setElementDimension (entradaLS2, 1)
setElementDimension (entradaLS3, 1)


entradaSF1 = createMarker (posx1, posy1, posz1, typem, size, r, g, b, alpha)
entradaSF2 = createMarker (posx2, posy2, posz2, typem, size, r, g, b, alpha)
entradaSF3 = createMarker (posx3, posy3, posz3, typem, size, r, g, b, alpha)
setElementInterior (entradaSF1, 3)
setElementInterior (entradaSF2, 3)
setElementInterior (entradaSF3, 3)
setElementDimension (entradaSF1, 2)
setElementDimension (entradaSF2, 2)
setElementDimension (entradaSF3, 2)


entradaLV1 = createMarker (posx1, posy1, posz1, typem, size, r, g, b, alpha)
entradaLV2 = createMarker (posx2, posy2, posz2, typem, size, r, g, b, alpha)
entradaLV3 = createMarker (posx3, posy3, posz3, typem, size, r, g, b, alpha)
setElementInterior (entradaLV1, 3)
setElementInterior (entradaLV2, 3)
setElementInterior (entradaLV3, 3)
setElementDimension (entradaLV1, 3)
setElementDimension (entradaLV2, 3)
setElementDimension (entradaLV3, 3)