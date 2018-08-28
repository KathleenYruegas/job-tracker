require 'rails_helper'

describe "User sees one company's jobs" do
  scenario "a user sees a company's jobs" do
    company = Company.create!(name: "ESPN")
    category = Category.create!(title: "Devs")
    company.jobs.create!(title: "Developer", level_of_interest: 2, city: "Denver", category_id: category.id)

    visit company_jobs_path(company)

    expect(current_path).to eq("/companies/#{company.id}/jobs")
    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
  end
end
