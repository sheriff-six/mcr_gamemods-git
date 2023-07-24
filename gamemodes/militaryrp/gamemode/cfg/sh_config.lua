mopp.cfg.default_team = TEAM_CADET
mopp.cfg.SuperGroups = {
	'founder',
	'superadmin',
}

mopp.cfg.EventroomAllowedGroups = {
	'founder',
	'superadmin',
}

mopp.cfg.DefaultMainMap = ''

mopp.cfg.features = {
	
}

mopp.cfg.DefaultSpawnGroup = 'Clones'
mopp.cfg.DefaultIDGroup = 'CT'

mopp.cfg.EventRoomEffects = {
	flashlights = {
		title = 'Фонарики',
		activate = function()
			for _, v in pairs(player.GetAll()) do
				v:AllowFlashlight(true)
			end
		end,
		deactivate = function()
			for _, v in pairs(player.GetAll()) do
				v:Flashlight( false )
				v:AllowFlashlight(false)
			end
		end,
		on_spawn = function(player)
			player:AllowFlashlight(true)
		end
	},
	-- drop_weapons = {
	-- 	title = 'Выбрасывать оружия',
	-- 	activate = function()

	-- 	end
	-- }
}
