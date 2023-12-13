# spec/factories/users.rb
FactoryBot.define do
    factory :user do
      email { Faker::Internet.email }
      password { Faker::Internet.password(min_length: 10, max_length: 20) }
      first_name { Faker::Name.first_name }
      last_name { Faker::Name.last_name }
    end
  end
  