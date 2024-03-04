class OpponentTeamLineUp < ApplicationRecord
  has_one :opponent_team
  belongs_to :event
  belongs_to :user
  belongs_to :opponent_rooster
  belongs_to :tournament
  has_many :positions
  validates :batter_order, :opponent_rooster_id, :position_id, presence: true
  validates :batter_order, numericality: { less_than_or_equal_to: 10 }
  # def complete?
  #   all_positions = Position.pluck(:id)
  #   selected_positions = self.opponent_team_line_ups.pluck(:position_id)
  #   all_positions.sort == selected_positions.sort
  # end

  def complete?
    all_positions = Position.count
    selected_positions = self.position_id
    all_positions == selected_positions
  end

end
