require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) { { email: "user@email.com",
                             password: "iamapassword",
                             password_confirmation: "iamapassword" } }

  let(:valid_session) { {} }

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
    context "with valid params" do
      it "creates a new user" do
        expect {
          post :create, { user: valid_attributes }, valid_session
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, { user: valid_attributes }, valid_session
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it "redirects to the user path" do
        post :create, { user: valid_attributes }, valid_session
        expect(response).to be_redirect
        expect(response).to redirect_to(user_path(assigns(:user)))
      end

      it "sets the flash success message" do
        post :create, { user: valid_attributes }, valid_session
        expect(flash[:notice]).to eq("Registration successful!")
      end

      it "sets the session user_id to the created user" do
        post :create, { user: valid_attributes }, valid_session
        expect(session[:user_id]).to eq(User.where(email: valid_attributes[:email]).first.id)
      end
    end
  end

  context "as a logged in user" do
    let!(:user) { create(:user, :valid_password) }

    before do
      sign_in user
    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit, id: user.id
        expect(response).to have_http_status(:success)
      end

      it "renders the edit template" do
        get :edit, id: user.id
        expect(response).to render_template :edit
      end
    end

    describe "PATCH #update" do
      let!(:new_email) { Faker::Internet.safe_email }

      it "updates the user attributes" do
        patch :update, id: user.id, user: { email: new_email }
        user.reload
        expect(user.email).to eq(new_email)
      end

      it "redirects to the user path" do
        patch :update, id: user.id, user: { email: new_email }
        expect(response).to be_redirect
        expect(response).to redirect_to(user_url(assigns(:user)))
      end

      it "sets the flash success message" do
        patch :update, id: user.id, user: { email: new_email }
        expect(flash[:notice]).to eq("Update successful!")
      end
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, id: user.id
        expect(response).to have_http_status(:success)
      end

      it "renders the show template" do
        get :show, id: user.id
        expect(response).to render_template :show
      end
    end
  end
end
