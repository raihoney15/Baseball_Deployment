class Tournament < ApplicationRecord
  paginates_per 5

  belongs_to :user, :optional => true
  has_one_attached :image ,dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :opponent_teams, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :team_line_ups, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_many :opponent_team_line_ups, dependent: :destroy
  validates :name, :start_date, :end_date, :location, presence: true
  validates_presence_of :start_date, :end_date

  validate :end_date_is_after_start_date
  validate :start_date_cannot_be_in_the_past
  validate :name_and_location_cannot_start_with_numbers

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date.past?
      errors.add(:start_date, " can't be in the past")
    end
  end

  private

  def end_date_is_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, " cannot be before the start date")
    end
  end

  def name_and_location_cannot_start_with_numbers
    if name.present? && name.match?(/\A\d/)
      
      errors.add(:name, " cannot start with a number")
    end

    if location.present? && location.match?(/\A\d/)
      errors.add(:location, " cannot start with a number")
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
end
