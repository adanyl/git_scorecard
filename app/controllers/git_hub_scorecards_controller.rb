class GitHubScorecardsController < ApplicationController
	def index
		@contributors = GitHubScorecard.top_contributors
	end

	def update_score
		events = github_client.repository_events('rubocop/rubocop', per_page: 100)

		
		events.each do |event|
			GitHubScorecard.update_score(event['actor'], event['type'])
		end

		redirect_to root_path
	end

	private

	def github_client
		@github_client ||= Octokit::Client.new(access_token: ENV["GITHUB_TOKEN"])
	end
end