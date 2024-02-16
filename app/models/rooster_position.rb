class RoosterPosition < ApplicationRecord
  belongs_to :user
  belongs_to :scoreboard
  
end
