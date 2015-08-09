require "rails_helper"

describe User do
  let!(:user) { create(:user, :valid_password) }

  it "should have an email field" do
    expect(user.attributes).to include(:email)
  end

  it "should have a password_digest field" do
    expect(user.attributes).to include(:password_digest)
  end

  it "fails because email is not unique" do
    new_user = build(:user, email: user.email)
    expect(new_user).to_not be_valid
    expect(new_user.save).to be false
    # there has to be a better way to check this error message
    expect(new_user.errors[:email].first).to eq("is already taken")
  end

  it "fails because no email" do
    expect(build(:user, email: "")).to_not be_valid
    expect(build(:user, email: "").save).to be false
  end

  it "fails because no password" do
    expect(build(:user, password: nil)).to_not be_valid
    expect(build(:user, password: nil).save).to be false
  end

  it "fails because passwrod to short" do
    expect(build(:user, :short_password)).to_not be_valid
    expect(build(:user, :short_password).save).to be false
  end

  it "succeeds because password is long enough" do
    expect(build(:user, :valid_password)).to be_valid
    expect(build(:user, :valid_password).save).to be true
  end

  it "fails because password confirmation does not match" do
    expect(build(:user, :mismatch_password)).to_not be_valid
    expect(build(:user, :mismatch_password).save).to be false
  end

  it "downcases an email before saving" do
    user = build(:user, :valid_password)
    user.email.upcase!
    expect(user.save).to be true
    expect(user.email).to eq(user.email.downcase)
  end

  describe "#generate_password_reset_token!" do
    let(:user) { create :user, :valid_password }
    it "changes the password_reset_token attribute" do
      expect{ user.generate_password_reset_token! }.to change{
                                                      user.password_reset_token
                                                      }
    end

    it "calls SecureRandom.urlsafe_base64 to generate password_reset_token" do
      expect(SecureRandom).to receive(:urlsafe_base64)
      user.generate_password_reset_token!
    end
  end
end
