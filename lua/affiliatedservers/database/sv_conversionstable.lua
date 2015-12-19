--Tracks when someone uses the !server command to join another server, which one it joined, and at what time.
--Tracks SteamIDs anonymized through SHA1.

local columns = " ( id INTEGER PRIMARY KEY, steam_id_sha1 STRING, server_name STRING, timestamp INTEGER )"
local conversionsTable = DSM.Database.Table:new("dsm_affiliatedservers_conversions", columns)

function conversionsTable:addConversion(ply, serverName)
  local hashedSteamId = DSM.Hashing.Sha1(ply:SteamID())
  local query = "INSERT INTO " .. self.tableName .. " (steam_id_sha1, server_name, timestamp) VALUES (\"" .. hashedSteamId .. "\", \"" .. serverName .. "\", " .. os.time() .. ")"
  return self:insert(query)
end

DSM.AffiliatedServers.Database.Tables.Conversions = conversionsTable
conversionsTable:create()