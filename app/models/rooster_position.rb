class RoosterPosition < ApplicationRecord
  belongs_to :user
  belongs_to :scoreboard
  has_many :events
  has_many :positions
  
end


