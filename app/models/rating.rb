class Rating < ApplicationRecord
  has_many :contributor_ratings, dependent: :destroy
  has_many :contributors, through: :contributor_ratings

  def update_score(username, event_type)
    score = case event_type
            when 'PullRequestEvent' then 12
            when 'PullRequestReviewCommentEvent' then 1
            when 'PullRequestReviewEvent' then 3
            else 0
            end

    return if score.zero?

    contributor = Contributor.find_or_create_by(username: username)

    contributor_rating = contributor_ratings.find_or_create_by(contributor_id: contributor.id)

    contributor_rating.update(score: contributor_rating.score + score)
  end

  def top_contributors
    contributors.order('contributor_ratings.score DESC')
  end
end
