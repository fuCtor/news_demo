FactoryGirl.define do
  factory :news do
    title { Faker::Lorem.sentence }
    annotation { Faker::Lorem.paragraph  }
    from_yandex true
    published_at { Faker::Time.between(2.hours.ago, Time.now) }

    trait :from_admin do
      from_yandex false
      date { Faker::Time.between(Time.now + 1.minute, Time.now + 15.minute).change(nsec: 0) }
      published_at { Time.now }
    end

    trait :from_feature do
      published_at { Time.now + 16.minute }
    end

    factory :admin_news, traits: [:from_admin]
    factory :feature_admin_news, traits: [:from_feature, :from_admin]
    factory :feature_news, traits: [:from_feature]
  end
end