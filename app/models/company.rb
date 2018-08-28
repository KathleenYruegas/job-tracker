class Company < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :jobs, dependent: :destroy
  has_many :company_contacts


  def self.top_companies_by_interest
    top_3_companies = select("companies.*, avg(level_of_interest) AS average_interest").joins(:jobs).group(:company_id, :id).order("average_interest DESC").limit(3)
    top_3_companies.inject({}) do |company_average, company|
      company_average[company.name] = company.jobs.average(:level_of_interest)
      company_average
    end
  end

end
