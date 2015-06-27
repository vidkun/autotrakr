require 'rails_helper'

describe "Logging In" do
  it "displays the email address in the event of a failed login" do
    user = create(:user, :valid_password)

    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "not my password"
    click_button "Log In"

    expect(page).to have_content("Please check your email and password")
    expect(page).to have_field("Email", with: user.email)
  end
end