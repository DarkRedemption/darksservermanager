local Table = {}
Table.tableName = ""
Table.columns = ""
Table.__index = Table

function Table:create()
   if (!sql.TableExists(self.tableName)) then
      --DSM.logDebug("Table " .. self.tableName .. " does not exist. Now creating.")
      local result = sql.Query("CREATE TABLE " .. self.tableName .. " " .. self.columns)
   else
      --DSM.logDebug("Table " .. self.tableName .. " already exists.")
  end
end

function Table:insert(insertQuery)
  --DSM.logDebug("Now inserting " .. insertQuery)
  local result = sql.Query(insertQuery)
  if (!IsValid(result)) then -- A successful INSERT returns nil.
    --DSM.logDebug("Insert into table " .. self.tableName .. " was successful.")
    return true
  else
    --DSM.logError("Could not insert into table " .. self.tableName .. "!")
    return false
  end
end

function Table:new(tableName, columns)
  local newTable = {}
  setmetatable(newTable, self)
  newTable.tableName = tableName
  newTable.columns = columns
  return newTable
end

DSM.Database.Table = Table