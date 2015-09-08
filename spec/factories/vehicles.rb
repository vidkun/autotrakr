FactoryGirl.define do
  factory :vehicle do
    name          { Faker::Lorem.words.join(' ') }
    year          { Faker::Number.number(4).to_i }
    make          { Faker::Company.name }
    model         { Faker::Lorem.words.join(' ') }
    vin           { Faker::Lorem.characters(17) }
    engine        { Faker::Lorem.words.join(' ') }
    transmission  { Faker::Lorem.word }
    drive         { Faker::Lorem.word }
    fuel          { Faker::Lorem.word }
    # mileage       { Faker::Number.number(6).to_i }
    color         { Faker::Commerce.color }
    association :user, :valid_password
  end

end
