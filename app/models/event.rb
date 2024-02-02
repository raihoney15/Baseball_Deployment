class Event < ApplicationRecord
  belongs_to :user
  belongs_to :tournament
  belongs_to :team, :optional => true
  belongs_to :opponent_team,:optional => true
  # has_many :innings
  # has_many :gamelogics
  # has_many :teamlineups
  # has_one :scoreboard
  # has_one :setup

  before_create :set_user_id
  private

  def set_user_id
    self.user_id = user.id if user
  end

end

