local rank = {}

 function rank:new(group, previousGroup, requiredSeconds)
      newRank = {} 
      setmetatable(newRank, self)
      self.__index = self
      newRank.group = group
      newRank.previousGroup = previousGroup
      newRank.requiredSeconds = requiredSeconds
      return newRank
    end

function rank:playerIsQualified(ply)
  if (ply:IsUserGroup(self.previousGroup) && !ply:IsBot()) then
    local result = sql.Query("SELECT * FROM utime WHERE player == " .. ply:UniqueID( ))
    if (result != nil) then
      return tonumber(result[1]["totaltime"]) >= self.requiredSeconds
    end
  end
  return false
end

function rank:promotePlayer(ply)
  RunConsoleCommand("ulx", "adduserid", ply:SteamID(), self.group)
  PrintMessage(HUD_PRINTTALK, ply:GetName() .. " has been autopromoted to " .. self.group .. "!")
end

function rank:promotePlayerIfQualified(ply)
  if (self:playerIsQualified(ply)) then
    self:promotePlayer(ply)
  end
end

DSM.Tagger.Rank = rank