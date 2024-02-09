class OpponentRooster < ApplicationRecord
  belongs_to :user
  belongs_to :opponent_team
  has_one_attached :image ,dependent: :destroy
  validates :name, :jersey_number, presence: true



end
