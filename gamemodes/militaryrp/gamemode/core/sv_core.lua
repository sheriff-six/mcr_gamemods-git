hook.Add( "PreGamemodeLoaded", "widgets_disabler_cpu", function()
	MsgN( "Disabling widgets..." )
	function widgets.PlayerTick()
		-- empty
	end
	MsgN( "Widgets disabled!" )
end )