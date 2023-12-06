class RatingsController < ApplicationController
  def index
    @filter = RatingFilterForm.new(filter_params)
    @ratings = Rating.filtered_by_dates(@filter.start_date, @filter.end_date)
  end

  private

  def filter_params
    params.fetch(:rating_filter_form, {}).permit(:start_date, :end_date).transform_values do |date|
      Date.parse(date) if date.present?
    end
  end
end
