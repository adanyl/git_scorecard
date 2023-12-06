class Rating < ApplicationRecord
  has_many :contributor_ratings, dependent: :destroy
  has_many :contributors, through: :contributor_ratings

  scope :filtered_by_dates, ->(start_date, end_date) { where(start_date: start_date, end_date: end_date) }

  def self.create_or_update(start_date, end_date, events)
    rating = find_or_initialize_by(start_date: start_date, end_date: end_date)

    if rating.new_record?
      rating.save
    else
      rating.contributor_ratings.destroy_all
    end

    rating.update_scores(events)

    rating
  end

  def update_scores(events)
    events.each do |event|
      update_score(event['actor']['login'], event['type'])
    end
  end

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
end
