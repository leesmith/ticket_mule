class User < ActiveRecord::Base
  has_secure_password

  before_create { generate_token(:auth_token) }
  before_save { |user| user.email.downcase! }

  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false
  validates_format_of :email, with: /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i, allow_blank: true

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

end
