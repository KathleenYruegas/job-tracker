require 'rails_helper'

describe "User creates company contact" do
  context "on a company show page" do
    it "user fills out the form to create a company contact" do
      company = Company.create!(name: "Turing")
      company.jobs.create!(title: "Title", company: company, level_of_interest: 5, description: "Wahoo", city: "Denver")
      visit company_path(company)
      save_and_open_page
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
  end
end
