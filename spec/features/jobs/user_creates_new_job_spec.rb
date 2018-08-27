require 'rails_helper'

describe "User creates a new job" do
  scenario "a user can create a new job" do
    company = Company.create!(name: "ESPN")
    company_2 = Company.create!(name: "CNN")
    category = Category.create!(title: "Software Development")
    category_2 = Category.create!(title: "Database Manager")
    visit new_company_job_path(company)

    find('#job_company_id').find(:option, company_2.name).select_option
    find('#job_category_id').find(:option, category_2.title).select_option
    fill_in "job[title]", with: "Developer"
    fill_in "job[description]", with: "So fun!"
    fill_in "job[level_of_interest]", with: 80
    fill_in "job[city]", with: "Denver"

    click_button "Create"

    expect(current_path).to eq(job_path(Job.last.id))
    expect(page).to have_content("CNN")
    expect(page).to have_content("Developer")
    expect(page).to have_content("80")
    expect(page).to have_content("Denver")
  end
end
