class RoosterPosition < ApplicationRecord
  belongs_to :user, :optional => true
  belongs_to :scoreboard
  has_many :events
  has_many :positions
  
end


