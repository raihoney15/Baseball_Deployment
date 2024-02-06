class OpponentTeamLineUp < ApplicationRecord
  belongs_to :event
  belongs_to :user
  belongs_to :opponent_rooster
  belongs_to :opponent_team
  # belongs_to :position
  has_many :positions
end
