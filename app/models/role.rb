class Role < ApplicationRecord
    has_many :assignments,dependent: :destroy
    has_many :users, through: :assignments,dependent: :destroy
  
    # validates :role_name, presence: true, uniqueness: true
end
