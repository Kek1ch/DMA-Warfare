util.AddNetworkString("Ele_TimeoutPing")

net.Receive("Ele_TimeoutPing", function(len, ply)
	net.Start("Ele_TimeoutPing")
		net.WriteBit(true)
	net.Send(ply)
end)