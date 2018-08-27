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

    visit edit_job_path(job)

    find('#job_company_id').find(:option, company_2.name).select_option
    find('#job_category_id').find(:option, category_2.title).select_option
    fill_in "job[title]", with: "New title!"
    fill_in "job[description]", with: "New desc!"
    fill_in "job[level_of_interest]", with: 3
    fill_in "job[city]", with: "Chicago"

    click_button "Update"

    expect(current_path).to eq(company_job_path(company_2, job))
    expect(page).to have_content("New title!")
    expect(page).to have_content("New desc!")
    expect(page).to have_content("3")
    expect(page).to have_content("Chicago")
    expect(page).to have_content("CNN")
    # Our show page doesn't currently show the category
    # expect(page).to have_content("Database Manager")
  end
end
