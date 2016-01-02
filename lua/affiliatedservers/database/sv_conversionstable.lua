--Tracks when someone uses the !server command to join another server, which one it joined, and at what time.
--Tracks SteamIDs anonymized through SHA1.

local columns = " ( id INTEGER PRIMARY KEY, steam_id_sha1 STRING, server_name STRING, timestamp INTEGER )"
local conversionsTable = DSM.Database.Table:new("dsm_affiliatedservers_conversions", columns)

function conversionsTable:addConversion(ply, serverName)
  local hashedSteamId = DSM.Hashing.Sha1(ply:SteamID())
  local query = "INSERT INTO " .. self.tableName .. " (steam_id_sha1, server_name, timestamp) VALUES (\"" .. hashedSteamId .. "\", \"" .. serverName .. "\", " .. os.time() .. ")"
  return self:insert(query)
end


function conversionsTable:getAllConversions()
  return conversionsTable:getConversionsInTimeframe(0, os.time())
end

function conversionsTable:getConversionsSince(startTime)
  return conversionsTable:getConversionsInTimeframe(startTime, os.time())
end

function conversionsTable:getConversionsInTimeframe(startTime, endTime)
  local query = "SELECT * FROM " .. self.tableName .. " WHERE timestamp >= " .. startTime .. " AND timestamp <= " .. endTime
  return sql.Query(query)
end

function conversionsTable:getTotalConversions()
  return conversionsTable:getConversionsInTimeframe(0, os.time())
end

function conversionsTable:getNumConversionsSince(startTime)
  return conversionsTable:GetConversionsInTimeframe(startTime, os.time())
end

function conversionsTable:getNumConversionsInTimeframe(startTime, endTime)
 local query = "SELECT COUNT(*) FROM " .. self.tableName .. " WHERE timestamp >= " .. startTime .. " AND timestamp <= " .. endTime
 return sql.Query(query)
end

DSM.AffiliatedServers.Database.Tables.Conversions = conversionsTable
conversionsTable:create()