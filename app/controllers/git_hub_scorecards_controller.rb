class GitHubScorecardsController < ApplicationController
  def index
    @contributors = GitHubScorecard.top_contributors
  end

  def update_score
    one_week_ago = Time.now - 7.days

    events = github_client.repository_events('git/git', since: one_week_ago.iso8601, per_page: 100)

    events.each do |event|
      GitHubScorecard.update_score(event['actor']['login'], event['type'], event['id'])
    end

    redirect_to root_path
  end

  private

  def github_client
    @github_client ||= Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
  end
end
