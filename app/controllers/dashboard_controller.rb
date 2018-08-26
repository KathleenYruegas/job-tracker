class DashboardController < ApplicationController
  def index
    @cities = Job.get_cities
    @city_counts = Job.city_counter
  end
end
