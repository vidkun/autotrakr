FactoryGirl.define do
  factory :vehicle do
    year          { Faker::Number.number(4).to_i }
    make          { Faker::Company.name }
    model         { Faker::Lorem.words.to_s }
    engine        { Faker::Lorem.words.to_s }
    transmission  { Faker::Lorem.word }
    drive         { Faker::Lorem.word }
    fuel          { Faker::Lorem.word }
    mileage       { Faker::Number.number(6) }
    color         { Faker::Commerce.color }
    association :user, :valid_password
  end

end
