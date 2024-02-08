
class Team < ApplicationRecord
  paginates_per 3
    belongs_to :user
    belongs_to :tournament
    has_many :event
    has_many :team_line_up
    has_many :roosters, dependent: :destroy
    has_one_attached :image 

    before_create :set_user_id

    private
  
    def set_user_id
      self.user_id = user.id if user
    end
end 