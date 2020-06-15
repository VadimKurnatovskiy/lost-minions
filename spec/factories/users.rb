# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone_number { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    timezone { 'Moscow' }
    role { 'user' }
    call_time_from { Time.utc(2020, 5, 6, 9) }
    call_time_to { Time.utc(2020, 5, 6, 21) }

    trait :admin do
      role { 'admin' }
    end
  end
end
