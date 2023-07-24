if CLIENT then
	hook.Add( "Think", "PlayerIsLoaded", function()
		if IsValid( LocalPlayer() ) then
			hook.Remove( "Think", "PlayerIsLoaded" )
			
			netstream.Start("PlayerIsLoaded")

			hook.Run( "PlayerIsLoaded" )
		end
	end)
else
	reload_players = true

	hook.Add('OnReloaded','OnReloaded_PlayerIsLoaded',function() -- dont fuck me. pls
		reload_players = false
		timer.Simple(3,function()
			reload_players = true
		end)
	end)

	netstream.Hook("PlayerIsLoaded", function(ply)
		if reload_players then
			hook.Run("PlayerIsLoaded", ply)
		end
	end)
end