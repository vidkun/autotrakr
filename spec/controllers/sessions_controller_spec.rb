require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with correct credentials" do
      
      let!(:user) { create(:user, :valid_password) }

      it "redirects to the user path" do
        post :create, email: user.email, password: user.password
        expect(response).to be_redirect
        expect(response).to redirect_to(user_path(user))
      end

      it "finds the user" do
        expect(User).to receive(:find_by).with({email: user.email}).and_return(user)
        post :create, email: user.email, password: user.password
      end

      it "authenticates the user" do
        allow(User).to receive(:find_by).and_return(user)
        expect(user).to receive(:authenticate)
        post :create, email: user.email, password: user.password
      end

      it "sets the user_id in the session" do
        post :create, email: user.email, password: user.password
        expect(session[:user_id]).to eq(user.id)
      end

      it "sets the flash success message" do
        post :create, email: user.email, password: user.password
        expect(flash[:notice]).to eq("Login Successful")
      end
    end

    shared_examples_for "denied login" do
      it "renders the new template" do
        post :create, email: email, password: password
        expect(response).to render_template :new
      end

      it "sets the flash error message" do
        post :create, email: email, password: password
        expect(flash[:alert]).to eq("Login failed. Please check your email and password.")
      end
    end

    context "with blank credentials" do
      let(:email) { "" }
      let(:password) { "" }
      
      it_behaves_like "denied login"
    end

    context "with an incorrect password" do
      let!(:user) { create(:user, :valid_password) }
      let(:email) { user.email }
      let(:password) { "not my password" }

      it_behaves_like "denied login"
    end

    context "with a non-existent email" do
      let(:email) { "no@email.com" }
      let(:password) { "not my password" }

      it_behaves_like "denied login"
    end

  end

  describe "DELETE #destroy" do
    let!(:user) { create(:user, :valid_password) }
    
    before do
      sign_in user
    end

    it "deletes the session" do
      delete :destroy
      expect(session).to be_empty
    end

    it "redirects to the home page" do
      delete :destroy
      expect(response).to be_redirect
      expect(response).to redirect_to(root_url)
    end
  end

end
