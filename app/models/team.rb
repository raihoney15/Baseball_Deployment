
class Team < ApplicationRecord
    belongs_to :user
    belongs_to :tournament
    belongs_to :event
    has_many :roosters, dependent: :destroy
  
    before_create :set_user_id

    private
  
    def set_user_id
      self.user_id = user.id if user
    end
end 