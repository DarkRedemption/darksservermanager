--Contains the functions necessary to populate the servers window on the client.

util.AddNetworkString("DSM_GetServerList")
net.Receive("DSM_GetServerList", function(len, ply)
    local count = 0
    for key, value in ipairs(DSM.AffiliatedServers) do
      count = count + 1
    end
    
    net.Start("DSM_GetServerList")
    net.WriteInt(count, 8)
    for key, server in ipairs(DSM.AffiliatedServers) do
      server:serialize()
    end
    
    net.Send(ply)
  end)