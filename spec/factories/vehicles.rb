FactoryGirl.define do
  factory :vehicle do
    year          { Faker::Number.number(4) }
    make          { Faker::Company.name }
    model         { Faker::Lorem.words }
    engine        { Faker::Lorem.words }
    transmission  { Faker::Lorem.word }
    drive         { Faker::Lorem.word }
    fuel          { Faker::Lorem.word }
    mileage       { Faker::Number.number(6) }
    color         { Faker::Commerce.color }
    user          { create(:user, :valid_password) }
  end

end
