require 'rails_helper'

describe 'User sees all job comments' do
  scenario 'for a particular job' do
    company = Company.create!(name: "Turing")
    category = Category.create!(title: "Research")
    job = Job.create!(title: "Title", company: company, level_of_interest: 5, description: "Wahoo", city: "Denver", category_id: category.id)
    comment = job.job_comments.create!(content: "This is an example")
    comment_2 = job.job_comments.create!(content: "Penelope Cruz")

    visit job_path(job)

    expect(page).to have_content(comment.content)
    expect(page).to have_content(comment.updated_at)
    expect(page).to have_content(comment_2.content)
    expect(page).to have_content(comment_2.updated_at)

  end
end
