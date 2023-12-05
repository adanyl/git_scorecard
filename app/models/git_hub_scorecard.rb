class GitHubScorecard < ApplicationRecord
  def self.update_score(username, event_type, event_id)
    return if ProcessedEvent.exists?(git_event_id: event_id)

    score = case event_type
            when 'PullRequestEvent' then 12
            when 'PullRequestReviewCommentEvent' then 1
            when 'PullRequestReviewEvent' then 3
            else 0
            end

    return if score.zero?

    contributor = find_or_create_by(username: username)
    contributor.update(score: contributor.score + score)

    ProcessedEvent.create(git_event_id: event_id)
  end

  def self.top_contributors
    order(score: :desc)
  end
end
