require "rails_helper"

describe "A user can create a new category" do
  it "should create a new category" do

    visit new_category_path

    fill_in("category[title]", with: "Testing")
    click_button("Create")

    expect(current_path).to eq(category_path(Category.last))
    expect(page).to have_content("Testing")
  end

  it "should not let user duplicate a category name" do
    category_1 = Category.create!(title: "Dev")

    visit new_category_path

    fill_in("category[title]", with: "Dev")
    click_button("Create")
    expect(current_path).to eq(new_category_path)
    expect(page).to have_content("Sorry, this category name already exists!")
  end
end
