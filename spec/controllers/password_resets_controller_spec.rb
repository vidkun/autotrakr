require "rails_helper"

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
        expect(User).to receive(:where).with(email: user.email).and_return(user)
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

  describe "GET edit" do
    context "with a valid password_reset_token" do
      let(:user) { create(:user, :valid_password) }
      before { user.generate_password_reset_token! }

      it "renders the edit template" do
        get :edit, id: user.password_reset_token
        expect(response).to render_template(:edit)
      end

      it "assigns a @user" do
        get :edit, id: user.password_reset_token
        expect(assigns(:user)).to eq(user)
      end
    end

    context "with password_reset_token not found" do
      it "renders the 404 page" do
        get :edit, id: "nope"
        expect(response.status).to eq(404)
        expect(response).to render_template(file: "#{Rails.root}/public/404.html")
      end
    end
  end

  describe "PATCH update" do
    context "with no password_reset_token found" do
      it "renders the edit page" do
        patch :update, id: "nope",
                       user: { password: "newpassword",
                               password_confirmation: "newpassword" }
        expect(response).to render_template(:edit)
      end

      it "sets the flash message" do
        patch :update, id: "nope",
                       user: { password: "newpassword",
                               password_confirmation: "newpassword" }
        expect(flash[:notice]).to match(/not found/)
      end
    end

    context "with a valid token" do
      let(:user) { create(:user, :valid_password) }
      let(:newpassword) { Faker::Internet.password(8, 50) }
      before { user.generate_password_reset_token! }

      it "updates the user's password" do
        expect{
          patch :update, id: user.password_reset_token,
                         user: { password: newpassword,
                                 password_confirmation: newpassword }
          user.reload
        }.to change(user, :password_digest)
      end

      it "clears the user's password_reset_token" do
        patch :update, id: user.password_reset_token,
                       user: { password: newpassword,
                               password_confirmation: newpassword }
        user.reload
        expect(user.password_reset_token).to be_blank
      end

      it "sets the session[:user_id] to the user's id" do
        patch :update, id: user.password_reset_token,
                       user: { password: newpassword,
                               password_confirmation: newpassword }
        expect(session[:user_id]).to eq(user.id)
      end

      it "sets the flash message" do
        patch :update, id: user.password_reset_token,
                       user: { password: newpassword,
                               password_confirmation: newpassword }
        expect(flash[:notice]).to match("Password successfully updated.")
      end

      it "redirects to the user's profile" do
        patch :update, id: user.password_reset_token,
                       user: { password: newpassword,
                               password_confirmation: newpassword }
        expect(response).to redirect_to(user_path(user))
      end
    end
  end
end
