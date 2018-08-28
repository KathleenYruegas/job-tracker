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
        job = Job.new(title: "Developer", description: "Wahoo", level_of_interest: 5)
        expect(job).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a title, level of interest, category, and company" do
        company = Company.new(name: "Turing")
        category = Category.new(title: "Feature Testing")
        job = Job.new(title: "Developer", level_of_interest: 4, city: "Denver", company: company, category: category)
        expect(job).to be_valid
      end
    end
  end

  describe "relationships" do
    it "belongs to a company" do
      job = Job.new(title: "Software", level_of_interest: 5, description: "Wahooo")
      expect(job).to respond_to(:company)
    end

    it "belongs to a category" do
      job = Job.new(title: "Software", level_of_interest: 5, description: "Wahooo")
      expect(job).to respond_to(:category)
    end

    it "has many job_comments" do
      job = Job.new(title: "Software", level_of_interest: 5, description: "Wahooo")
      expect(job).to respond_to(:job_comments)
    end
  end

  describe "Class Methods" do
    it ".sort_by_location" do
      category_1 = Category.create!(title: "Testing")
      category_2 = Category.create!(title: "Dev")
      company_1 = Company.create!(name: "Google")
      company_2 = Company.create!(name: "Turing")
      job_1 = company_1.jobs.create!(title: "Software Developer",
                                    description: "Do Stuff",
                                    level_of_interest: 3,
                                    city: "Denver",
                                    category_id: category_1.id)
      job_2 = company_2.jobs.create!(title: "Testing Developer",
                                    description: "Test Stuff",
                                    level_of_interest: 4,
                                    city: "San Fran",
                                    category_id: category_1.id)
      job_3 = company_2.jobs.create!(title: "Testing Developer",
                                    description: "Test Stuff",
                                    level_of_interest: 4,
                                    city: "Denver",
                                    category_id: category_1.id)
      job_4 = company_2.jobs.create!(title: "Testing Developer",
                                    description: "Test Stuff",
                                    level_of_interest: 4,
                                    city: "Acity",
                                    category_id: category_1.id)

      sorted = [job_4, job_1, job_3, job_2]

      expect(Job.sort_by_location).to eq(sorted)
    end

    it ".get_cities" do
      company = Company.new(name: "Turing")
      category = Category.new(title: "Feature Testing")
      Job.create(title: "Developer", level_of_interest: 4, city: "Denver", company: company, category: category)
      Job.create(title: "Developer", level_of_interest: 4, city: "Denver", company: company, category: category)
      Job.create(title: "Developer", level_of_interest: 4, city: "Boulder", company: company, category: category)
      Job.create(title: "Developer", level_of_interest: 4, city: "Boulder", company: company, category: category)
      Job.create(title: "Developer", level_of_interest: 4, city: "Chicago", company: company, category: category)

      expect(Job.get_cities).to eq(["Chicago", "Boulder", "Denver"])
    end

    it '.count_city' do
      company = Company.new(name: "Turing")
      category = Category.new(title: "Feature Testing")
      Job.create(title: "Developer", level_of_interest: 4, city: "Denver", company: company, category: category)
      Job.create(title: "Developer", level_of_interest: 4, city: "Denver", company: company, category: category)
      Job.create(title: "Developer", level_of_interest: 4, city: "Chicago", company: company, category: category)

      expect(Job.count_city("Denver")).to eq 2
      expect(Job.count_city("Chicago")).to eq 1
    end

    it '.interest_count' do
      company = Company.new(name: "Turing")
      category = Category.new(title: "Feature Testing")
      Job.create(title: "Developer", level_of_interest: 3, city: "Denver", company: company, category: category)
      Job.create(title: "Developer", level_of_interest: 4, city: "Denver", company: company, category: category)
      Job.create(title: "Developer", level_of_interest: 3, city: "Boulder", company: company, category: category)
      Job.create(title: "Developer", level_of_interest: 4, city: "Boulder", company: company, category: category)
      Job.create(title: "Developer", level_of_interest: 5, city: "Chicago", company: company, category: category)

      expect(Job.interest_count).to eq({5 => 1, 4 => 2, 3 => 2})
    end

    it '.sort_by_interest' do
      company = Company.create(name: "Turing")
      category = Category.new(title: "Feature Testing")
      job_1 = company.jobs.create(title: "Developer", level_of_interest: 3, city: "Denver", category: category)
      job_2 = Job.create(title: "Engineer", level_of_interest: 4, city: "Denver", company: company, category: category)
      job_3 = Job.create(title: "Tester", level_of_interest: 3, city: "Boulder", company: company, category: category)
      job_4 = Job.create(title: "DBA", level_of_interest: 4, city: "Boulder", company: company, category: category)
      job_5 = Job.create(title: "Developer", level_of_interest: 5, city: "Chicago", company: company, category: category)

      expected = [job_5, job_4, job_2, job_1, job_3]
      expect(Job.sort_by_interest).to eq(expected)
    end
  end
end
