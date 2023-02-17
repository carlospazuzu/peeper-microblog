require 'ffaker'

FactoryBot.define do
  factory :status, aliases: [:replied_to_status] do
    body { 'Valid body' }
    # association :user, factory: :user
    user

    trait :with_reply do
      replied_to_status
    end

    trait :with_long_body do
      body { 's' * 300 }
    end

    factory :status_with_replies do
      replies { [association(:replied_status)] }
    end

    factory :replied_status, traits: [:with_reply]
    factory :status_with_long_body, traits: [:with_long_body]
  end
end
