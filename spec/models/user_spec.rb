require 'rails_helper'
 
describe User do
 
  it 'fails because no passwrod' do
    expect( User.new( { username: 'bill' } ).save ).to be false
  end
 
  it 'fails because passwrod to short' do
    expect( User.new( { username: 'bill', password: 'ted' } ).save ).to be false
  end
 
  it 'succeeds because password is long enough' do
    expect( User.new( { username: 'bill', password: 'wyldstallyns' } ).save ).to be true
  end
 
  it 'fails because password confirmation does not match' do
    expect( User.new( { username: 'bill', password: 'wyldstallyns', password_confirmation: 'abc123' } ).save ).to be false
  end
 
  it 'succeeds because password & confirmation match' do
    expect( User.new( { username: 'bill', password: 'wyldstallyns', password_confirmation: 'wyldstallyns' } ).save ).to be true
  end

end
