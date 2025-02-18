# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable, only: %i[create destroy]

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human) }
      else
        format.html { redirect_to @commentable, notice: t('views.common.error') }
      end
    end
  end

  def destroy
    @commentable.comments.find(params[:id]).destroy
    redirect_to @commentable
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def set_commentable
    if params[:report_id]
      @commentable = Report.find(params[:report_id])
    elsif params[:book_id]
      @commentable = Book.find(params[:book_id])
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
