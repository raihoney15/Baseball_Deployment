
class Tournament < ApplicationRecord
  paginates_per 3
    belongs_to :user, :optional => true
    has_many :teams, dependent: :destroy
    has_many :opponent_teams, dependent: :destroy
    has_many :events, dependent: :destroy
  end
  