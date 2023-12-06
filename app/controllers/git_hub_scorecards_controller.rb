class GitHubScorecardsController < ApplicationController
  before_action :load_rating, only: :index

  def index
    @contributor_ratings = @rating&.contributor_ratings
  end

  def update_score
    start_date = Date.today - 1.week
    end_date = Date.today

    events = octokit.repository_events('git/git', per_page: 100)
    filtered_events = events.select { |event| event.created_at > start_date }

    Rating.create_or_update(start_date, end_date, filtered_events)

    redirect_to root_path
  end

  private

  def octokit
    @octokit ||= Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
  end

  def load_rating
    @rating = Rating.order(end_date: :desc).first
  end
end
