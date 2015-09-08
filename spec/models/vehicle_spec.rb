require "rails_helper"

RSpec.describe Vehicle, type: :model do
  let(:vehicle) { create(:vehicle) }

  it "should have a name field" do
    expect(vehicle.attributes).to include(:name)
  end

  it "should have a vin field" do
    expect(vehicle.attributes).to include(:vin)
  end

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

  # it "should have a mileage field" do
  #   expect(vehicle.attributes).to include(:mileage)
  # end

  it "should have a fuel field" do
    expect(vehicle.attributes).to include(:fuel)
  end

  it "should have a color field" do
    expect(vehicle.attributes).to include(:color)
  end

  it "fails because no name" do
    invalid_vehicle = build(:vehicle, name: nil)
    expect(invalid_vehicle).to_not be_valid
    expect(invalid_vehicle.save).to be false
  end

  it "fails because no vin" do
    invalid_vehicle = build(:vehicle, vin: nil)
    expect(invalid_vehicle).to_not be_valid
    expect(invalid_vehicle.save).to be false
  end

  it "fails because no year" do
    invalid_vehicle = build(:vehicle, year: nil)
    expect(invalid_vehicle).to_not be_valid
    expect(invalid_vehicle.save).to be false
  end

  it "fails because no make" do
    invalid_vehicle = build(:vehicle, make: "")
    expect(invalid_vehicle).to_not be_valid
    expect(invalid_vehicle.save).to be false
  end

  it "fails because no model" do
    invalid_vehicle = build(:vehicle, model: "")
    expect(invalid_vehicle).to_not be_valid
    expect(invalid_vehicle.save).to be false
  end

  it "fails because year is too long" do
    invalid_vehicle = build(:vehicle, year: Faker::Number.number(5).to_i)
    expect(invalid_vehicle).to_not be_valid
    expect(invalid_vehicle.save).to be false
    expect(invalid_vehicle.errors[:year]).to include("is too long (maximum is 4 characters)")
  end

  it "fails because vin is not correct length" do
    invalid_vehicle = build(:vehicle, vin: Faker::Number.number(5).to_i)
    expect(invalid_vehicle).to_not be_valid
    expect(invalid_vehicle.save).to be false
    expect(invalid_vehicle.errors[:vin]).to include("is the wrong length (should be 17 characters)")
  end

  # it "fails because mileage is too long" do
  #   invalid_vehicle = build(:vehicle, mileage: Faker::Number.number(8).to_i)
  #   expect(invalid_vehicle).to_not be_valid
  #   expect(invalid_vehicle.save).to be false
  #   expect(invalid_vehicle.errors[:mileage]).to include("is too long (maximum is 7 characters)")
  # end

  it "fails because year is not an integer" do
    invalid_vehicle = build(:vehicle, year: Faker::Lorem.word)
    expect(invalid_vehicle).to_not be_valid
    expect(invalid_vehicle.save).to be false
    expect(invalid_vehicle.errors[:year]).to include("should be a integer")
  end

  # it "fails because mileage is not an integer" do
  #   invalid_vehicle = build(:vehicle, mileage: Faker::Lorem.word)
  #   expect(invalid_vehicle).to_not be_valid
  #   expect(invalid_vehicle.save).to be false
  #   expect(invalid_vehicle.errors[:mileage]).to include("should be a integer")
  # end
end
