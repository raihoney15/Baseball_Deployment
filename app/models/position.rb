class Position < ApplicationRecord
    belongs_to :team_line_up, :optional => true
    belongs_to :opponent_team_line_up, :optional => true
    belongs_to :rooster_position, :optional => true
end
