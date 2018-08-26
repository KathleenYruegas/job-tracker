require "rails_helper"

describe "User visits category index page" do
  it "should delete a category" do
    category_1 = Category.create!(title: "Testing")
    category_2 = Category.create!(title: "Dev")
    category_3 = Category.create(title: "DBA")
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

    visit categories_path

    within("#category_#{category_3.id}") do
      click_on("Delete")
    end

    expect(current_path).to eq(categories_path)
    expect(page).to_not have_content(category_3.title)

    within("#category_#{category_1.id}") do
      click_on("Delete")
    end

    expect(current_path).to eq(categories_path)
    expect(page).to have_content("Category can't be deleted while it contains jobs.")
    expect(page).to have_content(category_1.title)
  end
end
