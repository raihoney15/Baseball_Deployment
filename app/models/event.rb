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

  # validates :game_type, :home_team,:away_team,:start_date,:location, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "game_type"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["image_attachment", "image_blob", "opponent_team", "opponent_team_line_ups", "team", "team_line_ups", "tournament", "user"]
  end



end

