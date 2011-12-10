class User < ActiveRecord::Base
  attr_accessible :email, :username, :password, :password_confirmation
  has_secure_password

  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates :username, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i }, allow_blank: true

  def self.find_by_user_id(userid)
    return self.find_by_email(userid) if self.exists?(email: userid)
    self.find_by_username(userid)
  end

end
