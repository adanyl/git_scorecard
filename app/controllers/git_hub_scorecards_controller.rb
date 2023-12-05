class GitHubScorecardsController < ApplicationController
  def index
    @contributors = GitHubScorecard.top_contributors
  end

  def update_score
    one_week_ago = Time.now - 7.days

    events = octokit.repository_events('git/git', per_page: 100)

    fitered_events = events.select { |event| event.created_at > one_week_ago }

    fitered_events.each do |event|
      GitHubScorecard.update_score(event['actor']['login'], event['type'], event['id'])
    end

    redirect_to root_path
  end

  private

  def octokit
    @octokit ||= Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
  end
end
