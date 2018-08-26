class CompanyContactsController < ApplicationController

  def create
    @company_contact = CompanyContact.new(company_contact_params)
    if @company_contact.save
      flash[:success] = "#{@company_contact.name} added to contacts!"
      redirect_to company_path(@company_contact.company_id)
    else
      flash[:failure] = "Failed to add company contact."
      redirect_to company_path(@company_contact.company_id)
    end
  end

  private

  def company_contact_params
    params.require(:company_contact).permit(:name, :position, :email, :company_id)
  end

end
