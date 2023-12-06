class Contributor < ApplicationRecord
  has_many :contributor_ratings, dependent: :destroy
  has_many :ratings, through: :contributor_ratings
end
