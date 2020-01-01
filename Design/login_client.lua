--------------------
-- autor: Hizard  --
-- date: 02/11/13 --
--------------------

local x, y = guiGetScreenSize()
isLoginActive = false
alpha = {
	["Background"] = 0,
	["Logo"] = 0,
	["Login_Window"] = 0,
	["Login_News"] = 0,
	["Login_Button"] = 0,
	["Login_Guest"] = 0,
	["Login_User_Edit"] = 0,
	["Login_Pass_Edit"] = 0
}
local rotation = {
	["Logo"] = 0
}

local LogoDirection = "right" 
addEventHandler("onClientRender", getRootElement(),
	function()
		dxDrawImage( x*0.0, y*0.0, x*1.0, y*1.0, "Images/Login/background.png", 0, 0, 0, tocolor( 255, 255, 255, alpha["Background"] ), false )
		dxDrawImage( x*0.35, y*0.1, x*0.3, y*0.3, "Images/logo.png", rotation["Logo"], 0, 0, tocolor( 255, 255, 255, alpha["Logo"] ) )
		dxDrawImage( x*0.29, y*0.4, x*0.43, y*0.48, "Images/Login/login_window.png", 0, 0, 0, tocolor( 255, 255, 255, alpha["Login_Window"] ), false )	
		dxDrawImage( x*0.48, y*0.72, x*0.098, y*0.07, "Images/Login/login_button.png", 0, 0, 0, tocolor( 255, 255, 255, alpha["Login_Button"] ), false )
		dxDrawImage( x*0.584, y*0.72, x*0.098, y*0.07, "Images/Login/guest_button.png", 0, 0, 0, tocolor( 255, 255, 255, alpha["Login_Guest"] ), false )
		
		local mx, my = getCursorPosition()
		
		if ( isLoginActive ) then
			if ( mx > 0.48 and mx < 0.578 and my > 0.719 and my < 0.79 ) then
				alpha["Login_Button"] = 180
				alpha["Login_Guest"] = 255
			elseif ( mx > 0.584 and mx < 0.682 and my > 0.719 and my < 0.79 ) then
				alpha["Login_Guest"] = 180
				alpha["Login_Button"] = 255
			else
				if ( alpha["Login_Button"] ~= 255 ) then
					alpha["Login_Button"] = 255
				elseif ( alpha["Login_Guest"] ~= 255 ) then
					alpha["Login_Guest"] = 255
				end
			end
		end
		
		if ( rotation["Logo"] == 15 ) then
			LogoDirection = "right"
		elseif ( rotation["Logo"] == -15 ) then
			LogoDirection = "left"
		end
			
		if ( LogoDirection == "left" ) then
			rotation["Logo"] = rotation["Logo"] + 0.5
		elseif ( LogoDirection == "right" ) then
			rotation["Logo"] = rotation["Logo"] - 0.5
		end
	end
)

local Login_User = guiCreateEdit( 0.37, 0.538, 0.313, 0.0555, "", true )
guiSetAlpha( Login_User, alpha["Login_User_Edit"] )
local Login_Password = guiCreateEdit( 0.37, 0.622, 0.313, 0.0555, "", true )
guiSetAlpha( Login_Password, alpha["Login_Pass_Edit"] )
guiEditSetMasked( Login_Password, true )

if ( getElementData( localPlayer, "Connection" ) ~= false ) then
	destroyElement( Login_User )
	destroyElement( Login_Password )
end

local i = 0
setTimer( function() 
	alpha["Background"] = alpha["Background"] + 15
	alpha["Logo"] = alpha["Logo"] + 15
	if ( getElementData( localPlayer, "Connection" ) == 1 or getElementData( localPlayer, "Connection" ) == 2 ) then
		
	else
		i = i + 1
		alpha["Login_Window"] = alpha["Login_Window"] + 15
		alpha["Login_News"] = alpha["Login_News"] + 15
		alpha["Login_Button"] = alpha["Login_Button"] + 15
		alpha["Login_Guest"] = alpha["Login_Guest"] + 15
		
		guiSetAlpha( Login_User, guiGetAlpha( Login_User ) + 0.058 )
		guiSetAlpha( Login_Password, guiGetAlpha( Login_Password ) + 0.058 )
		if ( i == 17 ) then
			isLoginActive = true
		end
	end
end, 100, 17 )

function deleteLogin( state )
	if ( state ) then
		alpha["Login_Window"] = 0
		alpha["Login_News"] = 0
		alpha["Login_Button"] = 0
		alpha["Login_Guest"] = 0
		
		guiSetAlpha( Login_User, 0 )
		guiSetAlpha( Login_Password, 0 )
		isLoginActive = false
		destroyElement( Login_User )
		destroyElement( Login_Password )
		DXALPHA1, DXALPHA2 = 255, 150
	end
end
addEvent("player:loginNotification", true)
addEventHandler("player:loginNotification", getRootElement(), deleteLogin)

showChat( false )
showCursor( true )

addEventHandler("onClientClick", getRootElement(),
	function( button, state, px, py )
		if ( button == "left" and state == "down" ) then
			if ( px > x*0.48 and px < x*0.578 and py > y*0.719 and py < y*0.79 ) then
				if ( isLoginActive ) then
					playSound("Sounds/button2.mp3", false)
					local user = guiGetText( Login_User )
					local pass = guiGetText( Login_Password )
					if ( user ~= "" and pass ~= "" ) then
						triggerServerEvent("player:login", getRootElement(), getLocalPlayer(), user, pass)
					end
				end
			elseif ( px > x*0.584 and px < x*0.682 and py > y*0.719 and py < y*0.79) then
				if ( isLoginActive ) then
					playSound("Sounds/button2.mp3", false)
					triggerServerEvent("player:guess", getRootElement(), getLocalPlayer())
				end
			end
		end
	end
)