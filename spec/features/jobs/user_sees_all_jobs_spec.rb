require 'rails_helper'

describe "User sees all jobs" do
  scenario 'user can see all jobs' do
    company = Company.create!(name: "ESPN")
    company_2 = Company.create!(name: "Boeing")
    company.jobs.create!(title: "Developer", level_of_interest: 4, city: "Denver")
    company.jobs.create!(title: "QA Analyst", level_of_interest: 3, city: "New York City")
    company_2.jobs.create!(title: "Aeronautical Engineer", level_of_interest: 3, city: "Salt Lake City")

    visit jobs_path

    expect(page).to have_content("ESPN")
    expect(page).to have_content("Boeing")
    expect(page).to have_content("Developer")
    expect(page).to have_content("QA Analyst")
    expect(page).to have_content("Aeronautical Engineer")
    expect(page).to have_content("Denver")
    expect(page).to have_content("New York City")
    expect(page).to have_content("Salt Lake City")

  end
  scenario "a user sees all the jobs for a specific company" do
    company = Company.create!(name: "ESPN")
    company.jobs.create!(title: "Developer", level_of_interest: 3, city: "Denver")
    company.jobs.create!(title: "QA Analyst", level_of_interest: 4, city: "New York City")

    visit company_jobs_path(company)

    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
    expect(page).to have_content("QA Analyst")
  end
end
