class User < ActiveRecord::Base
  has_secure_password
  validates :password, length: { minimum: 6 }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { without: /\s/ }

  
  def self.authenticate_with_credentials email, password
    user = User.find_by_email(email.strip.downcase)
    user && user.authenticate(password)
  end

end
