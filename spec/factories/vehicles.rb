FactoryGirl.define do
  factory :vehicle do
    year          { Faker::Number.number(4).to_i }
    make          { Faker::Company.name }
    model         { Faker::Lorem.words.join(' ') }
    engine        { Faker::Lorem.words.join(' ') }
    transmission  { Faker::Lorem.word }
    drive         { Faker::Lorem.word }
    fuel          { Faker::Lorem.word }
    mileage       { Faker::Number.number(6).to_i }
    color         { Faker::Commerce.color }
    association :user, :valid_password
  end

end
