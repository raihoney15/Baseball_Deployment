# class Team < ApplicationRecord
#     belongs_to :user
# end

# app/models/team.rb
class Team < ApplicationRecord
    belongs_to :user
    belongs_to :tournament, optional: true
  
    before_create :set_user_id
  
    private
  
    def set_user_id
      self.user_id = user.id if user
    end
  end
  