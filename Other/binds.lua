local visibility = "visible"
bindKey("o", "down",
	function()
		if ( visibility == "visible" ) then
			visibility = "faded"
			notification.add("info", "The vehicles are half faded now")
		elseif ( visibility == "faded" ) then
			visibility = "hidden"
			notification.add("info", "The vehicles are hidden now")
		elseif ( visibility == "hidden" ) then
			visibility = "visible"
			notification.add("info", "The vehicles are visible now")
		end
	end
)