class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      flash[:success] = "#{@company.name} added!"
      redirect_to company_jobs_path(@company)
    else
      flash[:failure] = "Invalid name, company not saved."
      render :new
    end
  end

  def show
    @company = Company.find(params[:id])
    @company_contact = @company.company_contacts.new
    @contacts = CompanyContact.all
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    @company.update(company_params)
    if @company.save
      flash[:success] = "#{@company.name} updated!"
      redirect_to company_path(@company)
    else
      flash[:failure] = "Invalid name, changes not saved."
      render :edit
    end
  end

  def destroy
    company = Company.find(params[:id])
    company.destroy

    flash[:success] = "#{company.name} was successfully deleted!"
    redirect_to companies_path
  end


  private

  def company_params
    params.require(:company).permit(:name, :city)
  end

end
