local http = {}

-- bromsock is used to send packets from inside of gmod to other servers.
-- Download from https://github.com/Bromvlieg/gm_bromsock/
require( "bromsock" );

-- url: An HTTP url, starting with http://
-- method: GET or POST
-- postdatatbl: nil, unles you have POST set as method, then a key/value table containing the data
-- callback: function(table headers, string body)
function http.HTTPRequest(url, method, postdatatbl, callback)
	if (string.StartWith(url, "http://")) then
		url = string.Right(url, #url - 7)
	end

	local host = ""
	local path = ""
	local postdata = ""
	local bigbooty = ""
	
	local headers = nil
	local chunkedmode = false
	local chunkedmodedata = false
	
	local pathindex = string.IndexOf("/", url)
	if (pathindex > -1) then
		host = string.sub(url, 1, pathindex - 1)
		path = string.sub(url, pathindex)
	else
		host = url
	end
	
	if (#path == 0) then path = "/" end
	
	if (postdatatbl) then
		for k, v in pairs(postdatatbl) do
			postdata = postdata .. k .. "=" .. v .. "&"
		end
		
		if (#postdata > 0) then
			postdata = string.Left(postdata, #postdata - 1)
		end
	end

	local pClient = BromSock();
	local pPacket = BromPacket();
	
	pClient:SetCallbackConnect( function( _, bConnected, szIP, iPort )
		if (not bConnected) then
			callback(nil, nil)
			return;
		end
		
		pPacket:WriteLine(method .. " " .. path .. " HTTP/1.1");
		pPacket:WriteLine("Host: " .. host);
		if (method:lower() == "post") then
			pPacket:WriteLine("Content-Type: application/x-www-form-urlencoded");
			pPacket:WriteLine("Content-Length: " .. #postdata);
		end
		
		pPacket:WriteLine("");
		
		if (method:lower() == "post") then
			pPacket:WriteLine(postdata)
      print(postdata)
		end

		pClient:Send( pPacket, true );
		pClient:ReceiveUntil( "\r\n\r\n" );
	end );
	
	pClient:SetCallbackReceive( function( _, incommingpacket )
		local szMessage = incommingpacket:ReadStringAll():Trim()
		incommingpacket = nil
		
		if (not headers) then
			local headers_tmp = string.Explode("\r\n", szMessage)
			headers = {}
			
			local statusrow = headers_tmp[1]
			table.remove(headers_tmp, 1)
			
			headers["status"] = statusrow:sub(10)
			for k, v in ipairs(headers_tmp) do
				local tmp = string.Explode(": ", v)
				headers[tmp[1]:lower()] = tmp[2]
			end
			
			if (headers["content-length"]) then
				pClient:Receive(tonumber(headers["content-length"]));
			elseif (headers["transfer-encoding"] and headers["transfer-encoding"] == "chunked") then
				chunkedmode = true
				pClient:ReceiveUntil( "\r\n" );
			else
				-- This is why we can't have nice fucking things.
				pClient:Receive(99999);
			end
		elseif (chunkedmode) then
			if (chunkedmodedata) then
				bigbooty = bigbooty .. szMessage
				chunkedmodedata = false
				pClient:ReceiveUntil( "\r\n" );
			else
				local len = tonumber(szMessage, 16)
				if (len == 0) then
					callback(headers, bigbooty)
					pClient:Close()
					pClient = nil
					pPacket = nil
					return
				end
				
				chunkedmodedata = true
				pClient:Receive(len + 2) -- + 2 for \r\n, stilly chunked mode
			end
		else
			callback(headers, szMessage)
			pClient:Close()
			pClient = nil
			pPacket = nil
		end
	end)
	
	pClient:Connect(host, 80);
end

-- Why is this not in the default string.lua?
function string.IndexOf(needle, haystack)
	for i = 1, #haystack do
		if (haystack[i] == needle) then
			return i
		end
	end
	
	return -1
end

-- From http://lua-users.org/wiki/StringRecipes
function string.starts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

-- Wrap a string in quotes so it can be sent to a php post.
local function stringWrap(string)
  return "\"" .. string .. "\""
end

local function callMods(ply, message)
    local postDataTable = {}
    local emails = ""
    
    --Turn all the emails into a string that can be turned into an array using a comma as a delimiter.
    for key, address in ipairs(DSM.Config.CallMods.Emails) do
      if (emails == "") then
        emails = address
      else
        emails = emails .. "," .. address
      end
    end
    
    postDataTable["emails"] = stringWrap(emails)
    postDataTable["playername"] = stringWrap(ply:GetName())
    postDataTable["servername"] = stringWrap(GetHostName())
    postDataTable["message"] = stringWrap(message)
    
    http.HTTPRequest(DSM.Config.CallMods.MailerUrl, "POST", postDataTable, function(headers, body)
        print("Mail sent.")
        print(headers)
        print(body)
      end)
end

local function userIsNotOnCooldown(ply)
  local lastCallTable = DSM.Config.CallMods.UserLastCallTable
  local cooldown = DSM.Config.CallMods.UserCooldown
  local steamId = ply:SteamID()
  local lastCalled = lastCallTable[steamId]
  if (lastCalled == nil) then
    return true
  else
    local cooldownTimePassed = os.time() - lastCalled
    local cooldownTimeRemaining = cooldown - cooldownTimePassed
    if (cooldownTimePassed >= cooldown) then
      return true
    else
      ply:PrintMessage(HUD_PRINTTALK, "You've recently contacted the mods, and are on cooldown. Time remaining: " .. cooldownTimeRemaining .. " seconds")
    end
  end
  return false
end

local function serverIsNotOnCooldown(ply)
  local cooldown = DSM.Config.CallMods.ServerCooldown
  local steamId = ply:SteamID()
  local lastCalled = DSM.Config.CallMods.ServerLastCall
  local cooldownTimePassed = os.time() - lastCalled
  local cooldownTimeRemaining = cooldown - cooldownTimePassed
  if (cooldownTimePassed >= cooldown) then
    return true
  else
    ply:PrintMessage(HUD_PRINTTALK, "Someone else on the server has recently contacted the mods. Time remaining: " .. cooldownTimeRemaining .. " seconds")
    return false
  end
end

local function notBlacklisted(ply)
  for key, steamid in ipairs(DSM.Config.CallMods.Blacklist) do
    if (ply:SteamID() == steamid) then
      ply:PrintMessage(HUD_PRINTTALK, "Due to your abuse of !callmods, you have been placed on the blacklist. You cannot use this command.")
      return false      
    end
  end
  return true
end

local function hasPermissions(ply)
   for key, group in ipairs(DSM.Config.CallMods.AuthorizedUserGroups) do
    if (ply:IsUserGroup(group)) then
      return true
    end
  end
  ply:PrintMessage(HUD_PRINTTALK, "You do not have the necessary permissions to use !callmods. Play here more and earn the trust of the mods to get it.")
  return false 
end

local function updateCooldowns(ply)
  DSM.Config.CallMods.ServerLastCall = os.time()
  DSM.Config.CallMods.UserLastCallTable[ply:SteamID()] = os.time()
end

local function processModCallCommand(ply, text)
  if (notBlacklisted(ply) && hasPermissions(ply)) then
    if (text:len() < 11 || text[10] != " ") then
      ply:PrintMessage(HUD_PRINTTALK, "Usage: !callmods <message>")
    elseif (userIsNotOnCooldown(ply) && serverIsNotOnCooldown(ply)) then
      callMods(ply, string.sub(text, 11, string.len(text)))
      ply:PrintMessage(HUD_PRINTTALK, "Now attempting to send an email to the mods/admins.")
      updateCooldowns(ply)
   end
  end
end

local function checkForModCallCommand(ply, text)
  if (text:len() < 9) then return false end
  if (string.starts(string.lower(text), "!callmods")) then
    processModCallCommand(ply, text)
    return ""
  end
  return text
end

hook.Add("PlayerSay", "Call for mods", function(ply, text, team)
    if (checkForModCallCommand(ply, text)) then
      return ""
    end
  end)