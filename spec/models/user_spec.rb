require 'rails_helper'
 
describe User do
 
  it { is_expected.to have_fields(:username,
                                  :email,
                                  :first_name,
                                  :last_name,
                                  :password_digest) }
  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive
                                                    .with_message('is already taken') }
  it { is_expected.to validate_uniqueness_of(:username).case_insensitive
                                                       .with_message('is already taken') }

  it 'fails because no passwrod' do
    expect( User.new( { username: 'bill' } ).save ).to be false
  end
 
  #it { is_expected.to validate_length_of(:password).with_minimum(8) }
  it 'fails because passwrod to short' do
    expect( User.new( { username: 'bill',
                        email: 'bill@wyldstallyns.com',
                        password: 'ted',
                        password_confirmation: 'ted' } ).save ).to be false
  end
 
  it 'succeeds because password is long enough' do
    expect( User.new( { username: 'bill',
                        email: 'bill@wyldstallyns.com',
                        password: 'wyldstallyns',
                        password_confirmation: 'wyldstallyns' } ).save ).to be true
  end
 
  it 'fails because password confirmation does not match' do
    expect( User.new( { username: 'bill',
                        email: 'bill@wyldstallyns.com',
                        password: 'wyldstallyns',
                        password_confirmation: 'abc123' } ).save ).to be false
  end
 
  it 'succeeds because password & confirmation match' do
    expect( User.new( { username: 'bill',
                        email: 'bill@wyldstallyns.com',
                        password: 'wyldstallyns',
                        password_confirmation: 'wyldstallyns' } ).save ).to be true
  end

end
