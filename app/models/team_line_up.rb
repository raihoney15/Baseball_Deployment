class TeamLineUp < ApplicationRecord
  has_one :team,dependent: :destroy
  belongs_to :event
  belongs_to :user
  belongs_to :rooster
  belongs_to :tournament
  has_many :positions,dependent: :destroy

  validates :batter_order, :rooster_id, :position_id, presence: true

end
