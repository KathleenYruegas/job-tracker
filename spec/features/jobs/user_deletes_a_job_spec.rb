require 'rails_helper'

describe "User deletes a job" do
  scenario "a user can delete a job" do
    company = Company.create(name: "ESPN")
    category = Category.create!(title: "Software Development")
    job = company.jobs.create(title: "Web Developer",
                               description: "Develop the Web",
                               city: "Denver",
                               level_of_interest: "4",
                               category_id: category.id)
    visit company_jobs_path(company)
    save_and_open_page

    within(".company_job_#{job.id}") do
      click_link "Delete"
    end

    expect(page).to have_content("Web Developer was successfully deleted!")
  end
end
