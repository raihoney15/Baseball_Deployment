
class Team < ApplicationRecord
  paginates_per 3
    belongs_to :user
    belongs_to :tournament
    has_many :event
    has_many :team_line_up
    has_many :roosters, dependent: :destroy
    has_one_attached :image 
    validates :name, :short_name, presence: true

end 