class DashboardController < ApplicationController
  def index
    @cities = Job.get_cities
    @city_counts = @cities.map{ |city| [city, Job.count_city(city)] }.to_h
  end
end
