FactoryBot.define do
  factory :event do
    event_type { %w(PushEvent ReleaseEvent WatchEvent).sample }
    public { Faker::Boolean.boolean }
  end
end