function mopp.cmd.callback( pPlayer, cmd, args, str )
	if (!(args[1]) or args == {}) then
		print('This is a basic command for mopp gamemode.')
	end
	if table.HasValue(table.GetKeys(mopp.cmd.data),args[1]) then
		local com = args[1]
		-- table.remove(args, 1);
		mopp.cmd.data[com](pPlayer,cmd,args)
	elseif (args[1] or args == {}) then
		print('Errors of the argument!')
	end
end

function mopp.cmd.autoComplete(commandName,args)
	local return_table = {}
	for _, name in pairs(table.GetKeys(mopp.cmd.data)) do
		table.insert(return_table,string.format('mopp %s',name))
	end
	return return_table
end

function mopp.cmd.add(arg,callback)
	mopp.cmd.data[arg] = callback
end

mopp.cmd.add('thirdperson',function( pPlayer )
	netstream.Start(pPlayer, "thirdperson_toggle")
end)


function OOCMessage( pPlayer, cmd, args )
	table.remove(args,1)
	local tblPlayers = {}
	for _, v in pairs(ents.FindInSphere(pPlayer:GetPos(),300)) do
		table.insert(tblPlayers,v)
	end
	netstream.Start(player.GetAll(), 'RPCommands', Color(63,103,124,255), "[OOC] ",team.GetColor(pPlayer:Team()), Color(63,103,124,255), pPlayer:Nick(), Color(240,240,240,255), ': ', string.Implode( " ", args )  )
end
mopp.cmd.add('ooc',OOCMessage)
mopp.cmd.add('/',OOCMessage)

mopp.cmd.add('jetpack_toggle',function( pPlayer, cmd, args )
	local data = pPlayer:GetNVar('mo_data')
	if pPlayer and IsValid(pPlayer) then
		if data.data.features and data.data.features.jet then
			pPlayer.JetPackToggle = pPlayer.JetPackToggle or false
			if !pPlayer.JetPackToggle then
				table.RemoveByValue(mopp.jetplayers,pPlayer)
				pPlayer:ChatPrint( 'Вы выключили джетпак.' )
				pPlayer.JetPackToggle = true
			else
				pPlayer:ChatPrint( 'Вы включили джетпак.' )
				table.insert(mopp.jetplayers,pPlayer)
				pPlayer.JetPackToggle = false
			end
		end
	end
end)

mopp.RadioChannels = mopp.RadioChannels or {}
mopp.cmd.add('changeradiochannel',function( pPlayer, cmd, args )
	table.remove(args,1)
	local channel = math.Clamp(tonumber(args[1]),1,100)
	mopp.RadioChannels[channel] = mopp.RadioChannels[channel] or {}

	pPlayer.RadioChannel = pPlayer.RadioChannel or 1
	if mopp.RadioChannels[pPlayer.RadioChannel] then
		table.RemoveByValue(mopp.RadioChannels[pPlayer.RadioChannel],pPlayer)
		if mopp.RadioChannels[pPlayer.RadioChannel] == {} then
			mopp.RadioChannels[pPlayer.RadioChannel] = nil
		end
	end

	pPlayer.RadioChannel = channel
	table.insert(mopp.RadioChannels[channel],pPlayer)
	pPlayer:ChatPrint( '[#] Частота изменена. Частота '..channel..'.' )
end)

mopp.cmd.add('offradio',function( pPlayer, cmd, args )
	mopp.RadioChannels[0] = mopp.RadioChannels[0] or {}

	pPlayer.RadioChannel = pPlayer.RadioChannel or 1
	if mopp.RadioChannels[pPlayer.RadioChannel] then
		table.RemoveByValue(mopp.RadioChannels[pPlayer.RadioChannel],pPlayer)
		if mopp.RadioChannels[pPlayer.RadioChannel] == {} then
			mopp.RadioChannels[pPlayer.RadioChannel] = nil
		end
	end

	pPlayer.PreRadioChannel = pPlayer.RadioChannel
	pPlayer.RadioChannel = 0
	table.insert(mopp.RadioChannels[0],pPlayer)
	pPlayer:ChatPrint( '[#] Вы выключили рацию.' )
end)

mopp.cmd.add('onradio',function( pPlayer, cmd, args )
	pPlayer.PreRadioChannel = pPlayer.PreRadioChannel or 1

	local channel = pPlayer.PreRadioChannel
	mopp.RadioChannels[channel] = mopp.RadioChannels[channel] or {}

	pPlayer.RadioChannel = pPlayer.RadioChannel or 1
	if mopp.RadioChannels[0] and table.HasValue(mopp.RadioChannels[0],pPlayer) then
		table.RemoveByValue(mopp.RadioChannels[0],pPlayer)
		if mopp.RadioChannels[pPlayer.RadioChannel] == {} then
			mopp.RadioChannels[pPlayer.RadioChannel] = nil
		end
	end

	table.insert(mopp.RadioChannels[channel],pPlayer)
	pPlayer.RadioChannel = channel
	pPlayer.PreRadioChannel = nil
	pPlayer:ChatPrint( 'Вы включили рацию.' )
	pPlayer:ChatPrint( 'Канал рации переключен на '..channel..'.' )
end)

mopp.cmd.add('onlylisten',function( pPlayer, cmd, args )
	-- pPlayer.RadioOnlyListen = pPlayer.RadioOnlyListen or false
	local RadioOnlyListen = pPlayer:GetNVar('RadioOnlyListen')
	if RadioOnlyListen then
		pPlayer:SetNVar('RadioOnlyListen',false)
		-- pPlayer.RadioOnlyListen = false
		pPlayer:ChatPrint( 'Вы выключили режим "только слушать".' )
	else
		pPlayer:SetNVar('RadioOnlyListen',true)
		-- pPlayer.RadioOnlyListen = true
		pPlayer:ChatPrint( 'Вы включили режим "только слушать".' )
	end
	print(RadioOnlyListen,pPlayer:GetNVar('RadioOnlyListen'))
end)

mopp.cmd.add('cradio',function( pPlayer, cmd, args )
	if pPlayer:GetUserGroup() == 'founder' or serverguard.player:GetImmunity(pPlayer) > 20 then
		netstream.Start(pPlayer,'CommanderRadio')
	end
end)

local function ChangeName( pPlayer, cmd, args )
	if !SERVER then
		return
	end

	table.remove(args,1)
	local name = string.Implode(' ',args)
	local ostime = os.time()

	MySQLite.query( "SELECT * FROM `mopple_others_timers` WHERE steam_id = '"..pPlayer:SteamID().."'",function(data)
		local can_change_name = false
		if (data and istable(data)) then
			local timers = util.JSONToTable(data[1].data_timers)
			if timers.name < ostime then
				can_change_name = true
				MySQLite.query( "UPDATE `mopple_others_timers` SET `data_timers`='"..util.TableToJSON({name=ostime+3600}).."' WHERE `steam_id` = '"..pPlayer:SteamID().."'" )
			else
				pPlayer:ChatPrint('Игровое имя можно менять только раз в час!')
			end
		else
			can_change_name = true
			MySQLite.query( "INSERT INTO `mopple_others_timers` VALUES('"..pPlayer:SteamID().."', '"..util.TableToJSON({name=ostime+3600}).."');" )
		end
		MySQLite.query( "SELECT * FROM `mopple_player_data` WHERE player = '"..name.."'",function(row)
			if row and row[1].player and isstring(row[1].player) then
				pPlayer:ChatPrint('Такое игровое имя уже занято!')
				can_change_name = false
			elseif can_change_name then
				MySQLite.query( "UPDATE `mopple_others_timers` SET `data_timers`='"..util.TableToJSON({name=ostime-3600}).."' WHERE `steam_id` = '"..pPlayer:SteamID().."'" )
				netstream.Start(player.GetAll(), 'RPCommands', Color(240,240,240), pPlayer, Color(240,240,240), ' изменил игровое имя на ', team.GetColor(pPlayer:Team()), name, Color(240,240,240), '.' )
				pPlayer:SetNVar('mo_name',name,NETWORK_PROTOCOL_PUBLIC)
				pPlayer:SetNWString( "rpname", name )
				pPlayer:SavePlayerData('player',name)
			end
		end)
		-- if can_change_name or pPlayer:GetUserGroup() == 'founder' then
		-- 	netstream.Start(player.GetAll(), 'RPCommands', Color(240,240,240), pPlayer, Color(240,240,240), ' изменил игровое имя на ', team.GetColor(pPlayer:Team()), name )
		-- 	pPlayer:SetNVar('mo_name',name,NETWORK_PROTOCOL_PUBLIC)
		-- 	pPlayer:SavePlayerData('player',name)
		-- end
	end)
end

mopp.cmd.add('name', ChangeName)
mopp.cmd.add('rpname', ChangeName)


netstream.Hook('ChangeRadioChannelsCommander',function(player, data)
	local players = data.players
	local channel = data.channel
	if player:GetUserGroup() == 'founder' or serverguard.player:GetImmunity(player) > 20 then
		for k, v in pairs(players) do
			v.RadioChannel = channel
			player:ChatPrint( 'Вы переключили рацию '..v:Name()..' на '..channel )
			v:ChatPrint( player:Name()..' преключил вам рацию на '..channel )
			netstream.Start(v,'ChangeRadioChannel',channel)
		end
	end
end)

function AdvertMassage( pPlayer, cmd, args )
	table.remove(args,1)
	netstream.Start(player.GetAll(), 'RPCommands', Color(255, 0, 0), "[Рация] ", team.GetColor(pPlayer:Team()), pPlayer:Nick(), Color(255,255,255,255), ': ', Color(225,225,0,255),  string.Implode( " ", args )  )
end

mopp.cmd.add('advert',AdvertMassage)
mopp.cmd.add('r',AdvertMassage)
mopp.cmd.add('radio',AdvertMassage)

function MeMassage( pPlayer, cmd, args )
	table.remove(args,1)
	local tblPlayers = {}
	for _, v in pairs(ents.FindInSphere(pPlayer:GetPos(),300)) do
		table.insert(tblPlayers,v)
	end
	netstream.Start(tblPlayers, 'ChatMassage', {
		pPlayer = pPlayer,
		pre = "",
		color = team.GetColor(pPlayer:Team()),
		text = string.Implode( " ", args ),
		postcolor = false,
	} )
end

function RPMassage( pPlayer, cmd, args )
	table.remove(args,1)
	netstream.Start(player.GetAll(), 'RPCommands', Color(0, 0, 255), "| ", team.GetColor(pPlayer:Team()), pPlayer:Nick(), Color(255,255,255,255), ': ', Color(225,225,0,255),  string.Implode( " ", args )  )
end

mopp.cmd.add('rp',RPMassage)
mopp.cmd.add('roleplay',RPMassage)

function MeMassage( pPlayer, cmd, args )
	table.remove(args,1)
	local tblPlayers = {}
	for _, v in pairs(ents.FindInSphere(pPlayer:GetPos(),300)) do
		table.insert(tblPlayers,v)
	end
	netstream.Start(tblPlayers, 'ChatMassage', {
		pPlayer = pPlayer,
		pre = "",
		color = team.GetColor(pPlayer:Team()),
		text = string.Implode( " ", args ),
		postcolor = false,
	} )
end
mopp.cmd.add('me',MeMassage)

function RollMassage( pPlayer, cmd, args )
	table.remove(args,1)
	local tblPlayers = {}
	for _, v in pairs(ents.FindInSphere(pPlayer:GetPos(),300)) do
		table.insert(tblPlayers,v)
	end
	netstream.Start(tblPlayers, 'RPCommands', pPlayer, Color(240,240,240,255), ' кинул кубики, и ему выпало ', Color(0,165,240,255), math.random(1,100), Color(240,240,240,255), '.' )
end
mopp.cmd.add('roll',RollMassage)

function TryMassage( pPlayer, cmd, args )
	table.remove(args,1)
	local tblPlayers = {}
	for _, v in pairs(ents.FindInSphere(pPlayer:GetPos(),300)) do
		table.insert(tblPlayers,v)
	end
	local try = math.random(0,6)%2 == 1 and 'неудача' or 'успех'
	netstream.Start(tblPlayers, 'RPCommands', team.GetColor(pPlayer:Team()), pPlayer, Color(240,240,240,255), ' ', string.Implode( " ", args ), ', ', Color(0,165,240,255), try, Color(240,240,240,255), '.'  )
end
mopp.cmd.add('try',TryMassage)


function DoMassage( pPlayer, cmd, args )
	table.remove(args,1)
	local tblPlayers = {}
	for _, v in pairs(ents.FindInSphere(pPlayer:GetPos(),300)) do
		table.insert(tblPlayers,v)
	end
	netstream.Start(tblPlayers, 'RPCommands', Color(255, 255, 0), "<?/¿>", team.GetColor(pPlayer:Team()), pPlayer:Nick(), Color(240,240,240,255), ': ', string.Implode( " ", args )  )
end
mopp.cmd.add('it',DoMassage)

function LOOCMessage( pPlayer, cmd, args )
	table.remove(args,1)
	local tblPlayers = {}
	for _, v in pairs(ents.FindInSphere(pPlayer:GetPos(),300)) do
		table.insert(tblPlayers,v)
	end
	netstream.Start(tblPlayers, 'RPCommands', Color(63,103,124,255), "[LOOC] ",team.GetColor(pPlayer:Team()), Color(63,103,124,255), pPlayer:Nick(), Color(240,240,240,255), ': ', string.Implode( " ", args )  )
end
mopp.cmd.add('looc',LOOCMessage)
mopp.cmd.add('l',LOOCMessage)

function YellMessage( pPlayer, cmd, args )
	table.remove(args,1)
	local tblPlayers = {}
	for _, v in pairs(ents.FindInSphere(pPlayer:GetPos(),500)) do
		table.insert(tblPlayers,v)
	end
	netstream.Start(tblPlayers, 'RPCommands', Color(255,120,57), "(Крик) ",team.GetColor(pPlayer:Team()), pPlayer:Nick(), Color(240,240,240,255), ': ', string.Implode( " ", args )  )
end
mopp.cmd.add('yell',YellMessage)
mopp.cmd.add('y',YellMessage)

function WhisperMessage( pPlayer, cmd, args )
	table.remove(args,1)
	local tblPlayers = {}
	for _, v in pairs(ents.FindInSphere(pPlayer:GetPos(),150)) do
		table.insert(tblPlayers,v)
	end
	netstream.Start(tblPlayers, 'RPCommands', Color(120,255,57), "(Шепот) ",team.GetColor(pPlayer:Team()), pPlayer:Nick(), Color(240,240,240,255), ': ', string.Implode( " ", args )  )
end
mopp.cmd.add('whisper',WhisperMessage)
mopp.cmd.add('w',WhisperMessage)

mopp.cmd.add('whitelist',function( pPlayer )
	if pPlayer:GetUserGroup() == 'founder' or serverguard.player:GetImmunity(pPlayer) > 20 then
		netstream.Start(pPlayer,'WhiteList_OpenMenu',nil)
	end
end)



concommand.Add("hudremove_all", function()

    hook.Add("HUDShouldDraw", "hide hud", function(HLDHUDRemove)

        if HLDHUDRemove == "HUDPaint" or HLDHUDRemove == "BSHUDPAINT" then

            return false

        end

    end)

    hook.Remove("HUDPaint", "H-U-D")

    chat.AddText(Color(0,255,255), "[HUD] ", Color(255,255,255), "You ", Color( 255, 0, 0), "deactivated ", Color( 255, 255, 255), "all Head-up-Displays!")

end)

mopp.cmd.add('offlinelist',function( player, cmd, args )
	-- if player and player:isNearWhitelist() then
	-- 	table.remove(args,1)
	-- 	local find = args[1]
	-- 	if find then
	-- 		if string.sub( find, 1, 6 ) == 'STEAM_' then
	-- 			MySQLite.query( "SELECT * FROM `serverguard_users` WHERE steam_id = '"..find.."'",function(data)
	-- 				if data then
	-- 					-- PrintTable(data[1])
	-- 					local tbl = data[1]
	-- 					tbl.steamid64 = util.SteamIDTo64(tbl.steam_id)
	-- 					MySQLite.query( "SELECT * FROM `mopple_player_data` WHERE community_id = '"..tbl.steamid64.."'",function(data)
	-- 						if data then
	-- 							tbl.mopp = data[1]
	-- 							netstream.Start(player,"OfflineList_OpenProfile",tbl)
	-- 						end
	-- 					end)
	-- 				else
	-- 					player:ChatPrint( 'Мы не нашли такой профиль' )
	-- 				end
	-- 			end)
	-- 		elseif string.sub( args[1], 1, 3 ) == '765' then
	-- 			MySQLite.query( "SELECT * FROM `serverguard_users` WHERE steam_id = '"..util.SteamIDFrom64(find).."'",function(data)
	-- 				if data then
	-- 					-- PrintTable(data[1])
	-- 					local tbl = data[1]
	-- 					tbl.steamid64 = util.SteamIDTo64(tbl.steam_id)
	-- 					MySQLite.query( "SELECT * FROM `mopple_player_data` WHERE community_id = '"..tbl.steamid64.."'",function(data)
	-- 						if data then
	-- 							tbl.mopp = data[1]
	-- 							netstream.Start(player,"OfflineList_OpenProfile",tbl)
	-- 						end
	-- 					end)
	-- 				else
	-- 					player:ChatPrint( 'Мы не нашли такой профиль' )
	-- 				end
	-- 			end)
	-- 		else
	-- 			MySQLite.query( "SELECT * FROM `serverguard_users` WHERE name = '"..find.."'",function(data)
	-- 				if data then
	-- 					-- PrintTable(data[1])
	-- 					local tbl = data[1]
	-- 					tbl.steamid64 = util.SteamIDTo64(tbl.steam_id)
	-- 					MySQLite.query( "SELECT * FROM `mopple_player_data` WHERE steam_id = '"..tbl.steam_id.."'",function(data)
	-- 						if data then
	-- 							tbl.mopp = data[1]
	-- 							netstream.Start(player,"OfflineList_OpenProfile",tbl)
	-- 						end
	-- 					end)
	-- 				else
	-- 					player:ChatPrint( 'Мы не нашли такой профиль' )
	-- 				end
	-- 			end)
	-- 		end
	-- 	-- else
	-- 		-- local teams = {}
	-- 		-- for k, v in pairs(mopp.jobs) do
	-- 		-- 	if v.group_id then
	-- 		-- 		if !teams[v.group_id] then
	-- 		-- 			teams[v.group_id] = {}
	-- 		-- 		end
	-- 		-- 		table.insert(teams[v.group_id],v.jobID)
	-- 		-- 	end
	-- 		-- end
	-- 		-- local count_teams = {}
	-- 		-- -- PrintTable(teams)


	-- 		-- -- MySQLite.query( [[SELECT (SELECT COUNT(*) FROM `mopple_player_data` WHERE `team`='cadet'),
	-- 		-- --   (SELECT COUNT(*) FROM `mopple_player_data` WHERE `team`='ctrp')]],function(data)
	-- 		-- -- 	if data then
	-- 		-- -- 		PrintTable(data)
	-- 		-- -- 		for k, v in pairs()
	-- 		-- -- 	end
	-- 		-- -- end)

	-- 		-- player:ChatPrint( 'fff' )
	-- 	end
	-- end
end)

mopp.cmd.add('eventroom',function( pPlayer )
	if table.HasValue(mopp.cfg.EventroomAllowedGroups,pPlayer:GetUserGroup()) then
		netstream.Start(pPlayer,'EventRoom_OpenMenu')
	end
end)

if SERVER then
	concommand.Add( "mopp", mopp.cmd.callback, mopp.cmd.autoComplete, 'This is a basic command for mopp gamemode.' )
	netstream.Hook("mopp.command.SendCommandsToServer", function(pPlayer, data)
		mopp.cmd.callback(pPlayer, data.cmd, data.args)
	end);

	hook.Add("PlayerSay","mopp.command.PlayerSay",function(pPlayer,strMsg)
	 	strMsg = string.Explode(" ",strMsg)
	 	for k, v in pairs(mopp.cmd.data) do
	 		if "/"..k == strMsg[1] then
	 			strMsg[1] = string.gsub(strMsg[1], "/", "")
				v(pPlayer, "mopp", strMsg)
				return ''
	 		end
	 	end
	 end)
else
	concommand.Add( "mopp", function(pPlayer,cmd,args)
		netstream.Start("mopp.command.SendCommandsToServer", {
			args = args,
			cmd = cmd
		})
	end, mopp.cmd.autoComplete, 'This is a basic command for mopp gamemode.' )

	netstream.Hook("ChatMassage", function(data)
		pCaller = data.pPlayer
		if pCaller and pCaller:IsPlayer() then
			color, pre = data.color, data.pre
			postcolor = data.postcolor == false and '' or Color(255,255,255)
			postname = data.postcolor == false and ' ' or ': '
			chat.AddText(color, pre, team.GetColor(pCaller:Team()), pCaller:Name(), postcolor, postname, data.text)
		end
	end);

	netstream.Hook("RPCommands", function(...)
		chat.AddText(...)
	end);
end
