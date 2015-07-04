require 'rails_helper'
 
describe User do
 
  it { is_expected.to have_fields(:username,
                                  :email,
                                  :first_name,
                                  :last_name,
                                  :password_digest) }
  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password).on(:create) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive
                                                    .with_message('is already taken') }
  it { is_expected.to validate_uniqueness_of(:username).case_insensitive
                                                       .with_message('is already taken') }

  it 'fails because no password' do
    expect(build(:user, password: nil)).to_not be_valid
    expect(build(:user, password: nil).save ).to be false
  end
 
  #it { is_expected.to validate_length_of(:password).with_minimum(8) }
  it 'fails because passwrod to short' do
    expect(build(:user, :short_password)).to_not be_valid
    expect(build(:user, :short_password).save).to be false
  end
 
  it 'succeeds because password is long enough' do
    expect(build(:user, :valid_password)).to be_valid
    expect(build(:user, :valid_password).save).to be true
  end
 
  it 'fails because password confirmation does not match' do
    expect( build(:user, :mismatch_password)).to_not be_valid
    expect( build(:user, :mismatch_password).save ).to be false
  end

  it 'downcases an email before saving' do
    user = build(:user, :valid_password)
    user.email.upcase!
    expect( user.save ).to be true
    expect(user.email ).to eq( user.email.downcase )
  end

  describe "#generate_password_reset_token!" do
    let(:user) { create :user, :valid_password }
    it "changes the password_reset_token attribute" do
      expect{ user.generate_password_reset_token! }.to change{user.password_reset_token}
    end

    it "calls SecureRandom.urlsafe_base64 to generate the password_reset_token" do
      expect(SecureRandom).to receive(:urlsafe_base64)
      user.generate_password_reset_token!
    end
  end

end
