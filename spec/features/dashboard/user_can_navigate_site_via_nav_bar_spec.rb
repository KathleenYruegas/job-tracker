require 'rails_helper'

describe 'user can navigate site with nav bar' do
  describe 'a user clicks through the nav bar' do
    it 'should take the user to the proper pages' do
      visit '/'

      within(".navbar") do
        click_link "Categories"
      end
      expect(current_path).to eq ("/categories")

      within(".navbar") do
        click_link "Companies"
      end
      expect(current_path).to eq ("/companies")

      within(".navbar") do
        click_link "Jobs"
      end
      expect(current_path).to eq ("/jobs")

      within(".navbar") do
        click_link "Dashboard"
      end
      expect(current_path).to eq ("/dashboard")

    end
  end
end
