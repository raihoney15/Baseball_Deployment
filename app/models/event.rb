class Event < ApplicationRecord
  belongs_to :user
  belongs_to :tournament
  belongs_to :team, :optional => true
  has_one_attached :image 
  belongs_to :opponent_team, :optional => true
  has_many :team_line_ups
  has_many :opponent_team_line_ups
  has_one :scoreboard
  has_one :event_setup
  has_many :event_innings
  belongs_to :rooster_position

  # has_many :rooster_positions


  # validates :game_type, :home_team,:away_team,:start_date,:location, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "game_type"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["image_attachment", "image_blob", "opponent_team", "opponent_team_line_ups", "team", "team_line_ups", "tournament", "user"]
  end



end

