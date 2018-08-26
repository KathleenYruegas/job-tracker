require 'rails_helper'

describe 'User can add a job comment' do
  describe 'on a job page' do
    describe 'fills in the comment box and clicks submit' do
      it 'should create a job comment and show it on that jobs page' do
        company = Company.create!(name: "Turing")
        category = Category.create!(title:"Category")
        job = Job.create!(title: "Title", company: company, category: category, level_of_interest: 5, description: "Wahoo", city: "Denver")

        visit job_path(job)
        within(".comment_box") do
          fill_in "job_comment[content]", with: "My experience at Turing has
                                                 been exceptionally pleasant, I
                                                 have learned so much!"
        end
        click_button "Save"

        expect(current_path).to eq("/jobs/#{job.id}")
        expect(page).to have_content("My experience at Turing has
                                               been exceptionally pleasant, I
                                               have learned so much!")
      end
    end
  end
end
