class Inning < ApplicationRecord
  belongs_to :event
  belongs_to :scoreboard
end
