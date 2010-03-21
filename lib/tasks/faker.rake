desc "Load fake data for development/testing."
task :faker => ['db:setup', 'fake:users', 'fake:contacts', 'fake:tickets']

namespace :fake do
  desc "Create some fake users"
  task :users => :environment do
    attrs = { :username => 'sadams',
              :password => 'welcome',
              :password_confirmation => 'welcome',
              :email => 'sadams@mail.com',
              :email_confirmation => 'sadams@mail.com',
              :first_name => 'Sam',
              :last_name => 'Adams',
              :time_zone => 'Central Time (US & Canada)',
              :admin => false }
    User.create(attrs)
    attrs = { :username => 'jdaniels',
              :password => 'welcome',
              :password_confirmation => 'welcome',
              :email => 'jdaniels@mail.com',
              :email_confirmation => 'jdaniels@mail.com',
              :first_name => 'Jack',
              :last_name => 'Daniels',
              :time_zone => 'Eastern Time (US & Canada)',
              :admin => false }
    User.create(attrs)
    attrs = { :username => 'jbeam',
              :password => 'welcome',
              :password_confirmation => 'welcome',
              :email => 'jbeam@mail.com',
              :email_confirmation => 'jbeam@mail.com',
              :first_name => 'Jim',
              :last_name => 'Beam',
              :time_zone => 'Pacific Time (US & Canada)',
              :admin => false }
    User.create(attrs)
    attrs = { :username => 'jcuervo',
              :password => 'welcome',
              :password_confirmation => 'welcome',
              :email => 'jcuervo@mail.com',
              :email_confirmation => 'jcuervo@mail.com',
              :first_name => 'Jose',
              :last_name => 'Cuervo',
              :time_zone => 'Mountain Time (US & Canada)',
              :admin => false }
    User.create(attrs)
  end

  desc "Create some fake contacts"
  task :contacts => :environment do
    require 'faker'
    require 'populator'
    Contact.populate 150 do |c|
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
    Ticket.populate 500 do |t|
      t.title = Faker::Lorem.sentence(word_count=15)
      t.details = Faker::Lorem.paragraphs(paragraph_count=3)
      t.group_id = rand(5)+1
      t.status_id = 1
      t.priority_id = rand(3)+1
      t.contact_id = rand(150)+1
      t.created_by = rand(5)+1
    end
  end

end
