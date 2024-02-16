class EventInning < ApplicationRecord
  belongs_to :event
  # belongs_to :scoreboard
  # has_many :rooster_positions, dependent : :destroy
  has_many :rooster_positions,dependent: :destroy
end
 