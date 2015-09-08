require "rails_helper"

RSpec.describe OdometerReadingsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/odometer_readings").to route_to("odometer_readings#index")
    end

    it "routes to #new" do
      expect(:get => "/odometer_readings/new").to route_to("odometer_readings#new")
    end

    it "routes to #show" do
      expect(:get => "/odometer_readings/1").to route_to("odometer_readings#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/odometer_readings/1/edit").to route_to("odometer_readings#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/odometer_readings").to route_to("odometer_readings#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/odometer_readings/1").to route_to("odometer_readings#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/odometer_readings/1").to route_to("odometer_readings#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/odometer_readings/1").to route_to("odometer_readings#destroy", :id => "1")
    end

  end
end
