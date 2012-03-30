class Contact < ActiveRecord::Base

  # Associations
  has_many :tickets

  # Validations
  validates :last_name, :email, presence: true

  def full_name
    [last_name, first_name].compact.join(', ')
  end

end
