require "rails_helper"

describe "A user can create a new category" do
  it "should create a category's " do

    visit new_category_path

    fill_in("category[title]", with: "Testing")
    click_button("Create")

    expect(current_path).to eq(category_path(Company.last.id))
    expect(page).to have_content("Testing")
  end
end
