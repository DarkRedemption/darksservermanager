local DescriptionParagraph = {}

function DescriptionParagraph:new(red, green, blue, alpha, text)
  local newParagraph = {}
  setmetatable(newParagraph, self)
  self.__index = self
  newParagraph.red = red
  newParagraph.green = green
  newParagraph.blue = blue
  newParagraph.alpha = alpha
  newParagraph.text = text
  return newParagraph
end

function DescriptionParagraph:addToRichText(richTextPanel)
  richTextPanel:InsertColorChange(self.red, self.green, self.blue, self.alpha)
  richTextPanel:AppendText(self.text)
end

function DescriptionParagraph:serialize()
  net.WriteUInt(self.red, 8)
  net.WriteUInt(self.green, 8)
  net.WriteUInt(self.blue, 8)
  net.WriteUInt(self.alpha, 8)
  net.WriteString(self.text)
end

function DescriptionParagraph:deserialize()
  local red = net.ReadUInt(8)
  local green = net.ReadUInt(8)
  local blue = net.ReadUInt(8)
  local alpha = net.ReadUInt(8)
  local text = net.ReadString()
  return DescriptionParagraph:new(red, green, blue, alpha, text)
end

DSM.AffiliatedServers.DescriptionParagraph = DescriptionParagraph