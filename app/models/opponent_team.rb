class OpponentTeam < ApplicationRecord
    belongs_to :user
    belongs_to :tournament
    has_many :opponent_roosters, dependent: :destroy
    belongs_to :event
  
    before_create :set_user_id
    private
  
    def set_user_id
      self.user_id = user.id if user
    end
end
