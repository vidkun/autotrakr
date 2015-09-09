class VehiclesController < ApplicationController
  before_action :set_vehicle, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:new, :create, :update, :destroy]

  def index
    @vehicles = current_user.vehicles
  end

  def show
  end

  def new
    @vehicle = Vehicle.new(user: @user)
  end

  def edit
  end

  def create
    @vehicle = Vehicle.new(vehicle_params.merge(user: @user))

    respond_to do |format|
      if @vehicle.save
        format.html { redirect_to [@user, @vehicle], notice: 'Vehicle was successfully created.' }
        format.json { render :show, status: :created, location: [@user, @vehicle] }
      else
        format.html { render :new }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @vehicle.update(vehicle_params)
        format.html { redirect_to [@user, @vehicle], notice: 'Vehicle was successfully updated.' }
        format.json { render :show, status: :ok, location: [@user, @vehicle] }
      else
        format.html { render :edit }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vehicle.destroy
    respond_to do |format|
      format.html { redirect_to garage_url(@user), notice: 'Vehicle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end

    def set_user
      @user = User.find(current_user.id)
    end

    def vehicle_params
      params.require(:vehicle).permit(:name,
                                      :vin,
                                      :year,
                                      :make,
                                      :model,
                                      :engine,
                                      :transmission,
                                      :drive,
                                      :fuel,
                                      :color,
                                      :user_id)
    end
end
