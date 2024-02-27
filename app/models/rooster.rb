class Rooster < ApplicationRecord
    belongs_to :user
    belongs_to :team
    has_one :team_line_up,dependent: :destroy
    has_one_attached :image ,dependent: :destroy
    validates :name, :jersey_number, presence: true
    has_many :batting_stats	, dependent: :destroy
    has_many :pitching_stats, dependent: :destroy	

end
