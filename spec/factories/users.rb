FactoryGirl.define do
  factory :user do
    email	{ Faker::Internet.safe_email }

    trait :valid_password do
      password			{ Faker::Internet.password(8, 50) }
      password_confirmation	{ "#{password}" }
    end

    trait :short_password do
      password			{ Faker::Internet.password(4) }	
      password_confirmation { "#{password}" }
    end

    trait :mismatch_password do
      password      { Faker::Internet.password(8, 50) } 
      password_confirmation { Faker::Internet.password(4) }
    end
  end
end
