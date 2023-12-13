# spec/factories/podcasts.rb
FactoryBot.define do
    factory :podcast do
      title { Faker::Podcast.name }
      description { Faker::Lorem.sentence(word_count: 20) }
      duration { Faker::Number.between(from: 60, to: 3600) }
      host { Faker::Name.name }
    end
  end
  