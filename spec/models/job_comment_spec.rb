require 'rails_helper'

describe JobComment, type: :model do
  describe "validations" do
    context 'valid attributes' do
      it "is valid with content" do
        company = Company.create!(name: "Turing")
        job = Job.create!(title: "Title", company: company, level_of_interest: 5, description: "Wahoo", city: "Denver")
        comment = job.job_comments.create!(content: "This is an example")
        expect(comment).to be_valid
      end
    end
    context "invalid attributes" do
      it "is invalid without content" do
        comment = JobComment.create()
        expect(comment).to be_invalid
      end
    end
    it "belongs to a company" do
      job = Job.new(title: "Software", level_of_interest: 70, description: "Wahooo")
      expect(job).to respond_to(:company)
    end
  end
end
