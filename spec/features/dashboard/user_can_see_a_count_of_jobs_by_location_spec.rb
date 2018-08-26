require 'rails_helper'

describe 'User can see job count by location' do
  describe 'on the dashboard' do
    it 'shows a job count by location' do
      company = Company.create!(name: "ESPN")
      category = Category.create!(title: "Devs")
      Job.create!(title: "Developer", level_of_interest: 90, city: "Denver", company: company, category: category)
      Job.create!(title: "Developer", level_of_interest: 90, city: "Denver", company: company, category: category)
      Job.create!(title: "Developer", level_of_interest: 90, city: "Boulder", company: company, category: category)
      Job.create!(title: "Developer", level_of_interest: 90, city: "Boulder", company: company, category: category)
      Job.create!(title: "Developer", level_of_interest: 90, city: "Boulder", company: company, category: category)
      Job.create!(title: "Developer", level_of_interest: 90, city: "Chicago", company: company, category: category)

      visit '/dashboard'
      expect(page).to have_content("Boulder Jobs: #{Job.where(city: "Boulder").count} jobs")
      expect(page).to have_content("Denver Jobs: #{Job.where(city: "Denver").count} jobs")
      expect(page).to have_content("Chicago Jobs: #{Job.where(city: "Chicago").count} job")
    end
  end
end
