class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, presence: true
  belongs_to :company
  belongs_to :category
  has_many :job_comments

  def self.city_counter
    cities = get_cities
    cities.map{ |city| [city, Job.count_city(city)] }.to_h
  end

  def self.get_cities
    distinct.pluck(:city)
  end

  def self.count_city(city)
    where(city: city).count
  end

  def self.sort_by_location
    order(:city)
  end

  def self.interest_count
    group(:level_of_interest).order(level_of_interest: :desc).count
  end

  def self.sort_by_interest
    order("level_of_interest DESC", :title)
  end
end
