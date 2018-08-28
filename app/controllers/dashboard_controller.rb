class DashboardController < ApplicationController
  def index
    @cities = Job.get_cities
    @city_counts = Job.city_counter
    @interests_count = Job.interest_count
    @top_companies_by_interest = Company.top_companies_by_interest
  end
end
