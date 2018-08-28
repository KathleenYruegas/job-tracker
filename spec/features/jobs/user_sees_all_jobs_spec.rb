require 'rails_helper'

describe "User sees all jobs" do
  scenario 'user can see all jobs' do
    company = Company.create!(name: "ESPN")
    company_2 = Company.create!(name: "Boeing")
    category_1 = Category.create!(title: "Smart Stuff")
    category_2 = Category.create!(title: "Engineering")
    company.jobs.create!(title: "Developer", level_of_interest: 4, city: "Denver", category_id: category_1.id)
    company.jobs.create!(title: "QA Analyst", level_of_interest: 3, city: "New York City", category_id: category_1.id)
    company_2.jobs.create!(title: "Aeronautical Engineer", level_of_interest: 3, city: "Salt Lake City", category_id: category_2.id)

    visit jobs_path

    expect(page).to have_content("ESPN")
    expect(page).to have_content("Boeing")
    expect(page).to have_content("Developer")
    expect(page).to have_content("QA Analyst")
    expect(page).to have_content("Aeronautical Engineer")
    expect(page).to have_content("Denver")
    expect(page).to have_content("New York City")
    expect(page).to have_content("Salt Lake City")
    expect(page).to have_link("Add New Job")

  end
  scenario "a user sees all the jobs for a specific company" do
    company = Company.create!(name: "ESPN")
    category_1 = Category.create!(title: "Smart Stuff")
    company.jobs.create!(title: "Developer", level_of_interest: 3, city: "Denver", category_id: category_1.id)
    company.jobs.create!(title: "QA Analyst", level_of_interest: 4, city: "New York City", category_id: category_1.id)

    visit company_jobs_path(company)

    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
    expect(page).to have_content("QA Analyst")
  end

  it "has links to all jobs, companies, and cities" do
    company_1 = Company.create!(name: "ESPN")
    company_2 = Company.create!(name: "CNN")
    category_1 = Category.create!(title: "Smart Stuff")
    job_1 = company_1.jobs.create!(title: "Developer", level_of_interest: 3, city: "Denver", category_id: category_1.id)
    job_2 = company_2.jobs.create!(title: "QA Analyst", level_of_interest: 4, city: "New York City", category_id: category_1.id)

    visit jobs_path
    click_link(job_1.title)
    expect(current_path).to eq(job_path(job_1))

    visit jobs_path
    click_link(company_1.name)
    expect(current_path).to eq(company_path(company_1))

    visit jobs_path
    click_link(job_2.city)
    expect(current_path).to eq(jobs_path)
    expect(page).to have_content(job_2.city)
  end
end
