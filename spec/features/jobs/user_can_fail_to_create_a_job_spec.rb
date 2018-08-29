require 'rails_helper'

describe "User fails to creates a new job" do
  scenario "a user fills in invalid info and fails to create job" do
    company = Company.create(name: "ESPN")
    company_2 = Company.create(name: "CNN")
    category = Category.create(title: "Software Development")
    category_2 = Category.create(title: "Database Manager")
    visit new_job_path
    find('#job_company_id').find(:option, company_2.name).select_option
    find('#job_category_id').find(:option, category_2.title).select_option
    fill_in "job[title]", with: ""
    fill_in "job[description]", with: "So fun!"
    fill_in "job[level_of_interest]", with: 3
    fill_in "job[city]", with: "Denver"

    click_button "Create"

    expect(page).to have_content("Error: Job creation failed.")
    expect(current_path).to eq(jobs_path)
    expect(Job.all.count).to eq(0)
  end
end
