FactoryBot.define do
  factory :contributor do
    sequence(:username) { |n| "user#{n}" }
  end
end
