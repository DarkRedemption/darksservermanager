local server1DescriptionParagraph1 = DSM.AffiliatedServers.DescriptionParagraph:new(255, 0, 0, 255, "Maybe something like you need Counter-Strike: Source Textures to play on this server?\n\n")
local server1DescriptionParagraph2 = DSM.AffiliatedServers.DescriptionParagraph:new(0, 0, 0, 255, "Regular description goes here.")
local server1DescriptionArray = {}

table.insert(server1DescriptionArray, server1DescriptionParagraph1)
table.insert(server1DescriptionArray, server1DescriptionParagraph2)
local server1 = DSM.AffiliatedServers.ServerListing:new("Local Test Server", "TTT", "127.0.0.1", 27015, server1DescriptionArray)

server1:addToList()