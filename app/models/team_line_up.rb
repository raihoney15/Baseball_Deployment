class TeamLineUp < ApplicationRecord
  has_one :team,dependent: :destroy
  belongs_to :event
  belongs_to :user
  belongs_to :rooster
  belongs_to :tournament
  has_many :positions,dependent: :destroy

  validates :batter_order, :rooster_id, :position_id, presence: true
  validates :batter_order, numericality: { less_than_or_equal_to: 10 }

  # def complete?
  #   all_positions = Position.pluck(:id)
  #   selected_positions = self.position_id
  #   all_positions.sort == selected_positions.sort
  # end
# app/models/team_line_up.rb

  def complete?
    all_positions = Position.count
    selected_positions = self.position_id
    all_positions == selected_positions
  end



end
