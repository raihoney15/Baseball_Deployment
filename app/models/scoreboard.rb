class Scoreboard < ApplicationRecord
  belongs_to :event
  has_many :rooster_positions
  has_many :innings
end
