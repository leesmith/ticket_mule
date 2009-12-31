class Comment < ActiveRecord::Base

  # Associations
  belongs_to :ticket, :counter_cache => true, :touch => true
  belongs_to :user

  # Validations
  validates_presence_of :comment

end
