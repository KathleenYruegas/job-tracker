class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, presence: true
  belongs_to :company
  has_many :job_comments
  belongs_to :category

  def self.get_cities
    distinct.pluck(:city)
  end

  def self.count_city(city)
    where(city: city).count
  end
end
