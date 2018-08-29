require 'rails_helper'

describe "User can fail to create a new company" do
  scenario "invalid parameters while creating a company causes a failure" do
    visit new_company_path

    fill_in "company[name]", with: ""
    click_button "Create"
    expect(current_path).to eq(companies_path)
    expect(page).to have_content("Invalid name, company not saved.")
    expect(Company.count).to eq(0)
  end
end
