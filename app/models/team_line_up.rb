class TeamLineUp < ApplicationRecord
  belongs_to :event
  belongs_to :user
  belongs_to :rooster
end
