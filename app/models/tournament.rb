# class Tournament < ApplicationRecord
#     belongs_to :user
# end

# app/models/tournament.rb
class Tournament < ApplicationRecord
    belongs_to :user
    has_many :teams, dependent: :destroy
  
    before_create :set_user_id
  
    private
  
    def set_user_id
      self.user_id = user.id if user
    end
  end
  