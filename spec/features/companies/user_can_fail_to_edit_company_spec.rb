require 'rails_helper'

describe "User can fail to edit a company" do
  scenario "invalid parameters while editing a company causes a failure" do
    company = Company.create(name: "My company")
    visit edit_company_path(company)

    fill_in "company[name]", with: ""
    click_button "Update Company"
    expect(current_path).to eq(company_path(company))
    expect(page).to have_content("Invalid name, changes not saved.")
  end
end
