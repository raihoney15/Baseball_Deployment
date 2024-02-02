class Rooster < ApplicationRecord
    belongs_to :user
    belongs_to :team

    before_create :set_user_id

    private
  
    def set_user_id
      self.user_id = user.id if user
    end


end
