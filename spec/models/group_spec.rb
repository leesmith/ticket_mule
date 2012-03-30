require 'spec_helper'

describe Group do

  describe 'creation' do
    it { should validate_presence_of :name }
    it { should have_many :tickets }

    context 'with an existing group' do
      before { Fabricate(:group, name: 'Operations') }
      it do
        should validate_uniqueness_of :name
        should_not allow_value('operations').for(:name)
      end
    end
  end

end
