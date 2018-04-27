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

  def find(tag, list) do
    [{key, val}|t]=@ids
    case key==tag do
     true   -> find_in_list(val, list)
     false -> find(tag, list, t)
    end
  end

  def find(tag, list, []), do: tag
  def find(tag, list, [{key, val}|_t]) when key==tag, do: find_in_list(val, list) 
  def find(tag, list, [{key, val}|t]), do: find(tag, list, t)

  def find_in_list(tag, []), do: tag
  def find_in_list(tag, [{key, value}|rest]=list) when key==tag, do: value
  def find_in_list(tag, [{key, value}|rest]=list), do: find_in_list(tag, rest)

end


