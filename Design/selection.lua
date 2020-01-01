local x, y = guiGetScreenSize()
local gothic = dxCreateFont("Fonts/GOTHIC.ttf", 20)
local curArena = "Deathmatch"
local image = 0.41
local arenaActive = false
DXALPHA1, DXALPHA2 = 0, 0 -- 255, 150

addEventHandler("onClientRender", getRootElement(),
	function()
		dxDrawText( "Use the left and right arrow key to switch gamemodes and the enter key to join an arena", x*0.001, y*0.0501, x*1.0, y*0.1, tocolor( 0, 0, 0, DXALPHA2 ), 0.801, gothic, "center", "top")
		dxDrawText( "Use the left and right arrow key to switch gamemodes and the enter key to join an arena", x*0.0, y*0.05, x*1.0, y*0.1, tocolor( 255, 120, 0, DXALPHA1 ), 0.8, gothic, "center", "top")
		
		dxDrawImage( x*0.0, y*0.94, x*0.098, y*0.06, "Images/Selection/time.png", 0, 0, 0, tocolor( 255, 255, 255, DXALPHA1 ), false )
		dxDrawImage( x*0.0, y*0.28, x*1.0, y*0.7, "Images/Selection/background.png", 0, 0, 0, tocolor( 255, 255, 255, DXALPHA1 ), false )
		dxDrawImage( x*image, y*0.448, x*0.18, y*0.33, "Images/Selection/" .. curArena .. ".png", 0, 0, 0, tocolor( 255, 255, 255, DXALPHA1 ), false )
		
		if ( #getElementsByType("player") == 1 ) then
			dxDrawText( #getElementsByType("player") .. " player is currently online", x*0.001, y*0.8803, x*1.0, y*0.1, tocolor( 0, 0, 0, DXALPHA2 ), 0.8, gothic, "center", "top")
			dxDrawText( #getElementsByType("player") .. " player is currently online", x*0.0, y*0.88, x*1.0, y*0.1, tocolor( 255, 120, 0, DXALPHA1 ), 0.8, gothic, "center", "top")
		else
			dxDrawText( #getElementsByType("player") .. " player are currently online", x*0.002, y*0.8803, x*1.0, y*0.1, tocolor( 0, 0, 0, DXALPHA2 ), 0.8, gothic, "center", "top")
			dxDrawText( #getElementsByType("player") .. " player are currently online", x*0.0, y*0.88, x*1.0, y*0.1, tocolor( 255, 120, 0, DXALPHA1 ), 0.8, gothic, "center", "top")
		end
		
		local num = ""
		if ( getRealTime().minute < 10 ) then num = "0" end
		
		dxDrawText( getRealTime().hour .. ":" .. num .. getRealTime().minute, x*0.02, y*0.954, x*0.098, y*0.06, tocolor( 255, 120, 0, DXALPHA1 ), 0.8, gothic, "center", "top")
	end
)

function selection_toggle()
	if ( DXALPHA1 == 255 ) then
		DXALPHA1, DXALPHA2 = 0, 0
		alpha["Background"] = 0
		alpha["Logo"] = 0
		showCursor( false )
	else
		DXALPHA1, DXALPHA2 = 255, 150
		alpha["Background"] = 255
		alpha["Logo"] = 255
		showCursor( true )
	end
end
bindKey("F1", "down", selection_toggle)

function selection_hide()
	if ( DXALPHA1 == 255 ) then
		DXALPHA1, DXALPHA2 = 0, 0
		alpha["Background"] = 0
		alpha["Logo"] = 0
		showCursor( false )
	end
end
addEvent("selection:hide", true)
addEventHandler("selection:hide", getRootElement(), selection_hide)



bindKey("arrow_r", "down",
	function()
		if ( DXALPHA1 == 255 ) then
			if ( curArena == "Deathmatch" ) then
				curArena = "Destruction"
			elseif ( curArena == "Destruction" ) then
				curArena = "Hunter"
			elseif ( curArena == "Hunter" ) then
				curArena = "Training"
			elseif ( curArena == "Training" ) then
				curArena = "Deathmatch"
			end	
		end
	end
)

bindKey("arrow_l", "down",
	function()
		if ( DXALPHA1 == 255 ) then
			if ( curArena == "Deathmatch" ) then
				curArena = "Training"
			elseif ( curArena == "Destruction" ) then
				curArena = "Deathmatch"
			elseif ( curArena == "Hunter" ) then
				curArena = "Destruction"
			elseif ( curArena == "Training" ) then
				curArena = "Hunter"
			end
		end
	end
)

bindKey("enter", "down",
	function()
		if ( DXALPHA1 == 255 ) then
			triggerServerEvent("arena:select", getRootElement(), getLocalPlayer(), curArena)
		end
	end
)