require "rails_helper"

describe "User visits /jobs?sort=location" do
  it "should show all jobs sorted by location" do
    category_1 = Category.create!(title: "Testing")
    category_2 = Category.create!(title: "Dev")
    company_1 = Company.create!(name: "Google")
    company_2 = Company.create!(name: "Turing")
    job_1 = company_1.jobs.create!(title: "Software Developer",
                                  description: "Do Stuff",
                                  level_of_interest: 3,
                                  city: "Denver",
                                  category_id: category_1.id)
    job_2 = company_2.jobs.create!(title: "Testing Developer",
                                  description: "Test Stuff",
                                  level_of_interest: 4,
                                  city: "San Fran",
                                  category_id: category_1.id)
    job_3 = company_2.jobs.create!(title: "Noob",
                                  description: "Learn",
                                  level_of_interest: 5,
                                  city: "Zandiego",
                                  category_id: category_1.id)
    job_4 = company_2.jobs.create!(title: "Testing Developer",
                                  description: "Test Stuff",
                                  level_of_interest: 4,
                                  city: "Denver",
                                  category_id: category_1.id)

    visit '/jobs?sort=location'

    within("#1") do
      expect(page).to have_content("Denver")
    end

    within("#2") do
      expect(page).to have_content("Denver")
    end

    within("#3") do
      expect(page).to have_content("San Fran")
    end

    within("#4") do
      expect(page).to have_content("Zandiego")
    end
  end
end
