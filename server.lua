--------------------
-- autor: Hizard  --
-- date: 28/10/13 --
--------------------

server = {}
server.__index = server

server.connection = dbConnect("sqlite", ":/wtf.db")
if ( server.connection ) then
	outputDebugString("Connection to database successful")
else
	outputDebugString("Connection to database failed")
end

dbExec(server.connection, 'CREATE TABLE IF NOT EXISTS wtf_accounts (id INTEGER PRIMARY KEY AUTOINCREMENT, Accountname varchar(255) NOT NULL, Password varchar(255) NOT NULL, Salt varchar(11) NOT NULL, `eMail` varchar(255) NOT NULL, IngameName varchar(255) NOT NULL, Deathmatch_Points int(11) NOT NULL, Deathmatch_Rank int(11) NOT NULL, Destruction_Points int(11) NOT NULL, Destruction_Rank int(11) NOT NULL, Hunter_Kills int(11) NOT NULL, Hunter_Deaths int(11) NOT NULL, Hunter_Rank int(11) NOT NULL, Shooter_Kills int(11) NOT NULL, Shooter_Deaths int(11) NOT NULL, Shooter_Level int(11) NOT NULL,Shooter_Rank int(11) NOT NULL)')

server.maps = {
	["Deathmatch"] = {},
	["Destruction"] = {},
	["Hunter"] = {},
	["Shooter"] = {}
}

function server.refreshMaps()
	--// Clear Map Lists
	server.maps["Deathmatch"] = {}
	server.maps["Destruction"] = {}
	server.maps["Hunter"] = {}
	server.maps["Shooter"] = {}
	
	--// Fill Map Lists
	for index, resource in ipairs ( getResources() ) do
		local name = getResourceName( resource )
		if ( string.find( name, "[DM]", 1, true ) ) then
			local real = getResourceInfo( resource, "name" )
			table.insert( server.maps["Deathmatch"], { name, real } )
		elseif ( string.find( name, "[DD]", 1, true ) ) then
			local real = getResourceInfo( resource, "name" )
			table.insert( server.maps["Destruction"], { name, real } )
		elseif ( string.find( name, "[Hunter]", 1, true ) ) then
			local real = getResourceInfo( resource, "name" )
			table.insert( server.maps["Hunter"], { name, real } )
		elseif ( string.find( name, "[Shooter]", 1, true ) ) then
			local real = getResourceInfo( resource, "name" )
			table.insert( server.maps["Shooter"], { name, real } )
		end
	end
end
addEventHandler("onResourceStart", getRootElement( getThisResource() ), server.refreshMaps)

function server.randomMap( List )
	--// Return a random Map
	local map
	if ( List ~= "" ) then
		local id = math.random( #server.maps[List] )
		if ( id > 0 ) then
			map = id
		end
		return map
	end
end

function server.getMapName( List, id, Version )
	--// Return Mapname
	local name = "N/A"
	if ( List ~= "" and id > 0 and #server.maps[List] >= id ) then
		name = server.maps[List][id][Version] --// Version: 1 = Resourcename | 2 = Meta Name
	end
	return name
end

function server.login( thePlayer, Username, Password )
	--// Login the Player
	if ( thePlayer ~= "" and Username ~= "" and Password ~= "" ) then
		if ( getElementData( thePlayer, "Connection" ) ~= 1 ) then
			local accounts = dbQuery( server.connection, "SELECT * FROM wtf_accounts WHERE Accountname = '" .. Username .. "'" )
			local result, rows, errormessage = dbPoll( accounts, -1 )
			
			if ( rows == 1 ) then
				for i, row in pairs( result ) do
					local pass = string.upper( row['Password'] )
					local salt = row['Salt']
					local gens = md5( md5( salt .. pass .. salt ) )
					local ePass = md5( Password )
					local salted = md5( md5( salt .. ePass .. salt ) )
					
					if ( gens == salted ) then
						setElementData( thePlayer, "Connection", 1 ) -- 0 = Guest | 1 = Logged in
						setElementData( thePlayer, "Arena", "Lobby" ) -- Set Player into Lobby
						setPlayerName( thePlayer, row['IngameName'] )
						
						--// Deathmatch Info
						setElementData( thePlayer, "DM_Points", row['Deathmatch_Points'] )
						setElementData( thePlayer, "DM_Rank", row['Deathmatch_Rank'] )
						
						--// Destruction Info
						setElementData( thePlayer, "DD_Points", row['Destruction_Points'] )
						setElementData( thePlayer, "DD_Rank", row['Destruction_Rank'] )
						
						--// Hunter Info
						setElementData( thePlayer, "Hunter_Points", row['Hunter_Points'] )
						setElementData( thePlayer, "Hunter_Rank", row['Hunter_Rank'] )
						
						--// Shooter Info
						setElementData( thePlayer, "Shooter_Points", row['Shooter_Points'] )
						setElementData( thePlayer, "Shooter_Rank", row['Shooter_Rank'] )
						
						triggerClientEvent( thePlayer, "player:loginNotification", getRootElement(), true )
						triggerClientEvent( thePlayer, "server:note", getRootElement(), "success", "You successfully logged in")
						return true
					else
						triggerClientEvent( thePlayer, "server:note", getRootElement(), "error", "You entered a wrong password")
						triggerClientEvent( thePlayer, "player:loginNotification", getRootElement(), false )
						return false
					end
				end
			else
				triggerClientEvent( thePlayer, "server:note", getRootElement(), "error", "Account does not exists. Register at www.wtf-mta.com")
				return false
			end
			dbFree( accounts )
		else
			outputDebugString( getPlayerName( thePlayer ) .. " failed to login. - Already logged in. Serial: " .. getPlayerSerial( thePlayer ) )
		end
	end
end

addEvent("player:login", true)
addEventHandler("player:login", getRootElement(), server.login)


function server.guess( thePlayer )
	--// Login the Player
	if isElement(thePlayer) then
		if ( getElementData( thePlayer, "Connection" ) ~= 1 ) then
			setElementData( thePlayer, "Connection", 0 ) -- 0 = Guest | 1 = Logged in
			setElementData( thePlayer, "Arena", "Lobby" ) -- Set Player into Lobby
						
			--// Deathmatch Info
			setElementData( thePlayer, "DM_Points", 0 )
			setElementData( thePlayer, "DM_Rank", 0 )
						
			--// Destruction Info
			setElementData( thePlayer, "DD_Points", 0 )
			setElementData( thePlayer, "DD_Rank", 0 )
			
			--// Hunter Info
			setElementData( thePlayer, "Hunter_Points", 0 )
			setElementData( thePlayer, "Hunter_Rank", 0 )
						
			--// Shooter Info
			setElementData( thePlayer, "Shooter_Points", 0 )
			setElementData( thePlayer, "Shooter_Rank", 0 )
						
			triggerClientEvent( thePlayer, "player:loginNotification", getRootElement(), true )
			triggerClientEvent( thePlayer, "server:note", getRootElement(), "success", "You successfully joined as guess.")
			return true
		end
	end
end

addEvent("player:guess", true)
addEventHandler("player:guess", getRootElement(), server.guess)

function server.logout( thePlayer )
	if ( thePlayer ~= "" ) then
		if ( getElementData( thePlayer, "Connection" ) == 1 ) then
			local save = dbQuery( server.connection, "UPDATE wtf_accounts SET `??` = ?", 
				"IngameName", getPlayerName( thePlayer ), -- Current InGame Name
				
				--// Deathmatch Save
				"Deathmatch_Points", getElementData( thePlayer, "DM_Points" ), --// Current Deathmatch Points
				"Deathmatch_Rank", getElementData( thePlayer, "DM_Rank" ), --// Current Deathmatch Rank
				
				--// Destruction Save
				"Destruction_Points", getElementData( thePlayer, "DD_Points" ), --// Current Destruction Points
				"Destruction_Rank", getElementData( thePlayer, "DD_Rank" ), --// Current Destruction Rank
				
				--// Hunter Save
				"Hunter_Kills", getElementData( thePlayer, "Hunter_Kills" ), --// Current Hunter Kills
				"Hunter_Deaths", getElementData( thePlayer, "Hunter_Deaths" ), --// Current Hunter Deaths
				"Hunter_Rank", getElementData( thePlayer, "Hunter_Rank" ), --// Current Hunter Rank
				
				--// Shooter Save
				"Shooter_Kills", getElementData( thePlayer, "Shooter_Kills" ), --// Current Shooter Kills
				"Shooter_Deaths", getElementData( thePlayer, "Shooter_Deaths" ), --// Current Shooter Deaths
				"Shooter_Rank", getElementData( thePlayer, "Shooter_Rank" ) --// Current Shooter Rank
			)
			dbFree( save )
		end
	end
end

addEventHandler("onPlayerQuit", getRootElement(),
	function() 
		server.logout( source )
	end
)

addEventHandler("onPlayerJoin", getRootElement(),
	function()
		setElementData( source, "Connection", false )
	end
)

addCommandHandler("log", 
	function( player, cmd, username, password ) 
		server.login( player, username, password )
	end
)