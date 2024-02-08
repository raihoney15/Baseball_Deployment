class Rooster < ApplicationRecord
    belongs_to :user
    belongs_to :team
    has_one :team_line_up
    has_one_attached :image 

    before_create :set_user_id

    private
  
    def set_user_id
      self.user_id = user.id if user
    end


end
