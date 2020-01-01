--------------------
-- autor: Hizard  --
-- date: 29/10/13 --
--------------------

function replace() 
	--// Replace Pickups
	showPlayerHudComponent("all", false)
	txd1 = engineLoadTXD ( "Mods/nitro.txd" )
	engineImportTXD ( txd1, 2221)
	dff1 = engineLoadDFF ( "Mods/nitro.dff", 2221)
	engineReplaceModel ( dff1, 2221)
	
	txd2 = engineLoadTXD ( "Mods/repair.txd" )
	engineImportTXD ( txd2, 2222)
	dff2 = engineLoadDFF ( "Mods/repair.dff", 2222)
	engineReplaceModel ( dff2, 2222)
	
	txd3 = engineLoadTXD ( "Mods/vehiclechange.txd" )
	engineImportTXD ( txd3, 2223)
	dff3 = engineLoadDFF ( "Mods/vehiclechange.dff", 2223)
	engineReplaceModel ( dff3, 2223)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), replace)