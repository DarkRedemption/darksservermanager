--Tracks when someone uses the !server command to join another server, which one it joined, and at what time.
--Was originally not going to track identities it is necessary to detect data anomalies, i.e. people spamming "connect".
--Would MUCH prefer to anonymize it somehow. Will see if there's an SHA/MD5 solution of sorts for gmod.
--Just tried the one on http://lua-users.org/wiki/SecureHashAlgorithm and it didn't work because gmod can't see the bit32 class.

local columns = " ( id INTEGER PRIMARY KEY, steam_id STRING, server_name STRING, timestamp INTEGER )"
local conversionsTable = DSM.Database.Table:new("dsm_affiliatedservers_conversions", columns)

function conversionsTable:addConversion(ply, serverName)
  local query = "INSERT INTO " .. self.tableName .. " (steam_id, server_name, timestamp) VALUES (\"" .. ply:SteamID() .. "\", \"" .. serverName .. "\", " .. os.time() .. ")"
  return self:insert(query)
end

DSM.AffiliatedServers.Database.Tables.Conversions = conversionsTable
conversionsTable:create()