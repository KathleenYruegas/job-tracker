require "rails_helper"

describe "User visits category show page" do
  it "should show all jobs for that category" do
    category_1 = Category.create!(title: "Testing")
    category_2 = Category.create!(title: "Dev")
    company_1 = Company.create!(name: "Google")
    company_2 = Company.create!(name: "Turing")
    job_1 = company_1.jobs.create!(title: "Software Developer",
                                  description: "Do Stuff",
                                  level_of_interest: 3,
                                  city: "Denver"
                                  category_id: category_1.id)
    job_2 = company_2.jobs.create!(title: "Testing Developer",
                                  description: "Test Stuff",
                                  level_of_interest: 4,
                                  city: "San Fran"
                                  category_id: category_1.id)

    visit categories_path

    click_on("category_1.title")
    expect(current_path).to eq(category_path(category_1))
    expect(page).to have_content(job_1.title)
    expect(page).to have_content(job_2.title)
  end
end
