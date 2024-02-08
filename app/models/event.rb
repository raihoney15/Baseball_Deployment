class Event < ApplicationRecord
  belongs_to :user
  belongs_to :tournament
  belongs_to :team, :optional => true
  has_one_attached :image 
  belongs_to :opponent_team, :optional => true
  has_many :team_line_ups
  has_many :opponent_team_line_ups
  # has_one :scoreboard
  # has_one :setup
  # has_many :innings
  # has_many :gamelogics

  before_create :set_user_id
  private

  def set_user_id
    self.user_id = user.id if user
  end

end

