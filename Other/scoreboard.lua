setElementData( localPlayer, "Arena", "Lobby" )
setElementData( localPlayer, "money", 0 )
setElementData( localPlayer, "rank", 0 )
setElementData( localPlayer, "points", 0 )
setElementData( localPlayer, "state", "Dead" )
setElementData( localPlayer, "kills", 0 )
setElementData( localPlayer, "deaths", 0 )
setElementData( localPlayer, "wins", 0 )
setElementData( localPlayer, "position", 0 )
setElementData( localPlayer, "adminrang", 0 )
setElementData( localPlayer, "donator", false )
local servername = "WTF Gaming - Hizard BETA 1.0"
local scoreboard = {}
scoreboard.__index = scoreboard
scoreboard.gamemodes = {
	--// Lobby
	[1] = { Name = "Lobby", MaxPlayers = "400", Row1 = "Name", Row2 = "", Row3 = "", Row4 = "", Row5 = "", Row6 = "Ping", Row7 = "FPS", ElementData = "Lobby" },
	
	--// Deathmatch
	[2] = { Name = "Deathmatch", MaxPlayers = "160", Row1 = "Name", Row2 = "Money", Row3 = "Rank", Row4 = "Points", Row5 = "State", Row6 = "Ping", Row7 = "FPS", ElementData = "Deathmatch" },
	
	--// Destruction Derby
	[3] = { Name = "Destruction Derby", MaxPlayers = "35", Row1 = "Name", Row2 = "Money", Row3 = "Rank", Row4 = "Kills", Row5 = "Deaths", Row6 = "Ping", Row7 = "FPS", ElementData = "Destruction" },
	
	--// Hunter
	[4] = { Name = "Hunter", MaxPlayers = "35", Row1 = "Name", Row2 = "Money", Row3 = "Rank", Row4 = "Kills", Row5 = "Deaths", Row6 = "Ping", Row7 = "FPS", ElementData = "Hunter" },
	
	--// Shooter
	[5] = { Name = "Shooter", MaxPlayers = "35", Row1 = "Name", Row2 = "Money", Row3 = "Rank", Row4 = "Kills", Row5 = "Deaths", Row6 = "Ping", Row7 = "FPS", ElementData = "Shooter" },
	
	--// Trials
	[6] = { Name = "Trials", MaxPlayers = "35", Row1 = "Name", Row2 = "Money", Row3 = "Rank", Row4 = "Position", Row5 = "Wins", Row6 = "Ping", Row7 = "FPS", ElementData = "Trials" }
}
scoreboard.width = 0.6
scoreboard.alpha = {
	[1] = 0,
	[2] = 0,
	[3] = 0,
	[4] = 0,
	[5] = 0,
	[6] = 0
}
scoreboard.i = 0
scoreboard.gamemode = 1
scoreboard.y = 0 --// Highest = 170

scoreboard.gamemodesN = {
	["Lobby"] = 1,
	["Deathmatch"] = 2,
	["Destruction"] = 3,
	["Hunter"] = 4,
	["Shooter"] = 5,
}

function clientGetArenaPlayers( Arena ) 
	players = 0
	for i, player in ipairs( getElementsByType("player") ) do
		if ( getElementData( player, "Arena" ) == Arena ) then
			players = players + 1
		end
	end
	return players
end

maximum = clientGetArenaPlayers(scoreboard.gamemodes[scoreboard.gamemode]["ElementData"])
scroll = 1

x, y = guiGetScreenSize()
showPlayerHudComponent( "all", false )

local test = {}

addEventHandler("onClientRender", getRootElement(),
	function()
		if ( maximum > 28 ) then maximum = 28 end
		if ( scoreboard.gamemode == 0 ) then scoreboard.gamemode = #scoreboard.gamemodes end
		if ( scoreboard.gamemode == #scoreboard.gamemodes+1 ) then scoreboard.gamemode = 1 end
		if ( scoreboard.width > 0.6 ) then scoreboard.width = 0.6 end 
		dxDrawRectangle( x*0.2, y*0.25-scoreboard.y, x*scoreboard.width, y*0.042, tocolor(0, 0, 0, scoreboard.alpha[1]), false )
		dxDrawText( servername, x*0.21, y*0.26-scoreboard.y, x*scoreboard.width, y*0.042, tocolor( 255, 255, 255, scoreboard.alpha[2] ), 1.0, "default-bold", "left", "top", true, true, false, true, false)
		dxDrawText(#getElementsByType("player") .. "/400", x*1.0, y*0.26-scoreboard.y, x*0.796, y*0.042, tocolor( 255, 255, 255, scoreboard.alpha[2] ), 1.0, "default-bold", "right", "top", true, true, false, true, false)
		dxDrawRectangle( x*0.2, y*0.292-scoreboard.y, x*scoreboard.width, y*0.03, tocolor(0, 0, 0, scoreboard.alpha[3]), false )
		dxDrawText(scoreboard.gamemodes[scoreboard.gamemode]["Name"] .. " [Shift + Scroll to change Arena view]", x*0.21, y*0.295-scoreboard.y, x*scoreboard.width, y*0.042, tocolor( 255, 255, 255, scoreboard.alpha[2] ), 1.0, "default-bold", "left", "top", true, true, false, true, false)
		dxDrawText( clientGetArenaPlayers(scoreboard.gamemodes[scoreboard.gamemode]["Name"]) .. "/" .. scoreboard.gamemodes[scoreboard.gamemode]["MaxPlayers"], x*1.0, y*0.295-scoreboard.y, x*0.796, 30, tocolor( 255, 255, 255, scoreboard.alpha[2] ), 1.0, "default-bold", "right", "top", true, true, false, true, false)
		dxDrawRectangle( x*0.2, y*0.322-scoreboard.y, x*scoreboard.width, y*0.03, tocolor(0, 0, 0, scoreboard.alpha[3]), false )
		if ( scoreboard.gamemodes[scoreboard.gamemode]["Row1"] or scoreboard.gamemodes[scoreboard.gamemode]["Row1"] ~= "" ) then
			dxDrawText(scoreboard.gamemodes[scoreboard.gamemode]["Row1"], x*0.21, y*0.328-scoreboard.y, x*scoreboard.width, y*0.042, tocolor( 255, 255, 255, scoreboard.alpha[2] ), 1.0, "default-bold", "left", "top", true, true, false, true, false)
		end
		if ( scoreboard.gamemodes[scoreboard.gamemode]["Row2"] or scoreboard.gamemodes[scoreboard.gamemode]["Row2"] ~= "" ) then
			dxDrawText(scoreboard.gamemodes[scoreboard.gamemode]["Row2"], x*0.38, y*0.328-scoreboard.y, x*scoreboard.width, y*0.042, tocolor( 255, 255, 255, scoreboard.alpha[2] ), 1.0, "default-bold", "left", "top", true, true, false, true, false)
		end
		if ( scoreboard.gamemodes[scoreboard.gamemode]["Row3"] or scoreboard.gamemodes[scoreboard.gamemode]["Row3"] ~= "" ) then
			dxDrawText(scoreboard.gamemodes[scoreboard.gamemode]["Row3"], x*0.47, y*0.328-scoreboard.y, x*scoreboard.width, y*0.042, tocolor( 255, 255, 255, scoreboard.alpha[2] ), 1.0, "default-bold", "left", "top", true, true, false, true, false)
		end
		if ( scoreboard.gamemodes[scoreboard.gamemode]["Row4"] or scoreboard.gamemodes[scoreboard.gamemode]["Row4"] ~= "" ) then
			dxDrawText(scoreboard.gamemodes[scoreboard.gamemode]["Row4"], x*0.53, y*0.328-scoreboard.y, x*scoreboard.width, y*0.042, tocolor( 255, 255, 255, scoreboard.alpha[2] ), 1.0, "default-bold", "left", "top", true, true, false, true, false)
		end
		if ( scoreboard.gamemodes[scoreboard.gamemode]["Row5"] or scoreboard.gamemodes[scoreboard.gamemode]["Row5"] ~= "" ) then
			dxDrawText(scoreboard.gamemodes[scoreboard.gamemode]["Row5"], x*scoreboard.width, y*0.328-scoreboard.y, x*scoreboard.width, y*0.042, tocolor( 255, 255, 255, scoreboard.alpha[2] ), 1.0, "default-bold", "left", "top", true, true, false, true, false)
		end
		if ( scoreboard.gamemodes[scoreboard.gamemode]["Row6"] or scoreboard.gamemodes[scoreboard.gamemode]["Row6"] ~= "" ) then
			dxDrawText(scoreboard.gamemodes[scoreboard.gamemode]["Row6"], x*0.7, y*0.328-scoreboard.y, x*scoreboard.width, y*0.042, tocolor( 255, 255, 255, scoreboard.alpha[2] ), 1.0, "default-bold", "left", "top", true, true, false, true, false)
		end
		if ( scoreboard.gamemodes[scoreboard.gamemode]["Row7"] or scoreboard.gamemodes[scoreboard.gamemode]["Row7"] ~= "" ) then
			dxDrawText(scoreboard.gamemodes[scoreboard.gamemode]["Row7"], x*0.773, y*0.328-scoreboard.y, x*scoreboard.width, y*0.042, tocolor( 255, 255, 255, scoreboard.alpha[2] ), 1.0, "default-bold", "left", "top", true, true, false, true, false)
		end
		scoreboard.rowsRec = 0.3508
		scoreboard.rowsText = 0.355
		for scroll = scroll, maximum, 1 do
			if ( clientGetArenaPlayers(scoreboard.gamemodes[scoreboard.gamemode]["ElementData"]) >= 1 ) then
				local thePlayer = getElementsByType("player")[scroll]
				if ( getElementData( thePlayer, "Arena" ) == scoreboard.gamemodes[scoreboard.gamemode]["ElementData"] and getElementData( thePlayer, "adminrang" ) == 0 and getElementData( thePlayer, "donator" ) == false ) then
					dxDrawRectangle( x*0.2, y*scoreboard.rowsRec-scoreboard.y, x*scoreboard.width, y*0.03, tocolor(0, 0, 0, scoreboard.alpha[3]), false )
					if ( thePlayer == localPlayer ) then
						dxDrawRectangle( x*0.2, y*scoreboard.rowsRec-scoreboard.y, x*scoreboard.width, y*0.03, tocolor(0, 120, 240, scoreboard.alpha[6]), false )
					end
					dxDrawText(getPlayerName( thePlayer ), x*0.21, y*scoreboard.rowsText-scoreboard.y, x*scoreboard.width, y*0.042, tocolor( 255, 255, 255, scoreboard.alpha[2] ), 1.0, "default-bold", "left", "top", true, true, false, true, false)
					if ( scoreboard.gamemodes[scoreboard.gamemode]["Row2"] ~= "" ) then
						dxDrawText("$" .. getElementData( thePlayer, string.lower( scoreboard.gamemodes[scoreboard.gamemode]["Row2"] ) ), x*0.38, y*scoreboard.rowsText-scoreboard.y, x*scoreboard.width, y*0.042, tocolor( 255, 255, 255, scoreboard.alpha[2] ), 1.0, "default-bold", "left", "top", true, true, false, true, false)
					end
					if ( scoreboard.gamemodes[scoreboard.gamemode]["Row3"] ~= "" ) then
						dxDrawText( getElementData( thePlayer, string.lower( scoreboard.gamemodes[scoreboard.gamemode]["Row3"] ) ), x*0.47, y*scoreboard.rowsText-scoreboard.y, x*scoreboard.width, y*0.042, tocolor( 255, 255, 255, scoreboard.alpha[2] ), 1.0, "default-bold", "left", "top", true, true, false, true, false)
					end
					if ( scoreboard.gamemodes[scoreboard.gamemode]["Row4"] ~= "" ) then
						dxDrawText( getElementData( thePlayer, string.lower( scoreboard.gamemodes[scoreboard.gamemode]["Row4"] ) ), x*0.53, y*scoreboard.rowsText-scoreboard.y, x*scoreboard.width, y*0.042, tocolor( 255, 255, 255, scoreboard.alpha[2] ), 1.0, "default-bold", "left", "top", true, true, false, true, false)
					end
					if ( scoreboard.gamemodes[scoreboard.gamemode]["Row5"] ~= "" ) then
						if ( isPlayerDead( thePlayer ) ) then
							setElementData( thePlayer, "state", "Dead" )
						else
							setElementData( thePlayer, "state", "Alive" )
						end
						
						dxDrawText( getElementData( thePlayer, string.lower( scoreboard.gamemodes[scoreboard.gamemode]["Row5"] ) ), x*scoreboard.width, y*scoreboard.rowsText-scoreboard.y, x*scoreboard.width, y*0.042, tocolor( 255, 255, 255, scoreboard.alpha[2] ), 1.0, "default-bold", "left", "top", true, true, false, true, false)
					end
					dxDrawText(getPlayerPing( thePlayer ), x*0.818, y*scoreboard.rowsText-scoreboard.y, x*scoreboard.width, y*0.042, tocolor( 255, 255, 255, scoreboard.alpha[2] ), 1.0, "default-bold", "center", "top", true, true, false, true, false)
					dxDrawText("0", x*0.961, y*scoreboard.rowsText-scoreboard.y, x*scoreboard.width, y*0.042, tocolor( 255, 255, 255, scoreboard.alpha[2] ), 1.0, "default-bold", "center", "top", true, true, false, true, false)
					scoreboard.rowsRec = scoreboard.rowsRec + 0.03052
					scoreboard.rowsText = scoreboard.rowsText + 0.0308
				end
			end
		end
		if ( clientGetArenaPlayers(scoreboard.gamemodes[scoreboard.gamemode]["ElementData"]) == 0 ) then
			dxDrawRectangle( x*0.2, y*0.352-scoreboard.y, x*scoreboard.width, y*0.03, tocolor(0, 0, 0, scoreboard.alpha[5]), false )
			dxDrawText("There is no player in this Arena", x*0.21, y*0.358-scoreboard.y, x*scoreboard.width, y*0.042, tocolor( 255, 255, 255, scoreboard.alpha[2] ), 1.0, "default-bold", "left", "top", true, true, false, true, false)
		end
		scoreboard.y = clientGetArenaPlayers(scoreboard.gamemodes[scoreboard.gamemode]["ElementData"])*10
		if ( scoreboard.y > 170 ) then
			scoreboard.y = 170
		end
	end
)

function scoreboard.visible() 
	scoreboard.width = scoreboard.width + 0.086
	scoreboard.i = scoreboard.i + 1
	if scoreboard.i == 7 then
		scoreboard.alpha[2] = 255
	end
end

bindKey("tab", "both", 
	function( key, state )
		if ( isLoginActive == false ) then
			if ( state == "down" ) then
				setTimer( scoreboard.visible, 50, 7 )
				scoreboard.alpha[1] = 255
				scoreboard.alpha[3] = 200
				scoreboard.alpha[4] = 200
				scoreboard.alpha[5] = 200
				scoreboard.alpha[6] = 70
				scoreboard.gamemode = scoreboard.gamemodesN[getElementData(localPlayer, "Arena")]
				showChat( false )
				curMapAlpha = 0
				nextMapAlpha = 0
				DMtimerAlpha = 0
			else
				scoreboard.i = 0
				scoreboard.alpha[1] = 0
				scoreboard.alpha[2] = 0
				scoreboard.alpha[3] = 0
				scoreboard.alpha[4] = 0
				scoreboard.alpha[5] = 0
				scoreboard.alpha[6] = 0
				scoreboard.width = 0
				showChat( true )
				curMapAlpha = 200
				nextMapAlpha = 200
				DMtimerAlpha = 230
			end
		end
	end
)

function scrollUpSwitcher()
	if ( scoreboard.gamemode <= #scoreboard.gamemodes ) then
		scoreboard.gamemode = scoreboard.gamemode + 1
	elseif ( scoreboard.gamemode == #scoreboard.gamemodes+1 ) then
		scoreboard.gamemode = 1
	end
end

function scrollDownSwitcher()
	if ( scoreboard.gamemode > 0 ) then
		scoreboard.gamemode = scoreboard.gamemode - 1
	end
end

function scrollUpSwitcherKey( key, state )
	if ( state == "down" ) then
		bindKey("mouse_wheel_up", "down", scrollUpSwitcher)
		bindKey("mouse_wheel_down", "down", scrollDownSwitcher)
	end
end
bindKey("lshift", "down", scrollUpSwitcherKey)

bindKey("lshift", "up", function()
	unbindKey("mouse_wheel_up", "down", scrollUpSwitcher)
	unbindKey("mouse_wheel_down", "down", scrollDownSwitcher)
end)

function scrollDown()
	if ( scroll < clientGetArenaPlayers(scoreboard.gamemodes[scoreboard.gamemode]["ElementData"])-28 ) then
		scroll = scroll + 1
		maximum = maximum + 1
	end
end
bindKey("mouse_wheel_down", "down", scrollDown)

function scrollUp()
	if ( scroll > 1 ) then
		scroll = scroll - 1
		maximum = maximum - 1
	end
end
bindKey("mouse_wheel_up", "down", scrollUp)