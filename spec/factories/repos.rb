FactoryBot.define do
  factory :repo do
    title { Faker::Lorem.word }
    url { Faker::Internet.url(host: 'github', path: '/fake_test_path')}
  end
end