class PitchingStat < ApplicationRecord
  belongs_to :event
  belongs_to :opponent_team, optional:true
  belongs_to :opponent_rooster,optional:true
  belongs_to :team,optional:true
  belongs_to :rooster,optional:true
  belongs_to :scoreboard


end