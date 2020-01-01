--------------------
-- autor: Hizard  --
-- date: 03/11/13 --
--------------------

notification = {}
notification.__index = notification

notification.saved = {}

function notification.add( theType, text ) --// theType: 1 = Success, 2 = Error, 3 = Information
	table.insert( notification.saved, { #notification.saved+1, theType, text, 255 } )
	setTimer( function()
		for _, note in ipairs ( notification.saved ) do
			if ( note ) then
				if ( note[1] == #notification.saved ) then
					table.remove( notification.saved, note[1] )
				end
			end
		end
	end, 6000, 1 )
end

addEventHandler("onClientRender", getRootElement(),
	function()
		image = 0.0
		text = 0.0
		for _, notification in ipairs ( notification.saved ) do
			local width = dxGetTextWidth( notification[3] )
			dxDrawImage( x*0.0, y*image, x*0.05+width, y*0.05, "Images/Notification/" .. notification[2] .. ".png", 0, 0, 0, tocolor( 255, 255, 255, 255 ), false )
			dxDrawText( notification[3], x*0.0, y*text, x*0.05+width, y*0.05, tocolor( 255, 255, 255, 255 ), 1.0, "default-bold", "center", "center" )
			image = image + 0.06
			text = text + 0.12
		end
	end
)

addEvent("server:note", true)
addEventHandler("server:note", getRootElement(), 
	function( theType, text )
		notification.add( theType, text )
	end
)