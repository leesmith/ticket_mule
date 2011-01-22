class Ticket < ActiveRecord::Base

  # Associations
  belongs_to :group
  belongs_to :status
  belongs_to :priority
  belongs_to :creator, :class_name => "User", :foreign_key => "created_by"
  belongs_to :owner, :class_name => "User", :foreign_key => "owned_by"
  belongs_to :contact
  has_many :comments, :dependent => :destroy
  has_many :attachments, :dependent => :destroy, :class_name => '::Attachment'
  has_many :alerts, :dependent => :destroy
  has_many :alert_users, :through => :alerts, :class_name => 'User', :source => :user

  # Validations
  validates_presence_of :title, :group_id, :status_id, :priority_id, :contact_id, :created_by

  # Callbacks
  before_update :set_closed_at

  # Scopes
  named_scope :not_closed, :joins => :status, :conditions => ['statuses.name <> ?', 'Closed']
  named_scope :recently_assigned_to, lambda { | user_id | { :limit => 5, :conditions => { :owned_by => user_id }, :include => [:creator, :owner, :group, :status, :priority, :contact], :order => 'updated_at DESC' } }
  named_scope :active_tickets, :limit => 5, :include => [:creator, :owner, :group, :status, :priority], :order => 'updated_at DESC'
  named_scope :closed_tickets, :limit => 5, :joins => :status, :include => [:creator, :owner, :group, :status, :priority], :conditions => ['statuses.name = ?', 'Closed'], :order => 'closed_at DESC'

  def self.timeline_opened_tickets
    self.count(:group => 'date(created_at)', :having => ['date(created_at) >= ? and date(created_at) <= ?', (Time.zone.now.beginning_of_day - 30.days).to_date.to_s, (Time.zone.now.end_of_day - 1.day).to_date.to_s])
  end

  def self.timeline_closed_tickets
    self.count(:group => 'date(closed_at)', :having => ['date(closed_at) >= ? and date(closed_at) <= ?', (Time.zone.now.beginning_of_day - 30.days).to_date.to_s, (Time.zone.now.end_of_day - 1.day).to_date.to_s])
  end

  def closed?
    status.name == 'Closed'
  end

  def only_touched?
    self.changed.size == 1 and self.changed[0] == "updated_at"
  end

  protected

  def set_closed_at
    # update the closed_at timestamp if the ticket is being closed
    if closed?
      self.closed_at = DateTime.now if self.closed_at.nil?
    else
      self.closed_at = nil unless self.closed_at.nil?
    end
  end

end
