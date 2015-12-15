class User < ActiveRecord::Base

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  attr_accessor :password

  has_many :shorturls

  validates_confirmation_of :password
  validates_length_of :password, :in => 4..15, allow_blank: false, :on => :create

  validates :email, presence: true, allow_blank: false, format: { with: EMAIL_REGEX }
  validates_length_of :name, in: 4..15, allow_blank: false

  before_save :encrypt_password

  def self.authenticate(name, password)
    user = User.find_by_name(name)
    if user && user.encrypted_password == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.encrypted_password = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def generate_api_key
    self.update_column(:api_key, SecureRandom.hex(16))
  end

end
