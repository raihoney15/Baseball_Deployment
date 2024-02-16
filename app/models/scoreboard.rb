class Scoreboard < ApplicationRecord
  belongs_to :event
  # has_many :event_inning
  has_many :rooster_positions,dependent: :destroy 
end
  