class JobsController < ApplicationController
  def index
    if params[:company_id]
      @company = Company.find(params[:company_id])
      @jobs = @company.jobs
      @title = @company.name
    elsif params[:sort] = location
      @jobs = Job.sort_by_location
      @title = "#{params[:sort]}"
    else
      @jobs = Job.all
      @title = "All"
    end
  end

  def new
    @categories = Category.all
    @companies = Company.all
    @job = Job.new()
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      flash[:success] = "You created a new job!"
      redirect_to job_path(@job)
    else
      render :new
    end
  end

  def show
    @job = Job.find(params[:id])
    @job_comment = @job.job_comments.new
    @comments = JobComment.where(job_id: @job.id).order(updated_at: :desc)
  end

  def edit
    @job = Job.find(params[:id])
    @company = Company.find(params[:company_id])
    @categories = Category.all
    @companies = Company.all
  end

  def update
    @job = Job.find(params[:id])
    @job.update(job_params)
    @company = Company.find(@job.company_id)
    flash[:success] = "You updated #{@job.title} at #{@company.name}"
    redirect_to company_job_path(@company, @job)
  end

  def destroy
    job = Job.find(params[:id])
    title = job.title
    job.delete
    flash[:success] = "#{title} was successfully deleted!"
    redirect_to jobs_path
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :level_of_interest, :city, :company_id, :category_id)
  end
end
