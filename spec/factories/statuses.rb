FactoryBot.define do
  factory :status do
    body { "Whatever status you would want" }

    transient do
      media {[]}
    end

    after(:create) do |status, data|
      status.media << data.media
    end
  end
end
