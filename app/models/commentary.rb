class Commentary < ApplicationRecord
  belongs_to :opponent_rooster
  belongs_to :rooster
  belongs_to :event
end
