class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true, email: true
  has_secure_password
  before_create :generate_access_token
  has_many :zones

  def generate_access_token
    self.access_token = SecureRandom.hex
  end

  def authentication_token
    "#{self.id}:#{self.access_token}"
  end

end
