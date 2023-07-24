function mopp.util.PrintLog( text, ... )
	local args = {...}

	local time = os.date( "%H:%M:%S", os.time() )
	local msg = args and string.format( text, unpack(args) ) or text

	MsgC( Color( 255, 255, 255 ), string.format( " - (%s) %s\n", time, msg ) )
end

-- hook.Add('PlayerSpawn','Logging.PlayerSpawn',function(pPlayer)
-- 	local name = pPlayer:Name() or pPlayer:SteamName()
-- 	mopp.util.PrintLog(name..' has spawned.')
-- end)

-- hook.Add('PlayerDisconnected','Logging.PlayerDisconnected',function(pPlayer)
-- 	mopp.util.PrintLog(pPlayer:Name()..' has disconnected.')
-- end)