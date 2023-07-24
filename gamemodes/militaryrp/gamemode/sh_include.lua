mopp.util.include_sv = (SERVER) and include or function() end
mopp.util.include_cl = (SERVER) and AddCSLuaFile or include

mopp.util.include_sh = function(f)
	mopp.util.include_sv(f)
	mopp.util.include_cl(f)
end

-- Includes a file from the prefix.
function mopp.util.include_load(fileName, strState)
	-- Only include server-side if we're on the server.
	if ((strState == "server" or string.find(fileName, "sv_")) and SERVER) then
		mopp.util.include_sv(fileName)
	-- Shared is included by both server and client.
	elseif (strState == "shared" or string.find(fileName, "sh_")) then
		mopp.util.include_sh(fileName)
	-- File is sent to client, included on client.
	elseif (strState == "client" or string.find(fileName, "cl_")) then
		mopp.util.include_cl(fileName)
	end
end


-- Include files based off the prefix within a directory.
function mopp.util.include_dir(directory)
	local fol = GM.FolderName .. '/gamemode/' .. directory .. '/'

	-- Find all of the files within the directory.
	for k, v in ipairs(file.Find(fol .. '*', 'LUA')) do
		local fileName = directory..'/'..v
		mopp.util.include_load(fileName)
	end

	local _, folders = file.Find(fol .. '*', 'LUA')
	for k, folder in ipairs(folders) do
		for k, v in ipairs(file.Find(fol .. folder .. '/*', 'LUA')) do
			local fileName = fol .. folder .. '/' .. v
			mopp.util.include_load(fileName)
		end
	end
end

local libs_isload

if !libs_isload then -- include libraries
	mopp.util.include_sh 'libs/pon.lua'
	mopp.util.include_sh 'libs/netstream.lua'
	mopp.util.include_sh 'libs/nw.lua'
	mopp.util.include_sv 'libs/mysqlite.lua'
	mopp.util.include_sh 'libs/shits.lua'

	libs_isload = true
end

mopp.util.include_cl 'cfg/cl_fonts.lua'
mopp.util.include_sv 'cfg/sv_config.lua'
mopp.util.include_sh 'cfg/sh_config.lua'
mopp.util.include_sh 'core/sh_logs.lua'

mopp.util.include_cl 'core/cl_core.lua'
mopp.util.include_sh 'core/sh_player.lua'
mopp.util.include_sh 'core/sh_playerclass.lua'
mopp.util.include_dir 'core'
mopp.util.include_dir 'modules'