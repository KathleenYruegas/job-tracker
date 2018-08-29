require 'rails_helper'

describe "User creates company contact" do
  context "on a company show page" do
    it "user fills out the form to create a company contact" do
      company = Company.create!(name: "Turing")
      category = Category.create!(title: "Testing")
      company.jobs.create!(title: "Web Developer", company: company, level_of_interest: 5, description: "Wahoo", city: "Denver", category: category)

      visit company_path(company)

      within ".new_contact_form" do
        fill_in "company_contact[name]", with: ""
        fill_in "company_contact[position]", with: ""
        fill_in "company_contact[email]", with: ""
        click_button "Save"
      end

      expect(current_path).to eq(company_path(company))
      expect(page).to have_content("Failed to add company contact")
    end
  end
end
