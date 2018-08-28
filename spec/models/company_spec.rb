require 'rails_helper'

describe Company do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a name" do
        company = Company.new()
        expect(company).to be_invalid
      end

      it "has a unique name" do
        Company.create(name: "Dropbox")
        company = Company.new(name: "Dropbox")
        expect(company).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a name" do
        company = Company.new(name: "Dropbox")
        expect(company).to be_valid
      end
    end
  end

  describe "relationships" do
    it "has many jobs" do
      company = Company.new(name: "Dropbox")
      expect(company).to respond_to(:jobs)
    end
  end

  describe 'methods' do
    it '.top_companies_by_interest' do
      category  = Category.create(title: "A category")
      company   = Company.create(name: "Google")
      company_2 = Company.create(name: "Microsoft")
      company_3 = Company.create(name: "Twitter")
      company.jobs.create(title: "Title 1", level_of_interest: 3, city: "Denver", category: category)
      company.jobs.create(title: "Title 2", level_of_interest: 5, city: "Denver", category: category)
      company_2.jobs.create(title: "Title 1", level_of_interest: 2, city: "Denver", category: category)
      company_2.jobs.create(title: "Title 2", level_of_interest: 4, city: "Denver", category: category)
      company_3.jobs.create(title: "Title 1", level_of_interest: 1, city: "Denver", category: category)
      company_3.jobs.create(title: "Title 2", level_of_interest: 3, city: "Denver", category: category)

      expect(Company.top_companies_by_interest).to eq({company.name => 4, company_2.name => 3, company_3.name => 2 })
    end
  end
end
