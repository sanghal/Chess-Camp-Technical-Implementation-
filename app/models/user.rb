class User < ActiveRecord::Base
  include ChessCampHelpers

  # Use built-in rails support for password protection
  has_secure_password

  # relationships
  belongs_to :instructor

  
  before_create { generate_token(:auth_token) }


  # validations
  validates :username, presence: true, uniqueness: { case_sensitive: false}
  validates :role, inclusion: { in: %w[admin instructor], message: "is not a recognized role in system" }
  validates_presence_of :password, on: :create 
  validates_presence_of :password_confirmation, on: :create 
  validates_confirmation_of :password, message: "does not match"
  validates_length_of :password, minimum: 4, message: "must be at least 4 characters long", allow_blank: true

  ROLES = [['Administrator', :admin],['Instructor', :instructor]]

  def role?(authorized_role)
    return false if role.nil?
    role.downcase.to_sym == authorized_role
  end

  def self.authenticate(username,password)
    find_by_username(username).try(:authenticate, password)
  end


  def send_password_reset
  generate_token(:password_reset_token)
  self.password_reset_sent_at = Time.zone.now
  save!
  UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
  begin
    self[column] = SecureRandom.urlsafe_base64
  end while User.exists?(column => self[column])
  end
end
