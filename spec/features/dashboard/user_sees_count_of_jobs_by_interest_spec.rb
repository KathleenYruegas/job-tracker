require "rails_helper"

describe "As a user" do
  describe "visits dashboard" do
    it "should show job count by level of interest" do
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
                                    category_id: category_2.id)
      job_3 = company_2.jobs.create!(title: "Junior Dev",
                                    description: "Learn Stuff",
                                    level_of_interest: 1,
                                    city: "Amsterdam",
                                    category_id: category_2.id)
      job_4 = company_1.jobs.create!(title: "Software Manager",
                                    description: "Manage Stuff",
                                    level_of_interest: 3,
                                    city: "Los Angeles",
                                    category_id: category_1.id)


      visit dashboard_path

      within("#4-stars") do
        expect(page).to have_content("1 Job")
      end

      within("#3-stars") do
        expect(page).to have_content("2 Job")
      end

      expect(page).to_not have_css("#5-stars")
    end
  end
end
