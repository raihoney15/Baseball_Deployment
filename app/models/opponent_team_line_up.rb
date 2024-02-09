class OpponentTeamLineUp < ApplicationRecord
  has_one :opponent_team
  belongs_to :event
  belongs_to :user
  belongs_to :opponent_rooster
  belongs_to :tournament
  has_many :positions
  validates :batter_order, :rooster_id, :position_id, presence: true


end
