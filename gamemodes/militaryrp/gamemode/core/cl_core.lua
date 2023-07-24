local hide = {
	CHudHealth = true,
	CHudBattery = true,
	CHudCrosshair = true,
	CHudDamageIndicator = true,
	CHudHintDisplay = true,
	CHudZoom = true,
}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then return false end

	-- Don't return anything here, it may break other addons that rely on this hook.
end )

local commands = {
	'stopsound',
	'fov_desired 90',
	-- 'cl_cmdrate 16',
	-- 'cl_interp 0.1',
	'cl_interp_ratio 1',
	'cl_lagcompensation 1',
	-- 'cl_updaterate 16',
	'rate 80000',
	'gmod_mcore_test 1',
	'mat_queue_mode -1',
	'cl_threaded_bone_setup 1',
	'rope_smooth 0',
	'Rope_wind_dist 0',
	'Rope_shake 0',
	'violence_ablood 1',
	'cl_threaded_client_leaf_system 0',
	'r_queued_ropes 1',
	'r_threaded_client_shadow_manager 1',
	'r_fastzreject -1',
	'Cl_ejectbrass 0',
	'Muzzleflash_light 0',
	'cl_wpn_sway_interp 0',
	'in_usekeyboardsampletime 0',
	'cl_cmdrate 33',
	'cl_updaterate 33',
	'rate 40000',
}

if mopp.util.CurentMap == mopp.cfg.DefaultMainMap then
	table.insert(commands,'cl_interp 0.1')
else
	table.insert(commands,'cl_interp 0.2')
end

-- cl_cmdrate 33; cl_updaterate 33; cl_interp_ratio 1; cl_interp 0.3; rate 40000


hook.Add('InitPostEntity', 'CilentInitPostEntity_RunConCommands', function()
	LocalPlayer():ConCommand(string.Implode( "; ", commands ))
end)

netstream.Hook("UpdateItems", function(data)
	LocalPlayer().itemList = data
end)

timer.Create("CleanBodys", 60, 0, function()
	RunConsoleCommand("r_cleardecals")
	for k, v in ipairs(ents.FindByClass("class C_ClientRagdoll")) do
		v:Remove()
	end
	for k, v in ipairs(ents.FindByClass("class C_PhysPropClientside")) do
		v:Remove()
	end
end)

LocalPlayer().Thirtperson = util.JSONToTable(file.Read( "tfc.txt", "DATA" ) or '') or {}