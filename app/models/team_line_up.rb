class TeamLineUp < ApplicationRecord
  has_one :team
  belongs_to :event
  belongs_to :user
  belongs_to :rooster
  belongs_to :tournament
  has_many :positions
  
  validates :rooster_id, presence: true
end
