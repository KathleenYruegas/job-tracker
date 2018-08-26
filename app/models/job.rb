class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, presence: true
  belongs_to :company
  has_many :job_comments
  belongs_to :category

  def self.sort_by_location
    order(:city)
  end
end
