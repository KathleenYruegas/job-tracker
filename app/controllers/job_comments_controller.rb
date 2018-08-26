class JobCommentsController < ApplicationController
  def create
    @job_comment = JobComment.new(job_comment_params)
    if @job_comment.save
      flash[:success] = "Comment posted!"
      redirect_to job_path(params[:job_comment][:job_id])
    else
      flash[:failure] = "Comment failed to post."
      redirect_to job_path(params[:job_comment][:job_id])
    end
  end

  private

  def job_comment_params
    params.require(:job_comment).permit(:content, :job_id)
  end
end
