require 'spec_helper'

describe Contact do

  describe 'creation' do
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :email }
    it { should have_many :tickets }
  end

  context '#full_name' do
    it 'returns last_name, first_name' do
      contact = Fabricate.build(:contact, last_name: 'Beam', first_name: 'Jim')
      contact.full_name.should == 'Beam, Jim'
    end

    it 'returns only last_name' do
      contact = Fabricate.build(:contact, last_name: 'Daniels', first_name: nil)
      contact.full_name.should == 'Daniels'
    end
  end

end
