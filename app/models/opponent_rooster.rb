class OpponentRooster < ApplicationRecord
  belongs_to :user
  belongs_to :opponent_team
  has_one_attached :image 

  # has_many :opponent_team_line_ups


  private

  def set_user_id
    self.user_id = user.id if user
  end

end
