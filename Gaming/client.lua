--------------------
-- autor: Hizard  --
-- date: 30/10/13 --
--------------------

addEvent("arena:createMap", true)
addEventHandler("arena:createMap", getRootElement(),
	function( Objects, Pickups, Markers )
		outputChatBox( "OK" )
		for _, _object in ipairs ( Objects ) do
			local obj = createObject( _object[1], _object[2], _object[3], _object[4], _object[5], _object[6], _object[7] )
			if ( _object[10] ) then
				setObjectScale( obj, _object[10] )
			end
			
			setElementDimension( obj, _object[11] )
			
			if ( _object[9] and _object[9] == "false" ) then 
				setElementCollisionsEnabled( obj, false ) 
			end		
		
			--if ( object[8] ) then 
			--	setElementAlpha( obj, object[8] ) 
			--end
		end
		
		for _, _pickup in ipairs ( Pickups ) do
			local col = createColSphere( _pickup[3], _pickup[4], _pickup[5], 3.0 )
			setElementDimension( col, _pickup[6] )
			if ( _pickup[1] == "nitro" ) then
				local pick = createObject( 2221, _pickup[3], _pickup[4], _pickup[5] )
				setElementData( col, "type", "nitro" )
				setElementDimension( pick, _pickup[6] )
			elseif ( _pickup[1] == "repair" ) then
				local pick = createObject( 2222, _pickup[3], _pickup[4], _pickup[5] )
				setElementData( col, "type", "repair" )
				setElementDimension( pick, _pickup[6] )
			elseif ( _pickup[1] == "vehiclechange" ) then
				local pick = createObject( 2223, _pickup[3], _pickup[4], _pickup[5] )
				setElementDimension( pick, _pickup[6] )
				setElementData( col, "type", "vehchange" )
				setElementData( col, "changeTo", _pickup[2] )
			end
		end
	end
)