
FactoryGirl.define do
  
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password "useruser"
  end

  factory :customer, class: User do
    sequence(:email) { |n| "customer#{n}@example.com" }
    password "customer"
    customer true
  end

  factory :admin, class: User do
    #sequence(:email) { |n| "admin#{n}@example.com" }
    email "admin@example.com"
    password "adminadmin"
    admin true
  end
  
  factory :site do
    sequence(:name) { |n| Faker::Company.name }
    sequence(:url) { |n| Faker::Internet.url }
    
    association :user, factory: :customer
    
    after(:create) do |site, evaluator|
      FactoryGirl.create_list(:idea, 5, site: site)
    end
    
  end
  
  factory :idea do
    sequence(:title) { |n| Faker::Company.catch_phrase }
    sequence(:description) { |n| Faker::Lorem.paragraph 10 }
    
    association :site
    association :user
    
    after(:create) do |idea, evaluator|
      FactoryGirl.create_list(:comment, 5, idea: idea)
    end
    
  end
  
  factory :comment do
    sequence(:text) { |n| Faker::Lorem.paragraph 10 }
    
    association :idea
    association :user
  end
  
end