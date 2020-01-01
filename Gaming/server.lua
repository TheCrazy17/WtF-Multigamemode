--------------------
-- autor: Hizard  --
-- date: 30/10/13 --
--------------------

arena = {}
arena.__index = arena
arena.gamemode = {
	["Deathmatch"] = {
		["Name"] = "Deathmatch",
		["Data"] = "Deathmatch",
		["Players"] = {},
		["MaxPlayers"] = 32,
		["Dimension"] = 2,
		["State"] = "not playing",
		["Map"] = {
			["Objects"] = {},
			["Spawnpoints"] = {},
			["Pickups"] = {},
			["Markers"] = {}
		}
	},
	
	["Destruction"] = {
		["Name"] = "Destruction Derby",
		["Data"] = "Destruction",
		["Players"] = {},
		["MaxPlayers"] = 32,
		["Dimension"] = 3,
		["State"] = "not playing",
		["Map"] = {
			["Objects"] = {},
			["Spawnpoints"] = {},
			["Pickups"] = {},
			["Markers"] = {}
		}
	},
	
	["Hunter"] = {
		["Name"] = "Hunter",
		["Data"] = "Hunter",
		["Players"] = {},
		["MaxPlayers"] = 32,
		["Dimension"] = 4,
		["State"] = "not playing",
		["Map"] = {
			["Objects"] = {},
			["Spawnpoints"] = {},
			["Pickups"] = {},
			["Markers"] = {}
		}
	},
	
	["Shooter"] = {
		["Name"] = "Shooter",
		["Data"] = "Shooter",
		["Players"] = {},
		["MaxPlayers"] = 32,
		["Dimension"] = 5,
		["State"] = "not playing",
		["Map"] = {
			["Objects"] = {},
			["Spawnpoints"] = {},
			["Pickups"] = {},
			["Markers"] = {}
		}
	}
}

function arena.select( thePlayer, Gamemode )
	--// Enter Gamemode
	if ( Gamemode ~= "" ) then
		if ( #arena.gamemode[Gamemode]["Players"] < arena.gamemode[Gamemode]["MaxPlayers"] ) then
			if ( getElementData( thePlayer, "Arena" ) ~= arena.gamemode[Gamemode]["Data"] ) then
				table.insert( arena.gamemode[Gamemode]["Players"], thePlayer )
				setElementData( thePlayer, "Arena", arena.gamemode[Gamemode]["Data"] )
				triggerClientEvent( thePlayer, "selection:hide", getRootElement() )
				triggerClientEvent( thePlayer, "server:note", getRootElement(), "success", "You successfully joined the " .. arena.gamemode[Gamemode]["Name"] .. " Gamemode")
				arena.buildMap( arena.gamemode[Gamemode]["Data"] )
				return true
			else
				triggerClientEvent( thePlayer, "server:note", getRootElement(), "info", "You are already in the " .. arena.gamemode[Gamemode]["Name"] .. " Gamemode")
				return false
			end
		end
	end
end
addEvent("arena:select", true)
addEventHandler("arena:select", getRootElement(), arena.select)

function arena.buildMap( Gamemode )
	--// Build Map for Gamemode
	if ( Gamemode ~= "" ) then
		
		arena.gamemode[Gamemode]["Map"]["Objects"] = {}
		arena.gamemode[Gamemode]["Map"]["Spawnpoints"] = {}
		arena.gamemode[Gamemode]["Map"]["Pickups"] = {}
		arena.gamemode[Gamemode]["Map"]["Markers"] = {}
		
		local mapId = server.randomMap( Gamemode )
		local mapResource = server.getMapName( Gamemode, mapId, 1 )
		local mapName = server.getMapName( Gamemode, mapId, 2 )
		local meta = xmlLoadFile(":" .. mapResource .. "/meta.xml")
		if ( meta ) then
			local mapChild = xmlFindChild( meta, "map", 0 )
			if ( mapChild ) then
				local mapSource = xmlNodeGetAttribute( mapChild, "src" )
				local mapFile = xmlLoadFile(":" .. mapResource .. "/" .. mapSource)
				if ( mapFile ) then
					local childs = xmlNodeGetChildren( mapFile )
					for _, child in ipairs( childs ) do
						local item_id = xmlNodeGetAttribute( child, "id" )
						local item_model = xmlNodeGetAttribute( child, "model" )
						local item_posX = xmlNodeGetAttribute( child, "posX" )
						local item_posY = xmlNodeGetAttribute( child, "posY" )
						local item_posZ = xmlNodeGetAttribute( child, "posZ" )
						local item_rotX = xmlNodeGetAttribute( child, "rotX" )
						local item_rotY = xmlNodeGetAttribute( child, "rotY" )
						local item_rotZ = xmlNodeGetAttribute( child, "rotZ" )
						local item_type = xmlNodeGetAttribute( child, "type" )
						local item_vehicle = xmlNodeGetAttribute( child, "vehicle" )
						local item_size = xmlNodeGetAttribute( child, "size" )
						local item_alpha = xmlNodeGetAttribute( child, "alpha" )
						local item_collision = xmlNodeGetAttribute( child, "collisions" )
						local item_scale = xmlNodeGetAttribute( child, "scale" )	
						
						if ( string.find( item_id, "object", 1, true ) or string.find( item_id, "AMT", 1, true ) ) then
							table.insert( arena.gamemode[Gamemode]["Map"]["Objects"], { item_model, item_posX, item_posY, item_posZ, item_rotX, item_rotY, item_rotZ, item_alpha, item_collision, item_scale, arena.gamemode[Gamemode]["Dimension"] } )
						elseif ( string.find( item_id, "spawnpoint", 1, true ) ) then
							table.insert( arena.gamemode[Gamemode]["Map"]["Spawnpoints"], { item_vehicle, item_posX, item_posY, item_posZ, item_rotX, item_rotY, item_rotZ, arena.gamemode[Gamemode]["Dimension"] } )
						elseif ( string.find( item_id, "racepickup", 1, true ) ) then
							table.insert( arena.gamemode[Gamemode]["Map"]["Pickups"], { item_type, item_vehicle, item_posX, item_posY, item_posZ, arena.gamemode[Gamemode]["Dimension"] } )
						elseif ( string.find( item_id, "marker", 1, true ) ) then
							table.insert( arena.gamemode[Gamemode]["Map"]["Markers"], { item_type, item_posX, item_posY, item_posZ, item_size, arena.gamemode[Gamemode]["Dimension"] } )
						end
					end
				end
			end
			
			for _, player in ipairs ( arena.gamemode[Gamemode]["Players"] ) do
				arena.createMap( player, arena.gamemode[Gamemode]["Data"], mapName )
			end
		else
			outputChatBox("Loading failed")
			arena.buildMap( Gamemode )
		end
		xmlUnloadFile( meta )
	end
end

function arena.createMap( thePlayer, Mode, Map )
	outputChatBox("Creating map for player " .. getPlayerName( thePlayer ) )
	outputChatBox("Creating map at gamemode " .. Mode )
	outputChatBox('Creating map "' .. Map .. '"' )
	
	triggerClientEvent( thePlayer, "arena:createMap", getRootElement(), arena.gamemode[Mode]["Map"]["Objects"], arena.gamemode[Mode]["Map"]["Pickups"], arena.gamemode[Mode]["Map"]["Markers"] )
	local spawns = math.random( #arena.gamemode[Mode]["Map"]["Spawnpoints"] )
	local spawn = arena.gamemode[Mode]["Map"]["Spawnpoints"][spawns]
	fadeCamera( thePlayer, true )
	
	if ( arena.gamemode[Mode]["State"] == "not playing" ) then
		spawnPlayer( thePlayer, spawn[2], spawn[3], spawn[4] )
		setElementDimension( thePlayer, arena.gamemode[Mode]["Dimension"] )
		local veh = createVehicle( spawn[1], spawn[2], spawn[3], spawn[4], spawn[5], spawn[6], spawn[7] )
		setElementDimension( veh, arena.gamemode[Mode]["Dimension"] )
		warpPedIntoVehicle( thePlayer, veh )
		setCameraTarget( thePlayer, thePlayer )
	end
end

addCommandHandler("join",
	function( thePlayer )
		arena.select( thePlayer, "Deathmatch" )
	end
)

addCommandHandler("m",
	function()
		outputChatBox( #arena.gamemode["Deathmatch"]["Map"]["Objects"] )
		outputChatBox( #arena.gamemode["Deathmatch"]["Map"]["Spawnpoints"] )
		outputChatBox( #arena.gamemode["Deathmatch"]["Map"]["Pickups"] )
		outputChatBox( #arena.gamemode["Deathmatch"]["Map"]["Markers"] )
	end
)