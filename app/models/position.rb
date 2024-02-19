class Position < ApplicationRecord
    belongs_to :team_line_up
    belongs_to :opponent_team_line_up
    belongs_to :rooster_positions
end
