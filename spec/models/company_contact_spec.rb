require 'rails_helper'

describe CompanyContact, type: :model do
  describe 'validations' do
    context 'invalid attributes' do
      it 'is invalid with a missing field' do
        company = Company.create!(name: "Turing")
        contact = company.company_contacts.new(position: "Lawyer", email: "email@email.com")
        expect(contact).to be_invalid
      end
    end
    context 'valid attributes' do
      it 'is valid with all attributes' do
        company = Company.create!(name: "Turing")
        contact = company.company_contacts.new(name: "Bill", position: "Lawyer", email: "email@email.com")
        expect(contact).to be_valid
      end
    end
    describe "relationships" do
      it "belongs to a company" do
        company = Company.create!(name: "Turing")
        contact = company.company_contacts.new(name: "Bill", position: "Lawyer", email: "email@email.com")
        expect(contact).to respond_to(:company)
      end
    end
  end
end
