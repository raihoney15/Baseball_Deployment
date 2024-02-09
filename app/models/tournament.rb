
class Tournament < ApplicationRecord
  paginates_per 5
    belongs_to :user, :optional => true
    has_one_attached :image ,dependent: :destroy
    has_many :teams, dependent: :destroy
    has_many :opponent_teams, dependent: :destroy
    has_many :events, dependent: :destroy
    has_many :team_line_ups,dependent: :destroy
    has_many :opponent_team_line_ups,dependent: :destroy
    validates :name, :start_date, :end_date, :location, presence: true
  end
  