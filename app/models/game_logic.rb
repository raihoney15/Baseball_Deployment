class GameLogic < ApplicationRecord
  belongs_to :event
  has_many :moves
end
