class Priority < ActiveRecord::Base

  # Associations
  has_many :tickets

  # Scopes
  named_scope :enabled, :order => 'name', :conditions => { :disabled_at => nil }
  named_scope :disabled, :order => 'name', :conditions => ['disabled_at IS NOT NULL']

  # Validations
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  # for css purposes, distinguish between standard or custom priority
  def standard?
    self.name.downcase == "high" || self.name.downcase == "medium" || self.name.downcase == "low"
  end

  def enabled?
    disabled_at.blank?
  end
  
end
