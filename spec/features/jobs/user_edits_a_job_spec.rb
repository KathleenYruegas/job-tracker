require 'rails_helper'

describe "User edits a job" do
  scenario "a user can edit a job" do
    company = Company.create!(name: "ESPN")
    company_2 = Company.create!(name: "CNN")
    category = Category.create!(title: "Software Development")
    category_2 = Category.create!(title: "Database Manager")
    job = company.jobs.create!(title: "Web Developer",
                               description: "Develop the Web",
                               city: "Denver",
                               level_of_interest: "4",
                               category_id: category.id)
    visit edit_company_job_path(company, job)

    select category_2.title, from: 'category'
    select company_2.name, from: 'company'
    fill_in "job[title]", with: "New title!"
    fill_in "job[description]", with: "New desc"
    fill_in "job[level_of_interest]", with: 3
    fill_in "job[city]", with: "Chicago"

    click_button "Update"

    expect(current_path).to eq(company_job_path(job))
    expect(page).to have_content("New title!")
    expect(page).to have_content("New desc!")
    expect(page).to have_content("3")
    expect(page).to have_content("Chicago")
    expect(page).to have_content("CNN")
    expect(page).to have_content("Database Manager")
  end
end
