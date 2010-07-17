class User < ActiveRecord::Base

  include Gravatarable

  # Authlogic config
  acts_as_authentic do |c|
    c.logged_in_timeout = APP_CONFIG['session_timeout'].minutes
    c.validates_length_of_login_field_options :in => 4..35
    c.validates_format_of_login_field_options :with => /^[A-Z0-9_]*$/i, :message => "must contain only letters, numbers, and underscores"
  end

  # Associations
  has_many :created_tickets, :class_name => "Ticket", :foreign_key => "created_by"
  has_many :opened_tickets, :class_name => "Ticket", :foreign_key => "opened_by"
  has_many :comments
  has_many :attachments
  has_many :alerts, :dependent => :destroy
  has_many :alert_tickets, :through => :alerts, :class_name => 'Ticket', :source => :ticket

  # Validations
  validates_presence_of     :first_name, :last_name
  validates_confirmation_of :email

  # Scopes
  named_scope :enabled, :order => 'username', :conditions => { :disabled_at => nil }

  attr_protected :admin

  def self.find_by_enabled_user(login)
    find_by_username(login, :conditions => { :disabled_at => nil })
  end

  def full_name
    if first_name.blank?
      last_name
    else
      [last_name, first_name].compact.join(', ')
    end
  end

  def has_ticket_alert?(ticket_id)
    self.alert_tickets.each do |ticket|
      if ticket_id == ticket.id
        return true
      end
    end
    return false
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end

  def enabled?
    disabled_at.blank?
  end

  def locked?
    if failed_login_count.blank?
      false
    else
      failed_login_count >= APP_CONFIG['failed_logins_limit']
    end
  end

end
