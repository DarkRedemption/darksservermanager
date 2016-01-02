if !SERVER then return end
if !sql.TableExists( "utime" ) then
  println("Dark's Server Manager: Utime not found. Tagger cannot initialize.") 
  return 
end

DSM.Tagger = {}
DSM.Tagger.Config = {}

include("sv_rank.lua")
include("config/sv_taggerconfig.lua")

hook.Add("TTTPrepareRound", "DSMPromoteCheck", function()
    local players = player.GetAll()
    for k, ply in ipairs(players) do
      for rk, rank in ipairs(DSM.Tagger.Config.Ranks) do
        rank:promotePlayerIfQualified(ply)
      end
    end
  end
)
