class Alert < ActiveRecord::Base

  # Default Order
  default_scope :order => 'created_at DESC'

  # Associations
  belongs_to :ticket
  belongs_to :user

end
