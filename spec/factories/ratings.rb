FactoryBot.define do
  factory :rating do
    start_date { Date.yesterday }
    end_date { Date.tomorrow }
  end
end
