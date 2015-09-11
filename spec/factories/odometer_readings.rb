FactoryGirl.define do
  factory :odometer_reading do
    value       { Faker::Number.number(6).to_i }
    entry_date  { Faker::Date.backward(365) }
    association :vehicle
  end
end
