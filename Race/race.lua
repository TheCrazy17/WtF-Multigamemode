--------------------
-- autor: Hizard  --
-- date: 29/10/13 --
--------------------

addEvent("race:pickupHit", true)
addEventHandler("race:pickupHit", getRootElement(),
	function( Vehicle, Pickup, changeTo )
		--// Pickup Hit Serverside
		if ( Pickup == "repair" ) then
			fixVehicle( Vehicle )
		elseif ( Pickup == "nitro" ) then
			addVehicleUpgrade( Vehicle, 1010 )
		elseif( Pickup == "vehchange" ) then
			if ( changeTo ~= "" ) then
				setElementModel( Vehicle, changeTo )
			end
		end
	end
)

addCommandHandler("spawn",
	function( player )
		spawnPlayer( player, 0, 0, 5 )
		fadeCamera( player, true )
		setCameraTarget( player, player )
	end
)