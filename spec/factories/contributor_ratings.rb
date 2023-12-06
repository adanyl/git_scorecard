FactoryBot.define do
  factory :contributor_rating do
    score { 0 }
    association :rating
    association :contributor
  end
end
