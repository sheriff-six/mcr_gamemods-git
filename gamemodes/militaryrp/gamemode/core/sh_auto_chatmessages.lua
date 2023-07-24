AddCSLuaFile()

local PREFIX = {Color(243,79,79), "[Уведомление] "}
local text = Color(254,249,187)



local MESSAGES = {

	{text, "Приветсвуем на ", text, " MCR Team! "},
	{text, "Для того, чтобы узнать информацию о здоровье нажмите на T"},
}


if (SERVER) then
	local CYCLE_TIME = 200
	util.AddNetworkString("AutoChatMessage")
	local curmsg = 1
	timer.Create("AutoChatMessages", CYCLE_TIME, 0, function()
		net.Start("AutoChatMessage")
			net.WriteUInt(curmsg, 16)
		net.Broadcast()
		curmsg = curmsg + 1
	if (curmsg > #MESSAGES) then
		curmsg = 1
		end
	end)
else

	net.Receive("AutoChatMessage", function()
		local t = {}
		table.Add(t, PREFIX)
		table.Add(t, MESSAGES[net.ReadUInt(16)])
		chat.AddText(unpack(t))
	end)
end
AddCSLuaFile()

local PREFIX = {Color(243,79,79), "[Уведомление] "}
local text = Color(254,249,187)



local MESSAGES = {

	{text, "Приветсвуем на ", text, " MCR Team! "},
	{text, "Для того, чтобы узнать информацию о здоровье нажмите на T"},
}


if (SERVER) then
	local CYCLE_TIME = 200
	util.AddNetworkString("AutoChatMessage")
	local curmsg = 1
	timer.Create("AutoChatMessages", CYCLE_TIME, 0, function()
		net.Start("AutoChatMessage")
			net.WriteUInt(curmsg, 16)
		net.Broadcast()
		curmsg = curmsg + 1
	if (curmsg > #MESSAGES) then
		curmsg = 1
		end
	end)
else

	net.Receive("AutoChatMessage", function()
		local t = {}
		table.Add(t, PREFIX)
		table.Add(t, MESSAGES[net.ReadUInt(16)])
		chat.AddText(unpack(t))
	end)
end
