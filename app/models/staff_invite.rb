class StaffInvite < ApplicationRecord
  belongs_to :team
  belongs_to :tournament
  belongs_to :user
end







