require "rails_helper"

describe "Signing up" do
  it "allows a user to sign up for the site and creates a user in database" do
    expect(User.count).to eq(0)

    user = build(:user, :valid_password)

    visit "/"
    expect(page).to have_content("Sign Up")
    click_link "Sign Up"

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Confirm Password", with: user.password_confirmation
    click_button "Register"

    expect(User.count).to eq(1)
  end
end
