--------------------
-- autor: Hizard  --
-- date: 29/10/13 --
--------------------

addEventHandler("onClientRender", getRootElement(),
	function()
		--// Rotate Pickup
		for _, pickup in ipairs ( getElementsByType("object") ) do
			if ( getElementModel( pickup ) == 2221 or getElementModel( pickup ) == 2222 or getElementModel( pickup ) == 2223 ) then
				local prx, pry, prz = getElementRotation( pickup )
				setElementRotation( pickup, prx, pry, prz+5)
			end
		end
	end
)