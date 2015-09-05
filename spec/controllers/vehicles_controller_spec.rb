require 'rails_helper'

RSpec.describe VehiclesController, type: :controller do

  context "as a logged in user" do
    let!(:user) { create(:user, :valid_password) }
    let(:vehicle) { create(:vehicle, user: user) }

    let(:invalid_attributes) {
      { year: "invalid",
        make: 123,
        model: 123,
        user: user
      }
    }

    before do
      sign_in user
    end

    describe "GET #index" do
      it "assigns all the user's vehicles as @vehicles" do
        5.times { create(:vehicle, user: user) }
        get :index, user_id: user.id
        expect(assigns(:vehicles)).to eq(user.vehicles.to_a)
      end
    end

    describe "GET #show" do
      it "assigns the requested user vehicle as @vehicle" do
        get :show, {id: vehicle.to_param,
                    user_id: user.id}
        expect(assigns(:vehicle)).to eq(vehicle)
      end
    end

    describe "GET #new" do
      it "assigns a new user vehicle as @vehicle" do
        get :new, user_id: user.id
        expect(assigns(:vehicle)).to be_a_new(Vehicle)
      end
    end

    describe "GET #edit" do
      it "assigns the requested user vehicle as @vehicle" do
        get :edit, {id: vehicle.to_param,
                    user_id: user.id}
        expect(assigns(:vehicle)).to eq(vehicle)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        before(:each) do
          @new_vehicle = attributes_for(:vehicle)
          @new_vehicle[:user] = user
        end

        it "creates a new user Vehicle" do
          expect {
            post :create, {vehicle: @new_vehicle,
                           user_id: user.id}
          }.to change(Vehicle, :count).by(1)
        end

        it "assigns a newly created user vehicle as @vehicle" do
          post :create, {vehicle: @new_vehicle,
                         user_id: user.id}
          expect(assigns(:vehicle)).to be_a(Vehicle)
          expect(assigns(:vehicle)).to be_persisted
        end

        it "redirects to the created user vehicle" do
          post :create, {vehicle: @new_vehicle,
                         user_id: user.id}
          expect(response).to redirect_to(user_vehicle_path(user, Vehicle.last))
        end
      end

      context "with invalid params" do
        before(:each) do
          @invalid_vehicle = attributes_for(:vehicle)
          @invalid_vehicle[:user] = user
          @invalid_vehicle[:year] = "invalid"
        end

        it "assigns a newly created but unsaved user vehicle as @vehicle" do
          post :create, {vehicle: @invalid_vehicle,
                         user_id: user.id}
          expect(assigns(:vehicle)).to be_a_new(Vehicle)
        end

        it "re-renders the 'new' template" do
          post :create, {vehicle: @invalid_vehicle,
                         user_id: user.id}
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          { year: 1234,
            make: "changed",
            model: "changed",
          }
        }

        it "updates the requested user vehicle" do
          put :update, {id: vehicle.to_param,
                        vehicle: new_attributes,
                        user_id: user.id}
          vehicle.reload
          expect(vehicle.year).to eq(1234)
          expect(vehicle.make).to eq("changed")
          expect(vehicle.model).to eq("changed")
        end

        it "assigns the requested user vehicle as @vehicle" do
          put :update, {id: vehicle.to_param,
                        vehicle: new_attributes,
                        user_id: user.id}
          expect(assigns(:vehicle)).to eq(vehicle)
        end

        it "redirects to the user vehicle" do
          put :update, {id: vehicle.to_param,
                        vehicle: new_attributes,
                        user_id: user.id}
          expect(response).to redirect_to(user_vehicle_path(user, vehicle))
        end
      end

      context "with invalid params" do
        it "assigns the user vehicle as @vehicle" do
          put :update, {id: vehicle.to_param,
                        vehicle: invalid_attributes,
                        user_id: user.id}
          expect(assigns(:vehicle)).to eq(vehicle)
        end

        it "re-renders the 'edit' template" do
          put :update, {id: vehicle.to_param,
                        vehicle: invalid_attributes,
                        user_id: user.id}
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      before do
        vehicle.reload
      end

      it "destroys the requested user vehicle" do
        expect {
          delete :destroy, {id: vehicle.to_param,
                            user_id: user.id}
        }.to change(Vehicle, :count).by(-1)
      end

      it "redirects to the user's vehicles list" do
        delete :destroy, {id: vehicle.to_param,
                          user_id: user.id}
        expect(response).to redirect_to(garage_url(user))
      end
    end
  end
end
