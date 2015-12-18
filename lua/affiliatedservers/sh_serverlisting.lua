local ServerListing = {}

function ServerListing:addToList()
  table.insert(DSM.AffiliatedServers, self)
end

function ServerListing:renderDescription(richTextPanel)
  for key, descriptionParagraph in ipairs(self.descriptionArray) do
    descriptionParagraph:addToRichText(richTextPanel)
  end
end

function ServerListing:descriptionArraySize()
  local descriptionArraySize = 0
   for key, value in ipairs(self.descriptionArray) do
     descriptionArraySize = descriptionArraySize + 1
    end
   return descriptionArraySize
end

function ServerListing:serialize()
  net.WriteString(self.name)
  net.WriteString(self.gameType)
  net.WriteString(self.ip)
  net.WriteUInt(self.port, 16)
  local descriptionArraySize = self:descriptionArraySize()
  net.WriteUInt(descriptionArraySize, 8)
  for k,descriptionParagraph in ipairs(self.descriptionArray) do
    descriptionParagraph:serialize()
  end
end

function ServerListing.deserialize()
  local name = net.ReadString()
  local gameType = net.ReadString()
  local ip = net.ReadString()
  local port = net.ReadUInt(16)
  local descriptionArraySize = net.ReadUInt(8)
  local descriptionArray = {}
  for i=1,descriptionArraySize,1 do
    local descriptionParagraph = DSM.AffiliatedServers.DescriptionParagraph.deserialize()
    table.insert(descriptionArray, descriptionParagraph)
  end
  return ServerListing:new(name, gameType, ip, port, descriptionArray)
end

function ServerListing:new(name, gameType, ip, port, descriptionArray)
   local newListing = {}
   setmetatable(newListing, self)
   self.__index = self
   newListing.name = name
   newListing.gameType = gameType
   newListing.ip = ip
   newListing.port = port
   newListing.descriptionArray = descriptionArray
   return newListing
end

DSM.AffiliatedServers.ServerListing = ServerListing
