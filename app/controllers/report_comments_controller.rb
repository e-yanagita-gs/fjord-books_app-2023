# frozen_string_literal: true

class ReportCommentsController < ApplicationController
  before_action :set_report

  def create
    @comment = @report.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @report, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      flash.now[:alert] = t('views.common.error')
      render 'reports/show'
    end
  end

  def destroy
    @report.comments.find(params[:id]).destroy!
    redirect_to @report
  end

  private

  def set_report
    @report = Report.find(params[:report_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
