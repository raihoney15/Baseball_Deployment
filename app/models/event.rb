class Event < ApplicationRecord
  belongs_to :team
  belongs_to :tournament
  has_many :innings
  has_many :gamelogics
  has_many :teamlineups
  has_one :scoreboard
  has_one :setup
end
