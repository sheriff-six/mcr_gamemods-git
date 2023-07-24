MySQLite.initialize({
	EnableMySQL = false,
	Host = '127.0.0.1',
	Username = 'gameserver6377',
	Password = 'Dir5mdrk',
	Database_name = 'gameserver6377',
	Database_port = 3306,
	Preferred_module = 'mysqloo'
})

hook.Add( "DatabaseInitialized", "DatabaseInitialized", function()
	MySQLite.query([[
		CREATE TABLE IF NOT EXISTS mopple_player_data(
			steam_id varchar(25),
			community_id TEXT,
			team VARCHAR(20),
			player varchar(255),
			rpid TEXT(64),
			data TEXT,
			PRIMARY KEY (`steam_id`)
		);
	]])
	MySQLite.query([[
		CREATE TABLE IF NOT EXISTS mopple_discord_integration(
			steamid VARCHAR(255),
			token VARCHAR(255),
			used VARCHAR(255),
			PRIMARY KEY (`steamid`)
		);
	]])
	MySQLite.query([[
		CREATE TABLE IF NOT EXISTS mopple_others_timers(
			steam_id varchar(25),
			data_timers TEXT,
			PRIMARY KEY (`steam_id`)
		);
	]])
	-- MySQLite.query([[
	-- 	CREATE TABLE IF NOT EXISTS sp_ips_log(
	-- 		steamid VARCHAR(255),
	-- 		address VARCHAR(255),
	-- 		PRIMARY KEY (`steamid`)
	-- 	);
	-- ]])
end)
