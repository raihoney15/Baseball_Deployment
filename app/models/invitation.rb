class Invitation < ApplicationRecord
  belongs_to :tournament
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
