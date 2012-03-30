require 'integration/integration_helper'

describe 'User creates a ticket' do

  before :each do
    @creator = Fabricate(:user, first_name: 'Sam', last_name: 'Adams')
    @owner = Fabricate(:user, first_name: 'Jim', last_name: 'Beam')
    @group = Fabricate(:group)
    @priority = Fabricate(:priority)
    @contact = Fabricate(:contact)
    Fabricate(:status, name: 'Pending')
    sign_in @creator
    visit new_ticket_path
  end

  it 'successfully' do
    fill_in 'Title', with: 'Sky is falling'
    fill_in 'Details', with: 'Some very specific details about this ticket.'
    select "#{@group.name}", from: 'Group'
    select "#{@priority.name}", from: 'Priority'
    select "#{@contact.full_name}", from: 'Contact'
    select "#{@owner.full_name}", from: 'Owner'
    click_button 'Save'
    page.should have_content("Ticket ##{Ticket.last.id} was successfully created.")
    current_path.should == tickets_path
  end

  it 'unsuccessfully' do
    click_button 'Save'
    page.should have_content('Title is required')
  end

end
