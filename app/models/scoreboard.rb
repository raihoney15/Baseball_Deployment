class Scoreboard < ApplicationRecord
  belongs_to :event
  has_many :event_inning,dependent: :destroy
  has_many :rooster_positions,dependent: :destroy
  has_many :batting_stats	, dependent: :destroy
  has_many :pitching_stats, dependent: :destroy	 
end
  