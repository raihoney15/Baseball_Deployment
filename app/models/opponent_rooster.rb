class OpponentRooster < ApplicationRecord
  belongs_to :user
  # belongs_to :tournament
  belongs_to :opponent_team
end
