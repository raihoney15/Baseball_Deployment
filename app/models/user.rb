class User < ApplicationRecord
  # has_many :assignments
  # has_many :roles, through: :assignments
  has_many :roles
  has_one_attached :image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable ,authentication_keys: [:login]

  # enum role: [:user, :admin, :tournament_owner, :team_owner]
  after_initialize :set_default_role, :if => :new_record?
  def set_default_role
     self.role ||= :user
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


end
