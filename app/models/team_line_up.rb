class TeamLineUp < ApplicationRecord
  belongs_to :event
  belongs_to :user
  belongs_to :rooster
  belongs_to :team
  # belongs_to :position
  has_many :positions
end
