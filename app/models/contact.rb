class Contact < ActiveRecord::Base

  # Associations
  has_many :tickets

  # Scopes
  named_scope :enabled, :order => 'last_name, first_name', :conditions => { :disabled_at => nil }

  # Validations
  validates_presence_of :last_name, :email

  def full_name
    if first_name.blank?
      last_name
    else
      [last_name, first_name].compact.join(', ')
    end
  end

  def enabled?
    disabled_at.blank?
  end

end
