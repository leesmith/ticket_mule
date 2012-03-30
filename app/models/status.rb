class Status < ActiveRecord::Base

  # Associations
  has_many :tickets

  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # Scopes
  scope :pending, where(name: 'Pending')
  scope :open, where(name: 'Open')
  scope :closed, where(name: 'Closed')

end
