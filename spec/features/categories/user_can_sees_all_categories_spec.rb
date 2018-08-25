require "rails_helper"

describe "User sees all categories" do
  it "should display all categories" do
    category_1 = Category.create!(title: "Developer")
    category_2 = Category.create!(title: "Database Person")
    category_3 = Category.create!(title: "Tester")

    visit categories_path

    expect(page).to have_content(category_1.title)
    expect(page).to have_content(category_2.title)
    expect(page).to have_content(category_3.title)
  end
end
