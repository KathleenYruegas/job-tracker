require 'rails_helper'

describe Job do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a title" do
        job = Job.new(level_of_interest: 80, description: "Wahoo", city: "Denver")
        expect(job).to be_invalid
      end

      it "is invalid without a level of interest" do
        job = Job.new(title: "Developer", description: "Wahoo", city: "Denver")
        expect(job).to be_invalid
      end

      it "is invalid without a city" do
        job = Job.new(title: "Developer", description: "Wahoo", level_of_interest: 80)
        expect(job).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a title, level of interest, category, and company" do
        company = Company.new(name: "Turing")
        category = Category.new(title: "Feature Testing")
        job = Job.new(title: "Developer", level_of_interest: 40, city: "Denver", company: company, category: category)
        expect(job).to be_valid
      end
    end
  end

  describe "relationships" do
    it "belongs to a company" do
      job = Job.new(title: "Software", level_of_interest: 70, description: "Wahooo")
      expect(job).to respond_to(:company)
    end

    it "belongs to a category" do
      job = Job.new(title: "Software", level_of_interest: 70, description: "Wahooo")
      expect(job).to respond_to(:category)
    end

    it "has many job_comments" do
      job = Job.new(title: "Software", level_of_interest: 70, description: "Wahooo")
      expect(job).to respond_to(:job_comments)
    end
  end
  describe "methods" do
    it "can return an array of unique cities" do
      company = Company.new(name: "Turing")
      category = Category.new(title: "Feature Testing")
      job = Job.create(title: "Developer", level_of_interest: 40, city: "Denver", company: company, category: category)
      job = Job.create(title: "Developer", level_of_interest: 40, city: "Denver", company: company, category: category)
      job = Job.create(title: "Developer", level_of_interest: 40, city: "Boulder", company: company, category: category)
      job = Job.create(title: "Developer", level_of_interest: 40, city: "Boulder", company: company, category: category)
      job = Job.create(title: "Developer", level_of_interest: 40, city: "Chicago", company: company, category: category)
      expect(Job.get_cities).to eq(["Chicago", "Boulder", "Denver"])
    end
    it "can return a count of each city" do
      company = Company.new(name: "Turing")
      category = Category.new(title: "Feature Testing")
      job = Job.create(title: "Developer", level_of_interest: 40, city: "Denver", company: company, category: category)
      job = Job.create(title: "Developer", level_of_interest: 40, city: "Denver", company: company, category: category)
      job = Job.create(title: "Developer", level_of_interest: 40, city: "Chicago", company: company, category: category)
      expect(Job.count_city("Denver")).to eq 2
      expect(Job.count_city("Chicago")).to eq 1
    end
  end
end
