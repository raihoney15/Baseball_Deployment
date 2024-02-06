class User < ApplicationRecord
  attr_accessor :pin_0, :pin_1, :pin_2, :pin_3
  has_many :assignments,dependent: :destroy
  has_many :teams
  has_many :opponent_teams
  has_many :events
  has_many :tournaments ,dependent: :destroy
  has_many :roles, through: :assignments,dependent: :destroy
  has_one_attached :image
  has_many :roosters
  has_many :opponent_roosters
  has_many :teamlineups
  has_many :staff_invites
  has_many :rooster_positions

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable ,authentication_keys: [:login]

  after_create :update_user_verified_column_to_true
  after_create :send_pin!

  def assign_default_roles
    self.roles << Role.find_by(role_name: 'tournament_owner') if self.roles.empty?
    self.roles << Role.find_by(role_name: 'team_owner') if self.roles.empty?
  end

   attr_writer :login
   validate :validate_username

   def login
     @login || self.username || self.email
   end

   def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

   def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def update_user_verified_column_to_true
    UpdateUserJob.perform_now(self)
  end
  
  def reset_pin!
    update_column(:pin, rand(1000..9999))
  end
  
  def unverify!
    update_column(:verified, false)
  end
  
  def send_pin!
    reset_pin!
    unverify!
    SendPinJob.perform_now(self)
  end

end
