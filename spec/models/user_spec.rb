require 'spec_helper'

describe User do

  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_presence_of :password_confirmation }

  context 'with an existing user' do
    before { Fabricate(:user, email: 'sam.adams@mail.com', username: 'samadams') }
    it do
      should validate_uniqueness_of :username
      should validate_uniqueness_of :email
      should_not allow_value('SamAdams').for(:username)
      should_not allow_value('saMadamS').for(:username)
      should_not allow_value('Sam.Adams@mail.com').for(:email)
      should_not allow_value('saM.adaMs@mail.com').for(:email)
    end
  end

  context 'should not allow invalid email address' do
    it { should_not allow_value('me@mail').for(:email) }
    it { should_not allow_value('@mail.com').for(:email) }
    it { should_not allow_value('mail.com').for(:email) }
  end

  context 'should allow valid email addresses' do
    it { should allow_value('me@mail.com').for(:email) }
    it { should allow_value('ME@mail.COM').for(:email) }
  end

  context '#full_name' do
    it 'returns last_name, first_name' do
      user = Fabricate.build(:user, last_name: 'Beam', first_name: 'Jim')
      user.full_name.should == 'Beam, Jim'
    end

    it 'returns only last_name' do
      user = Fabricate.build(:user, last_name: 'Daniels', first_name: nil)
      user.full_name.should == 'Daniels'
    end
  end

  context '.find_by_user_id' do
    subject { user }
    before { Fabricate(:user, email: 'jack.daniels@example.com', username: 'jack') }

    context 'should find by email address' do
      let(:user) { User.find_by_user_id('jack.daniels@example.com') }
      it { should be }
    end

    context 'should not find by non-existent email address' do
      let(:user) { User.find_by_user_id('sam.adams@example.com') }
      it { should_not be }
    end

    context 'should find by username' do
      let(:user) { User.find_by_user_id('jack') }
      it { should be }
    end

    context 'should not find by non-existent username' do
      let(:user) { User.find_by_user_id('johnny') }
      it { should_not be }
    end
  end

end
