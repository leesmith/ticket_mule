class Ticket < ActiveRecord::Base

  # Associations
  belongs_to :group
  belongs_to :status
  belongs_to :priority
  belongs_to :contact
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'

  # Validations
  validates_presence_of :title, :status, :group, :priority, :creator, message: 'is required'

end
