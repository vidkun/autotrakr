class OdometerReadingsController < ApplicationController
  before_action :set_odometer_reading, only: [:show, :edit, :update, :destroy]
  before_action :set_vehicle #, except: [:show, :edit]
  before_action :set_user, only: [:create, :update, :destroy]

  def index
    @odometer_readings = @vehicle.odometer_readings
  end

  def show
  end

  def new
    @odometer_reading = OdometerReading.new(vehicle: @vehicle)
  end

  def edit
  end

  def create
    if odometer_reading_params["entry_date"]
      @odometer_reading = OdometerReading.new(odometer_reading_params)
    else
      odometer_attributes = odometer_reading_params.except("entry_date(1i)", "entry_date(2i)", "entry_date(3i)")
      odometer_attributes.merge!(entry_date: build_date)
      @odometer_reading = OdometerReading.new(odometer_attributes)
    end

    respond_to do |format|
      if @odometer_reading.save
        format.html { redirect_to [@user, @vehicle, @odometer_reading], notice: 'Odometer reading was successfully created.' }
        format.json { render :show, status: :created, location: [@user, @vehicle, @odometer_reading] }
      else
        format.html { render :new }
        format.json { render json: @odometer_reading.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if odometer_reading_params["entry_date"]
      odometer_attributes = odometer_reading_params
    else
      odometer_attributes = odometer_reading_params.except("entry_date(1i)", "entry_date(2i)", "entry_date(3i)")
      odometer_attributes.merge!(entry_date: build_date)
    end

    respond_to do |format|
      if @odometer_reading.update(odometer_attributes)
        format.html { redirect_to [@user, @vehicle, @odometer_reading], notice: 'Odometer reading was successfully updated.' }
        format.json { render :show, status: :ok, location: [@user, @vehicle, @odometer_reading] }
      else
        format.html { render :edit }
        format.json { render json: @odometer_reading.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @odometer_reading.destroy
    respond_to do |format|
      format.html { redirect_to user_vehicle_odometer_readings_url(@user, @vehicle), notice: 'Odometer reading was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_odometer_reading
      @odometer_reading = OdometerReading.find(params[:id])
    end

    def set_user
      @user = User.find(current_user.id)
    end

    def set_vehicle
      @vehicle = Vehicle.find(params[:vehicle_id])
    end

    def build_date
      if odometer_reading_params.grep(/1i/).any?
        Date.new odometer_reading_params["entry_date(1i)"].to_i, odometer_reading_params["entry_date(2i)"].to_i, odometer_reading_params["entry_date(3i)"].to_i
      else
        Date.new 1908, 10, 1
      end
    end

    def odometer_reading_params
      params.require(:odometer_reading).permit(:value,
                                               :entry_date,
                                               :vehicle_id,
                                               :user_id)
    end
end
