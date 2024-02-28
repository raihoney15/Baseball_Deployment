class User < ApplicationRecord
  attr_accessor :pin_0, :pin_1, :pin_2, :pin_3
  has_many :assignments,dependent: :destroy
  has_many :teams,dependent: :destroy
  has_many :opponent_teams,dependent: :destroy
  has_many :events,dependent: :destroy
  has_many :tournaments ,dependent: :destroy
  has_many :roles, through: :assignments,dependent: :destroy
  has_one_attached :image,dependent: :destroy
  has_many :roosters,dependent: :destroy
  has_many :opponent_roosters,dependent: :destroy
  has_many :team_line_ups,dependent: :destroy
  has_many :opponent_team_line_ups,dependent: :destroy
  # has_many :staff_invites,dependent: :destroy
  has_many :rooster_positions,dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable ,authentication_keys: [:login]

  after_create :update_user_verified_column_to_true
  after_create :send_pin!

  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/, message: "Invalid email format" }
  validates :username, uniqueness: true

 
  validate :blank_space
 


  
    # def generate_invitation_token
    #   self.invitation_token = SecureRandom.urlsafe_base64
    #   save
    # end
  
  
   def blank_space
    if password&.include?(' ')
    errors.add(:password, "can't contain spaces")
    end
  end

  def assign_tournament_admin_role(email)
    binding.pry
    user = User.find_by(email: email)
    return unless user
    self.roles << Role.find_by(role_name: 'tournament_admin')
  end
  
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



