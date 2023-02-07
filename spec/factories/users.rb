FactoryBot.define do
  factory :user do
    handle { 'carlospzu' }
    display_name { 'Carlos Pazuzu' }
    bio { 'Whatever... this surely will not be important enough to be noticed..'}
    born_at { 14.years.ago }
  end
end
