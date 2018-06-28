addEventHandler ( "onPlayerCommand", root, 
     function ( cmd ) 
         if ( cmd == "logout" ) then 
             cancelEvent ( ) 
         end 
     end 
 )