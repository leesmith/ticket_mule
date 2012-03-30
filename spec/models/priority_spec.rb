require 'spec_helper'

describe Priority do

  describe 'creation' do
    it { should validate_presence_of :name }
    it { should have_many :tickets }

    context 'with an existing priority' do
      before { Fabricate(:priority, name: 'High') }
      it do
        should validate_uniqueness_of :name
        should_not allow_value('high').for(:name)
      end
    end
  end

end
