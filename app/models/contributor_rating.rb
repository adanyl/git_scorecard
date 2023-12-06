class ContributorRating < ApplicationRecord
  belongs_to :contributor
  belongs_to :rating
end
