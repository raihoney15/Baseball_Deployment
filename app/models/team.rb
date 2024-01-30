
class Team < ApplicationRecord
    belongs_to :user
    belongs_to :tournament
    has_many :roosters
  
    before_create :set_user_id
    # before_create :set_tournament_id

    private
  
    def set_user_id
      self.user_id = user.id if user
    end

    # def set_tournament_id
    #   self.tournament_id = tournament.id if user_signed_in?
    # end
end 