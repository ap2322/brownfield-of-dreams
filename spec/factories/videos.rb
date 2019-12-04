FactoryBot.define do
  factory :video do
    title { Faker::Games::Pokemon.name }
    description { Faker::TvShows::SiliconValley.motto }
    video_id { Faker::Crypto.md5 }
    thumbnail { "https://i.ytimg.com/vi/XsPVWGKK0qI/hqdefault.jpg" }
    tutorial
  end
end
