require "rails_helper"

describe "Forgotten password" do
  let!(:user) { create(:user, :valid_password) }

  it "sends the user an email" do
    visit login_path
    click_link "Forgot Password"
    fill_in "Email", with: user.email
    expect {
      click_button "Reset Password"
    }.to change{ ActionMailer::Base.deliveries.size }.by(1)
  end

  it "resets a password when following the email link" do
    visit login_path
    click_link "Forgot Password"
    fill_in "Email", with: user.email
    click_button "Reset Password"
    open_email(user.email)
    current_email.click_link "http://"
    expect(page).to have_content("Change Your Password")

    newpassword = Faker::Internet.password(8, 50)
    fill_in "Password", with: newpassword
    fill_in "Confirm Password", with: newpassword
    click_button "Change Password"
    expect(page).to have_content("Password successfully updated.")
    expect(page.current_path).to eq(user_path(user))

    click_link "Logout"
    expect(page).to have_content("You have been logged out.")
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: newpassword
    click_button "Log In"
    expect(page).to have_content("Login Successful")
  end
end
