RANDOM_HUNDRED_CHARS="hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello worldhello world"


FactoryBot.define do
  factory :news_article do
    sequence(:title){ |n| Faker::Job.title + "#{n}"}
    description{ Faker::Job.field + "#{RANDOM_HUNDRED_CHARS}"}
    published_at { Date.current }  
    created_at { Date.yesterday } 
    view_count { rand(1..900) }
    association(:user, factory: :user)
  end
end


