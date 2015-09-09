require 'rails_helper'

RSpec.describe OdometerReadingsController, type: :controller do

  context "as a logged in user" do
    let!(:user) { create(:user, :valid_password) }
    let(:vehicle) { create(:vehicle, user: user) }
    let(:odometer_reading) { create(:odometer_reading, vehicle: vehicle) }

    let(:invalid_attributes) {
      { value: "invalid",
        entry_date: "invlid",
        vehicle: vehicle
      }
    }

    before do
      sign_in user
    end

    describe "GET #index" do
      it "assigns all odometer_readings as @odometer_readings" do
        5.times { create(:odometer_reading, vehicle: vehicle) }
        get :index, vehicle_id: vehicle.id, user_id: user.id
        expect(assigns(:odometer_readings)).to eq(vehicle.odometer_readings.to_a)
      end
    end

    describe "GET #show" do
      it "assigns the requested odometer_reading as @odometer_reading" do
        get :show, {id: odometer_reading.to_param,
                    vehicle_id: vehicle.id,
                    user_id: user.id}
        expect(assigns(:odometer_reading)).to eq(odometer_reading)
      end
    end

    describe "GET #new" do
      it "assigns a new odometer_reading as @odometer_reading" do
        get :new, vehicle_id: vehicle.id, user_id: user.id
        expect(assigns(:odometer_reading)).to be_a_new(OdometerReading)
      end
    end

    describe "GET #edit" do
      it "assigns the requested odometer_reading as @odometer_reading" do
        get :edit, {id: odometer_reading.to_param,
                    vehicle_id: vehicle.id,
                    user_id: user.id}
        expect(assigns(:odometer_reading)).to eq(odometer_reading)
      end
    end

    describe "POST #create" do
      context "with valid params" do

        before(:each) do
          @new_reading = attributes_for(:odometer_reading)
          @new_reading[:vehicle] = vehicle
        end

        it "creates a new OdometerReading" do
          expect {
            post :create, {odometer_reading: @new_reading,
                           vehicle_id: vehicle.id,
                           user_id: user.id}
          }.to change(OdometerReading, :count).by(1)
        end

        it "assigns a newly created odometer_reading as @odometer_reading" do
          post :create, {odometer_reading: @new_reading,
                         vehicle_id: vehicle.id,
                         user_id: user.id}
          expect(assigns(:odometer_reading)).to be_a(OdometerReading)
          expect(assigns(:odometer_reading)).to be_persisted
        end

        it "redirects to the created odometer_reading" do
          post :create, {odometer_reading: @new_reading,
                         vehicle_id: vehicle.id,
                         user_id: user.id}
          # binding.pry
          expect(response).to redirect_to(user_vehicle_odometer_reading_path(user, vehicle, OdometerReading.last))
        end
      end

      context "with invalid params" do
        before(:each) do
          @invalid_reading = attributes_for(:vehicle)
          @invalid_reading[:vehicle] = vehicle
          @invalid_reading[:value] = "invalid"
        end

        it "assigns a newly created but unsaved odometer_reading as @odometer_reading" do
          post :create, {odometer_reading: @invalid_reading,
                         vehicle_id: vehicle.id,
                         user_id: user.id}
          expect(assigns(:odometer_reading)).to be_a_new(OdometerReading)
        end

        it "re-renders the 'new' template" do
          post :create, {odometer_reading: @invalid_reading,
                         vehicle_id: vehicle.id,
                         user_id: user.id}
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          { value: Faker::Number.number(6).to_i,
            entry_date: Faker::Date.backward(365)
          }
        }

        it "updates the requested odometer_reading" do
          put :update, {id: odometer_reading.to_param,
                        odometer_reading: new_attributes,
                        vehicle_id: vehicle.id,
                        user_id: user.id}
          odometer_reading.reload
          expect(odometer_reading.value).to eq(new_attributes[:value])
          expect(odometer_reading.entry_date).to eq(new_attributes[:entry_date])
        end

        it "assigns the requested odometer_reading as @odometer_reading" do
          put :update, {id: odometer_reading.to_param,
                        odometer_reading: new_attributes,
                        vehicle_id: vehicle.id,
                        user_id: user.id}
          expect(assigns(:odometer_reading)).to eq(odometer_reading)
        end

        it "redirects to the odometer_reading" do
          put :update, {id: odometer_reading.to_param,
                        odometer_reading: new_attributes,
                        vehicle_id: vehicle.id,
                        user_id: user.id}
          expect(response).to redirect_to(user_vehicle_odometer_reading_path(user, vehicle, odometer_reading))
        end
      end

      context "with invalid params" do
        it "assigns the odometer_reading as @odometer_reading" do
          put :update, {id: odometer_reading.to_param,
                        odometer_reading: invalid_attributes,
                        vehicle_id: vehicle.id,
                        user_id: user.id}
          expect(assigns(:odometer_reading)).to eq(odometer_reading)
        end

        it "re-renders the 'edit' template" do
          put :update, {id: odometer_reading.to_param,
                        odometer_reading: invalid_attributes,
                        vehicle_id: vehicle.id,
                        user_id: user.id}
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      before do
        odometer_reading.reload
      end

      it "destroys the requested odometer_reading" do
        expect {
          delete :destroy, {id: odometer_reading.to_param,
                            vehicle_id: vehicle.id,
                            user_id: user.id}
        }.to change(OdometerReading, :count).by(-1)
      end

      it "redirects to the odometer_readings list" do
        delete :destroy, {id: odometer_reading.to_param,
                          vehicle_id: vehicle.id,
                          user_id: user.id}
        expect(response).to redirect_to(user_vehicle_odometer_readings_url(user, vehicle))
      end
    end
  end
end
