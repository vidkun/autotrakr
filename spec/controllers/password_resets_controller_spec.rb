require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  describe "GET new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end    
  end

  describe "POST create" do
    context "with a valid user and email" do
      let(:user) { create(:user, :valid_password) }

      it "finds the user" do
        expect(User).to receive(:find_by).with(email: user.email).and_return(user)
        post :create, email: user.email
      end

      it "generates a new password reset token" do
        expect{
          post :create, email: user.email; user.reload
        }.to change{ user.password_reset_token }
      end

      it "sends a password reset email" do
        expect{
          post :create, email: user.email
        }.to change(ActionMailer::Base.deliveries, :size)
      end

      it "sets the flash message" do
        post :create, email: "notauser@notfound.com"
        expect(flash[:notice]).to match("An email has been sent with further instructions")
      end
    end

    context "with no user found" do
      it "renders the new template" do
        post :create, email: "notauser@notfound.com"
        expect(response).to render_template(:new)
      end

      it "sets the flash message" do
        post :create, email: "notauser@notfound.com"
        expect(flash[:notice]).to match("An email has been sent with further instructions")
      end
    end
  end
end
