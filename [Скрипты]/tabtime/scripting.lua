--[[
RegarDs Robin [SGC] Social Gaming CommuniTy :D Enjoy The Script
]]
exports.scoreboard:addScoreboardColumn('Наигранно')

local t = { }
 
function checkValues( source,arg1,arg2)
    if (arg2 >= 60) then
        t[ source ][ 'min' ] = tonumber( t[ source ][ 'min' ] or 0 ) + 1
        t[ source ][ 'sec' ] = 0
    end
    if (arg1 >= 60) then
        t[ source ][ 'min' ] = 0
        t[ source ][ 'hours' ] = tonumber( t[ source ][ 'hours' ] or 0 ) + 1
    end
    return arg1, arg2
end
     
setTimer(
    function( )
        for _, v in pairs( getElementsByType( "player" ) ) do
            if (not t[ v ]) then
                t[ v ] = {
                            ["hours"] = 0,
                             ["min"] = 0,
                             ["sec"] = 0
                            }
            end
 
            t[ v ][ 'sec' ] = tonumber( t[ v ][ 'sec' ] or 0 ) + 1
            local min,sec = checkValues (
                    v,
                    t[ v ][ 'min' ] or 0,
                    t[ v ][ 'sec' ] or 0
						)  
	local hours = tonumber( t[ v ][ 'hours' ] or 0 )

            setElementData(
                v,
                "Наигранно",
                tostring( hours ) .. ' Hours '
            )
        end
    end,
    1000, 0
)
   
function onPlayerQuit ( )
    local playeraccount = getPlayerAccount ( source )
    if ( playeraccount ) and not isGuestAccount ( playeraccount ) then
        local sValue = getElementData( source,'Наигранно' )
	local hours = tonumber( t[ source ][ 'hours' ] or 0 )
	local min = tonumber( t[ source ][ 'min' ] or 0 )
	local sec = tonumber( t[ source ][ 'sec' ] or 0 )
        setAccountData ( playeraccount, "Наигранно-hours", tostring(hours) )
        setAccountData ( playeraccount, "Наигранно-min", tostring(min) )
        setAccountData ( playeraccount, "Наигранно-sec", tostring(sec) )
        setAccountData ( playeraccount, "Наигранно", tostring(sValue) )

    end
    t[ source ] = nil
end
 
function onPlayerLogin (_, playeraccount )
    if ( playeraccount ) then
        local time = getAccountData ( playeraccount, "Наигранно" )
	local hou = getAccountData ( playeraccount, "Наигранно-hours")
	local min = getAccountData ( playeraccount, "Наигранно-min")
	local sec = getAccountData ( playeraccount, "Наигранно-sec")
        if ( time ) then
            setElementData ( source, "Наигранно", time )

                             t[ source ]["hours"] = tonumber(hou)
                             t[ source ]["min"] = tonumber(min)
                             t[ source ]["sec"] = tonumber(sec)
                else
            setElementData ( source, "Наигранно",0 )
            setAccountData ( playeraccount, "Наигранно",0 )
        end
    end
end
addEventHandler ( "onPlayerQuit", root, onPlayerQuit )
addEventHandler ( "onPlayerLogin", root, onPlayerLogin )