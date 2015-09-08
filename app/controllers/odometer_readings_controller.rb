class OdometerReadingsController < ApplicationController
  before_action :set_odometer_reading, only: [:show, :edit, :update, :destroy]

  # GET /odometer_readings
  # GET /odometer_readings.json
  def index
    @odometer_readings = OdometerReading.all
  end

  # GET /odometer_readings/1
  # GET /odometer_readings/1.json
  def show
  end

  # GET /odometer_readings/new
  def new
    @odometer_reading = OdometerReading.new
  end

  # GET /odometer_readings/1/edit
  def edit
  end

  # POST /odometer_readings
  # POST /odometer_readings.json
  def create
    @odometer_reading = OdometerReading.new(odometer_reading_params)

    respond_to do |format|
      if @odometer_reading.save
        format.html { redirect_to @odometer_reading, notice: 'Odometer reading was successfully created.' }
        format.json { render :show, status: :created, location: @odometer_reading }
      else
        format.html { render :new }
        format.json { render json: @odometer_reading.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /odometer_readings/1
  # PATCH/PUT /odometer_readings/1.json
  def update
    respond_to do |format|
      if @odometer_reading.update(odometer_reading_params)
        format.html { redirect_to @odometer_reading, notice: 'Odometer reading was successfully updated.' }
        format.json { render :show, status: :ok, location: @odometer_reading }
      else
        format.html { render :edit }
        format.json { render json: @odometer_reading.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /odometer_readings/1
  # DELETE /odometer_readings/1.json
  def destroy
    @odometer_reading.destroy
    respond_to do |format|
      format.html { redirect_to odometer_readings_url, notice: 'Odometer reading was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_odometer_reading
      @odometer_reading = OdometerReading.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def odometer_reading_params
      params.require(:odometer_reading).permit(:value, :entry_date, :vehicle_id)
    end
end
