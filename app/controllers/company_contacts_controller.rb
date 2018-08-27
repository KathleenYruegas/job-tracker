class CompanyContactsController < ApplicationController

  def create
    @company = Company.find(params[:company_id])
    @company_contact = @company.company_contacts.create!(company_contact_params)
    if @company_contact.save
      flash[:success] = "#{@company_contact.name} added to contacts!"
      redirect_to company_path(@company_contact.company)
    else
      flash[:failure] = "Failed to add company contact."
      redirect_to company_path(@company_contact.company)
    end
  end

  private

  def company_contact_params
    params.require(:company_contact).permit(:name, :position, :email)
  end

end
