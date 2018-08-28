require 'rails_helper'

describe "User creates company contact" do
  context "on a company show page" do
    it "user fills out the form to create a company contact" do
      company = Company.create!(name: "Turing")
      category = Category.create!(title: "Testing")
      company.jobs.create!(title: "Web Developer", company: company, level_of_interest: 5, description: "Wahoo", city: "Denver", category: category)

      visit company_path(company)

      within ".new_contact_form" do
        fill_in "company_contact[name]", with: "Bill Nye"
        fill_in "company_contact[position]", with: "Science Guy"
        fill_in "company_contact[email]", with: "BillNyeTheScienceGuy@science.org"
        click_button "Save"
      end

      expect(page).to have_content("Bill Nye")
      expect(page).to have_content("Science Guy")
      expect(page).to have_content("BillNyeTheScienceGuy@science.org")
    end

    it 'has edit and delete functions for company' do
      company = Company.create!(name: "Turing")

      visit company_path(company)

      click_link("Edit")
      expect(current_path).to eq(edit_company_path(company))

      visit company_path(company)

      click_link("Delete")
      expect(current_path).to eq(companies_path)
      expect(page).to_not have_css(".company_#{company.id}")
    end
  end
end
