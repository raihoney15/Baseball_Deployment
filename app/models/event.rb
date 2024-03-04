class Event < ApplicationRecord
  belongs_to :user
  belongs_to :tournament
  belongs_to :team, :optional => true
  has_one_attached :image 
  belongs_to :opponent_team, :optional => true
  has_many :team_line_ups, dependent: :destroy
  has_many :moves
  has_many :opponent_team_line_ups
  has_many :scoreboards, dependent: :destroy
  has_many :event_setup, dependent: :destroy
  has_many :event_innings, dependent: :destroy
  belongs_to :rooster_position,:optional => true
  has_many :batting_stats	, dependent: :destroy
  has_many :pitching_stats, dependent: :destroy	

  validates :game_type, :start_date,:location, presence: true
  validate :start_date_cannot_be_in_the_past

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date.past?
      errors.add(:start_date, " can't be in the past")
    end
  end  

  def self.ransackable_attributes(auth_object = nil)
    [ "game_type"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["image_attachment", "image_blob", "opponent_team", "opponent_team_line_ups", "team", "team_line_ups", "tournament", "user"]
  end



end

