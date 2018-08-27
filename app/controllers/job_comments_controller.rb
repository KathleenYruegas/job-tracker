class JobCommentsController < ApplicationController
  def create
    @job = Job.find(params[:job_id])
    @job_comment = @job.job_comments.create(job_comment_params)
    if @job_comment.save
      flash[:success] = "Comment posted!"
      redirect_to job_path(params[:job_id])
    else
      flash[:failure] = "Comment failed to post."
      redirect_to job_path(params[:job_id])
    end
  end

  private

  def job_comment_params
    params.require(:job_comment).permit(:content)
  end
end
