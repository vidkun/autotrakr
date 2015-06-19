require 'rails_helper'

describe 'Signing up' do
  it 'allows a user to sign up for the site and creates the object in the database' do
    expect(User.count).to eq(0)

    visit '/'
    expect(page).to have_content('Sign Up')
    click_link 'Sign Up'

    fill_in 'First Name', with: 'Bill'
    fill_in 'Last Name', with: 'Preston'
    fill_in 'Email', with: 'bpreston@wyldstallyns.com'
    fill_in 'Password', with: 'Excellent!'
    fill_in 'Confirm Password', with: 'Excellent!'
    click_button 'Sign Up'

    expect(User.count).to eq(1)
  end
  
end