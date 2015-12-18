-- From http://lua-users.org/wiki/StringRecipes
function string.starts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

local function processModCallCommand(ply, text)
  if (text:len() < 11 || text[10] != " ") then
    ply:PrintMessage(HUD_PRINTTALK, "Usage: !callmods <message>")
  else
    local message = string.sub(text, 11, string.len(text))
    net.Start("CallMods")
    net.WriteString(message)
    net.SendToServer()
  end
end


local function checkForModCallCommand(ply, text)
  if (text:len() < 9) then return false end
  if (string.starts(string.lower(text), "!callmods")) then
    if (LocalPlayer() == ply) then
      processModCallCommand(ply, text)
    end
    return true
  end
  return false
end

hook.Add("OnPlayerChat", "Call for mods", function(ply, text, team, isDead)
    if (checkForModCallCommand(ply, text)) then
      return true
    end
  end)