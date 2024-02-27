class OpponentRooster < ApplicationRecord
  belongs_to :user
  belongs_to :opponent_team
  has_one_attached :image ,dependent: :destroy
  validates :name, :jersey_number, presence: true
  has_many :batting_stats	, dependent: :destroy
  has_many :pitching_stats, dependent: :destroy	



end
