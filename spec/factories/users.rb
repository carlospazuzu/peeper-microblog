require 'ffaker'

FactoryBot.define do
  factory :user do
    display_name { FFaker::Name.name }
    handle       { FFaker::String.unique.from_regexp(/[a-z]{4,12}/) }
    bio          { 'valid_bio' }
    born_at      { 14.years.ago }
  end
end
