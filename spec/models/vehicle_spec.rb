require "rails_helper"

RSpec.describe Vehicle, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  let(:vehicle) { create(:vehicle) }

  it "should have a year field" do
    expect(vehicle.attributes).to include(:year)
  end

  it "should have a make field" do
    expect(vehicle.attributes).to include(:make)
  end

  it "should have a model field" do
    expect(vehicle.attributes).to include(:model)
  end

  it "should have a engine field" do
    expect(vehicle.attributes).to include(:engine)
  end

  it "should have a drive field" do
    expect(vehicle.attributes).to include(:drive)
  end

  it "should have a transmission field" do
    expect(vehicle.attributes).to include(:transmission)
  end

  it "should have a mileage field" do
    expect(vehicle.attributes).to include(:mileage)
  end

  it "should have a fuel field" do
    expect(vehicle.attributes).to include(:fuel)
  end

  it "should have a color field" do
    expect(vehicle.attributes).to include(:color)
  end
end
