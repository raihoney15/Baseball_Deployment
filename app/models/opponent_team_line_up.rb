class OpponentTeamLineUp < ApplicationRecord
  has_one :opponent_team
  belongs_to :event
  belongs_to :user
  belongs_to :opponent_rooster
  belongs_to :tournament
  has_many :positions
  validates :batter_order, :opponent_rooster_id, :position_id, presence: true
  validates :batter_order, numericality: { less_than_or_equal_to: 10 }
  validates :batter_order, uniqueness: { scope: :event_id, message: "already taken." }


  def complete?
    all_positions = Position.count
    selected_positions = self.position_id
    all_positions == selected_positions
  end

end

