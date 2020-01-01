--------------------
-- autor: Hizard  --
-- date: 29/10/13 --
--------------------

race = {}
race.__index = race

function race.pickupHit( Element, Dimensions )
	--// Pickup Hit Clientside
	if ( Element == getLocalPlayer() ) then
		if ( getPedOccupiedVehicle( Element ) ) then
			triggerServerEvent("race:pickupHit", getRootElement(), getPedOccupiedVehicle( Element ), getElementData( source, "type" ), getElementData( source, "changeTo" ))
			playSoundFrontEnd ( 46 )
		end
	end
end
addEventHandler("onClientColShapeHit", getRootElement(), race.pickupHit)