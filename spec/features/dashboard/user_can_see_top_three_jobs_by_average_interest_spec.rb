require 'rails_helper'

describe 'User can see top 3 companies by interest' do
  describe 'on the dashboard' do
    it 'shows the top 3 companies sorted by interest' do
      category  = Category.create(title: "A category")
      company   = Company.create(name: "Google")
      company_2 = Company.create(name: "Microsoft")
      company_3 = Company.create(name: "Twitter")
      company.jobs.create(title: "Title 1", level_of_interest: 3, city: "Denver", category: category)
      company.jobs.create(title: "Title 2", level_of_interest: 2, city: "Denver", category: category)
      company_2.jobs.create(title: "Title 1", level_of_interest: 2, city: "Denver", category: category)
      company_2.jobs.create(title: "Title 2", level_of_interest: 4, city: "Denver", category: category)
      company_3.jobs.create(title: "Title 1", level_of_interest: 1, city: "Denver", category: category)
      company_3.jobs.create(title: "Title 2", level_of_interest: 1, city: "Denver", category: category)
      values = Company.top_companies_by_interest

      visit dashboard_path
      expect(page).to have_content("Google: #{values["Google"]} Stars")
      expect(page).to have_content("Microsoft: #{values["Microsoft"]} Stars")
      expect(page).to have_content("Twitter: #{values["Twitter"]} Star")
    end
  end
end
