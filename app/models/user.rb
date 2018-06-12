class User < ApplicationRecord
  attr_accessor :first_name, :last_name, :email, :password, :did

  # Validation
  validates :email, :presence => true, :uniqueness => true
  validates :password, :presence => true
  validates_length_of :password, :in => 6..20, :on => :create
  # validates :did, :presence => true, :uniqueness => true

  # Encrypt Password
  before_save :encrypt_password, :generate_did
  after_save :clear_password

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    return user if user && user.validate_password(password, user.salt)
    return false
  end

  private
    def encrypt_password
      if password.present?
        self.salt = BCrypt::Engine.generate_salt
        self.encrypted_password = BCrypt::Engine.hash_secret(self.password, self.salt)
      end
    end
    def clear_password
      self.password = nil
    end
    def validate_password(password, salt)
      encrypted_password == BCrypt::Engine.hash_secret(password, salt)
    end
    def generate_did
      self.did = SecureRandom.uuid
    end
end
