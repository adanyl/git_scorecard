class GitHubScorecardsController < ApplicationController
  def index
    @rating = Rating.last

    return if @rating.blank?

    @contributor_ratings = @rating.contributor_ratings.order(score: :desc)
  end

  def update_score
    start_date = Date.today - 1.week
    end_date = Date.today

    events = octokit.repository_events('git/git', per_page: 100)

    filtered_events = events.select { |event| event.created_at > start_date }

    rating = Rating.find_or_initialize_by(start_date: start_date, end_date: end_date)

    if rating.new_record?
      rating.save
    else
      rating.contributor_ratings.destroy_all
    end

    create_score(rating, filtered_events)

    redirect_to root_path
  end

  private

  def octokit
    @octokit ||= Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
  end

  def create_score(rating, filtered_events)
    filtered_events.each do |event|
      rating.update_score(event['actor']['login'], event['type'])
    end
  end
end
