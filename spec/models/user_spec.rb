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
 
end
