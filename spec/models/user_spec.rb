require 'spec_helper'

describe User do

  %i{email password}.each do |required_field|
    it { should validate_presence_of required_field }
  end

  context 'with an existing user' do
    before { Fabricate(:user, email: 'george.smith@example.com') }
    specify do
      should validate_uniqueness_of :email
      should_not allow_value('george.smith@example.com').for(:email)
      should_not allow_value('GeorGe.SmiTh@example.com').for(:email)
    end
  end

  describe 'valid email address' do
    it { should_not allow_value('me@example').for(:email) }
    it { should_not allow_value('@example.com').for(:email) }
    it { should_not allow_value('example.com').for(:email) }
    it { should allow_value('me@example.com').for(:email) }
    it { should allow_value('ME@example.COM').for(:email) }
  end

  describe 'generates an auth_token on creation' do
    subject { Fabricate(:user) }
    specify { subject.auth_token.should_not be_nil }
  end

end
