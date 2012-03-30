require 'ffaker'
require 'populator'

desc 'Load fake data for development/testing.'
task :faker => ['db:setup', 'fake:users', 'fake:contacts', 'fake:groups', 'fake:tickets']

NUM_CONTACTS = 150
NUM_TICKETS = 500
START_DATE = DateTime.now - 6.months
END_DATE = DateTime.now
CREATION_PERIOD = [*START_DATE..END_DATE]

namespace :fake do
  desc 'Create some fake users'
  task :users => :environment do
    Fabricate(:user, username: 'sadams', first_name: 'Sam', last_name: 'Adams', email: 'sam.adams@mail.com')
    Fabricate(:user, username: 'jdaniels', first_name: 'Jack', last_name: 'Daniels', email: 'jack.daniels@mail.com')
    Fabricate(:user, username: 'jbeam', first_name: 'Jim', last_name: 'Beam', email: 'jim.beam@mail.com')
    Fabricate(:user, username: 'jcuervo', first_name: 'Jose', last_name: 'Cuervo', email: 'jose.cuervo@mail.com')
    Fabricate(:user, username: 'jwalker', first_name: 'Johnnie', last_name: 'Walker', email: 'johnnie.walker@mail.com')
    Fabricate(:user, username: 'ewilliams', first_name: 'Evan', last_name: 'Williams', email: 'evan.williams@mail.com')
  end

  desc 'Create some fake contacts'
  task :contacts => :environment do
    Contact.populate NUM_CONTACTS do |c|
      c.first_name = Faker::Name.first_name
      c.last_name = Faker::Name.last_name
      c.email = Faker::Internet.email
      c.mobile_phone = Faker::PhoneNumber.short_phone_number
      c.work_phone = Faker::PhoneNumber.short_phone_number
      c.affiliation = Faker::Company.name
      c.notes = Faker::HipsterIpsum.paragraph(sentence_count=5)
    end
  end

  desc 'Create some fake groups'
  task :groups => :environment do
    Group.create(name: 'Sales')
    Group.create(name: 'Marketing')
    Group.create(name: 'Executive')
    Group.create(name: 'Operations')
    Group.create(name: 'Information Technology')
    Group.create(name: 'Engineering')
  end

  desc 'Create some fake tickets'
  task :tickets => :environment do
    Ticket.populate NUM_TICKETS do |t|
      t.title = Faker::Lorem.sentence(word_count=15)
      t.details = Faker::HipsterIpsum.paragraphs(sentence_count=3)
      t.group_id = rand(6)+1 # random group_id [1..6]
      t.status_id = 1
      t.priority_id = rand(3)+1 # random priority_id [1..3]
      t.contact_id = rand(NUM_CONTACTS)+1 # random contact_id [1..NUM_CONTACTS]
      t.creator_id = rand(6)+2 # random created_by [2..7]
      t.created_at = CREATION_PERIOD.sample
    end
  end

end
