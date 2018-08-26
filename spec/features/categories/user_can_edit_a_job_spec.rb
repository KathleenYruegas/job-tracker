require "rails_helper"

describe "User can edit a category" do
  it "should edit the category from index" do
    category_1 = Category.create!(title: "Testing")
    category_2 = Category.create!(title: "Development")

    visit categories_path

    within("#category_#{category_1.id}") do
      click_on("Edit")
    end

    expect(current_path).to eq(category_path(category_1))
    fill_in("category[title]", with: "Junior Dev")
    click_on("Update")

    expect(current_path).to eq(category_path(category_1))
    within(".title") do
      expect(page).to_not have_content("Testing")
      expect(page).to have_content("Junior Dev")
    end
    expect(page).to have_content("Your category was updated!")
  end
end
