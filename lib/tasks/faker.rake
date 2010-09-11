desc "Load fake data for development/testing."
task :faker => ['db:setup', 'fake:users', 'fake:contacts', 'fake:tickets']

NUM_CONTACTS = 150
NUM_TICKETS = 500

namespace :fake do
  desc "Create some fake users"
  task :users => :environment do
    attrs = { :username => 'sadams',
              :password => 'welcome',
              :password_confirmation => 'welcome',
              :email => 'sadams@mycompany.com',
              :email_confirmation => 'sadams@mycompany.com',
              :first_name => 'Sam',
              :last_name => 'Adams',
              :time_zone => 'Central Time (US & Canada)',
              :admin => false }
    User.create(attrs)
    attrs = { :username => 'jdaniels',
              :password => 'welcome',
              :password_confirmation => 'welcome',
              :email => 'jdaniels@mycompany.com',
              :email_confirmation => 'jdaniels@mycompany.com',
              :first_name => 'Jack',
              :last_name => 'Daniels',
              :time_zone => 'Eastern Time (US & Canada)',
              :admin => false }
    User.create(attrs)
    attrs = { :username => 'jbeam',
              :password => 'welcome',
              :password_confirmation => 'welcome',
              :email => 'jbeam@mycompany.com',
              :email_confirmation => 'jbeam@mycompany.com',
              :first_name => 'Jim',
              :last_name => 'Beam',
              :time_zone => 'Pacific Time (US & Canada)',
              :admin => false }
    User.create(attrs)
    attrs = { :username => 'jcuervo',
              :password => 'welcome',
              :password_confirmation => 'welcome',
              :email => 'jcuervo@mycompany.com',
              :email_confirmation => 'jcuervo@mycompany.com',
              :first_name => 'Jose',
              :last_name => 'Cuervo',
              :time_zone => 'Mountain Time (US & Canada)',
              :admin => false }
    User.create(attrs)
    attrs = { :username => 'jwalker',
              :password => 'welcome',
              :password_confirmation => 'welcome',
              :email => 'jwalker@mycompany.com',
              :email_confirmation => 'jwalker@mycompany.com',
              :first_name => 'Johnnie',
              :last_name => 'Walker',
              :time_zone => 'Central Time (US & Canada)',
              :admin => false }
    User.create(attrs)
    attrs = { :username => 'ewilliams',
              :password => 'welcome',
              :password_confirmation => 'welcome',
              :email => 'ewilliams@mycompany.com',
              :email_confirmation => 'ewilliams@mycompany.com',
              :first_name => 'Evan',
              :last_name => 'Williams',
              :time_zone => 'Pacific Time (US & Canada)',
              :admin => false }
    User.create(attrs)
  end

  desc "Create some fake contacts"
  task :contacts => :environment do
    require 'faker'
    require 'populator'
    Contact.populate NUM_CONTACTS do |c|
      c.first_name = Faker::Name.first_name
      c.last_name = Faker::Name.last_name
      c.email = Faker::Internet.email
      c.mobile_phone = Faker::PhoneNumber.phone_number
      c.office_phone = Faker::PhoneNumber.phone_number
      c.affiliation = Faker::Company.name
      c.notes = Faker::Lorem.paragraph(sentence_count=5)
      c.created_at = Time.now
    end
  end

  desc "Create some fake tickets"
  task :tickets => :environment do
    require 'faker'
    require 'populator'
    Ticket.populate NUM_TICKETS do |t|
      t.title = Faker::Lorem.sentence(word_count=15)
      t.details = Faker::Lorem.paragraphs(paragraph_count=3)
      t.group_id = rand(7)+1 # random group_id [1..7]
      t.status_id = 1
      t.priority_id = rand(3)+1 # random priority_id [1..3]
      t.contact_id = rand(NUM_CONTACTS)+1 # random contact_id [1..NUM_CONTACTS]
      t.created_by = rand(6)+2 # random created_by [2..7]
    end
  end

end
