require 'spec_helper'

describe Status do

  describe 'creation' do
    it { should validate_presence_of :name }
    it { should have_many :tickets }

    context 'with an existing status' do
      before { Fabricate(:status, name: 'Open') }
      it do
        should validate_uniqueness_of :name
        should_not allow_value('open').for(:name)
      end
    end
  end

end
