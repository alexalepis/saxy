defmodule IDs do
  @ids [
    {"Mkt", "mkt_id"},
    {"Seln", "seln_id"},
    {"Incident", "incident_id"},
    {"Team", "team_id"},
    {"PeriodScore", "period"},
    {"Inplay", "inplay_period_num"},
    {"Player", "player_id"},
    {"EvDetail", "br_match_id"},
    {"Participant", "full_name"},
    {"Score", "name"},
    {"MatchStatus", "status_code"},
    # {"Price", "prc_type"},
    {"InplayDetail", "period_start"},
    {"MatchStat", "name"},
    {"Stat", "name"}
  ]

  def find(tag) do
    [{key, val}|t]=@ids
    case key==tag do
     true   -> val
     false -> find(tag, t)
    end
  end

  def find(tag, []), do: nil
  def find(tag, [{key, val}|_t]) when key==tag, do: val 
  def find(tag, [{key, val}|t]), do: find(tag, t)
end
