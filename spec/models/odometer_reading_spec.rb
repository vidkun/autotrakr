require 'rails_helper'

RSpec.describe OdometerReading, type: :model do
  let(:odometer_reading) { create(:odometer_reading) }

  it "should have a value field" do
    expect(odometer_reading.attributes).to include(:value)
  end

  it "should have an entry_date field" do
    expect(odometer_reading.attributes).to include(:entry_date)
  end

  it "fails because value is too long" do
    invalid_reading = build(:odometer_reading, value: Faker::Number.number(8).to_i)
    expect(invalid_reading).to_not be_valid
    expect(invalid_reading.save).to be false
    expect(invalid_reading.errors[:value]).to include("is too long (maximum is 7 characters)")
  end

  it "fails because value is not an integer" do
    invalid_reading = build(:odometer_reading, value: Faker::Lorem.word)
    expect(invalid_reading).to_not be_valid
    expect(invalid_reading.save).to be false
    expect(invalid_reading.errors[:value]).to include("should be a integer")
  end
end
