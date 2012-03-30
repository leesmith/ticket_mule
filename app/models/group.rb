class Group < ActiveRecord::Base

  # Associations
  has_many :tickets

  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }

end
