handlingLimits = { 
    ["identifier"] = {
        id = 1,
        input = "string",
        limits = { "", "" },
    },
    ["mass"] = {
        id = 2,
        input = "float",
        limits = { "1.0", "10000.0" }
    },
    ["turnMass"] = {
        id = 3,
        input = "float",
        limits = { "0.0", "100000.0" }
    },
    ["dragCoeff"] = {
        id = 4,
        input = "float",
        limits = { "0.0", "25.0" }
    },
    ["centerOfMassX"] = {
        id = 5,
        input = "float",
        limits = { "-2", "2" }
    },
    ["centerOfMassY"] = {
        id = 6,
        input = "float",
        limits = { "-2", "2" }
    },
    ["centerOfMassZ"] = {
        id = 7,
        input = "float",
        limits = { "-2", "2" }
    },
    ["percentSubmerged"] = {
        id = 8,
        input = "integer",
        limits = { "1", "120" }
    },
    ["tractionMultiplier"] = {
        id = 9,
        input = "float",
        limits = { "0.0", "1.3" }
    },
    ["tractionLoss"] = {
        id = 10,
        input = "float",
        limits = { "0.0", "1.3" }
    },
    ["tractionBias"] = {
        id = 11,
        input = "float",
        limits = { "0.0", "1.0" }
    },
    ["numberOfGears"] = {
        id = 12,
        input = "integer",
        limits = { "1", "5" }
    },
    ["maxVelocity"] = {
        id = 13,
        input = "float",
        limits = { "0.1", "3000.0" }
    },
    ["engineAcceleration"] = {
        id = 14,
        input = "float",
        limits = { "0.0", "40.0" }
    },
    ["engineInertia"] = {
        id = 15,
        input = "float",
        limits = { "1.0", "150.0" }
    },
    ["driveType"] = {
        id = 16,
        input = "string",
        limits = { "", "" },
        options = { "f","r","4" }
    },
    ["engineType"] = {
        id = 17,
        input = "string",
        limits = { "", "" },
        options = { "p","d","e" }
    },
    ["brakeDeceleration"] = {
        id = 18,
        input = "float",
        limits = { "0.1", "20.0" }
    },
    ["brakeBias"] = {
        id = 19,
        input = "float",
        limits = { "0.0", "1.0" }
    },
    ["ABS"] = {
        id = 20,
        input = "boolean",
        limits = { "", "" },
        options = { "true","false" }
    },
    ["steeringLock"] = {
        id = 21,
        input = "float",
        limits = { "0.0", "100.0" }
    },
    ["suspensionForceLevel"] = {
        id = 22,
        input = "float",
        limits = { "0.0", "5.0" }
    },
    ["suspensionDamping"] = {
        id = 23,
        input = "float",
        limits = { "0.0", "5.0" }
    },
    ["suspensionHighSpeedDamping"] = {
        id = 24,
        input = "float",
        limits = { "0.0", "5.0" }
    },
    ["suspensionUpperLimit"] = {
        id = 25,
        input = "float",
        limits = { "-5.0", "5.0" }
    },
    ["suspensionLowerLimit"] = {
        id = 26,
        input = "float",
        limits = { "-5.0", "5.0" }
    },
    ["suspensionFrontRearBias"] = {
        id = 27,
        input = "float",
        limits = { "0.0", "1.0" }
    },
    ["suspensionAntiDiveMultiplier"] = {
        id = 28,
        input = "float",
        limits = { "0.0", "30.0" }
    },
    ["seatOffsetDistance"] = {
        id = 29,
        input = "float",
        limits = { "0.0", "20.0" }
    },
    ["collisionDamageMultiplier"] = {
        id = 30,
        input = "float",
        limits = { "1.0", "1.0" }
    },
    ["monetary"] = {
        id = 31,
        input = "integer",
        limits = { "0", "230195200" }
    },
    ["modelFlags"] = {
        id = 32,
        input = "hexadecimal",
        limits = { "", "" },
    },
    ["handlingFlags"] = {
        id = 33,
        input = "hexadecimal",
        limits = { "", "" },
    },
    ["headLight"] = {
        id = 34,
        input = "integer",
        limits = { "0", "3" },
        options = { 0,1,2,3 }
    },
    ["tailLight"] = {
        id = 35,
        input = "integer",
        limits = { "0", "3" },
        options = { 0,1,2,3 }
    },
    ["animGroup"] = {
        id = 36,
        input = "integer",
        limits = { "0", "30" }
    }
}

propertyID = {}
for k,v in pairs ( handlingLimits ) do
    propertyID[v.id] = k
end