class RoosterPosition < ApplicationRecord
  belongs_to :user, :optional => true
  belongs_to :scoreboard, :optional => true
  has_many :events
  has_many :positions
  
end


