class GitHubScorecard < ApplicationRecord
	def self.update_score(username, event_type)
		score = case event_type
						when 'PullRequestEvent' then 12
						when 'PullRequestReviewCommentEvent' then 1
						when 'PullRequestReviewEvent' then 3
						else 0
						end

		contributor = find_or_create_by(username: username[:login])
		contributor.update(score: contributor.score + score)
	end

	def self.top_contributors
		self.order(score: :desc)
	end
end