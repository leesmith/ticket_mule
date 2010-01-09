class Attachment < ActiveRecord::Base

  # Paperclip config
  has_attached_file :data,
                    :url => "/attachments/:ticket_id/:id",
                    :path => ":rails_root/attachments/:ticket_id/:id/:basename.:extension"

  # Associations
  belongs_to :ticket, :touch => true
  belongs_to :user

  # Validations
  validates_attachment_presence :data
  validates_attachment_size :data, :less_than => APP_CONFIG['attachment_size_limit'].megabytes, :message => "attachment file size is limited to #{APP_CONFIG['attachment_size_limit']} megabytes."
  validates_presence_of :ticket_id, :user_id

  attr_protected :data_file_name, :data_content_type, :data_file_size

  def url
    data.url
  end

  def name
    data_file_name
  end

  def file_size
    data_file_size
  end

  def nice_file_size
    file_size < 1.kilobyte ? "(#{file_size}B)" : "(#{file_size/1.kilobyte}KB)"
  end

  def content_type
    data_content_type
  end

  def content_type_class
    if self.content_type.index('image') != nil and self.content_type.index('image') >= 0 then
      'image'
    elsif self.content_type.index('video') != nil and self.content_type.index('video') >= 0 then
      'video'
    elsif self.content_type.index('audio') != nil and self.content_type.index('audio') >= 0 then
      'audio'
    elsif self.content_type.index('pdf') != nil and self.content_type.index('pdf') >= 0 then
      'pdf'
    elsif self.content_type.index('text') != nil and self.content_type.index('text') >= 0 then
      'text'
    elsif self.content_type.index('msword') != nil and self.content_type.index('msword') >= 0 then
      'word'
    elsif self.content_type.index('excel') != nil and self.content_type.index('excel') >= 0 then
      'excel'
    elsif self.content_type.index('powerpoint') != nil and self.content_type.index('powerpoint') >= 0 then
      'ppt'
    elsif self.content_type.index('zip') != nil and self.content_type.index('zip') >= 0 then
      'zip'
    else
      'unknown'
    end
  end

end
