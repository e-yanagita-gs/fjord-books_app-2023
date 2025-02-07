class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  def create
#    @commentable = find_commentable
#    @comment = current_user.reports.build(comment_params)
    @comment = current_user.reports
    @comment.user = current_user
    respond_to do |format|
    if @comment.save
#      format.html { redirect_to @comment.commentable, notice: t('controllers.common.notice_create', name: Report.model_name.human) }
      redirect_to @report, notice: 'Success'
    else
#      format.html { redirect_to @comment.commentable, notice: t('controllers.common.notice_create', name: Report.model_name.human) }
      redirect_to @report, alert: 'Failed'
    end
  end

  def update
    @comment = current_user.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment.commentable, notice: t('controllers.common.notice_update', name: Comment.model_name.human) }
      else
        format.html { redirect_to @comment.commentable, notice: t('controllers.common.notice_update', name: Comment.model_name.human) }
      end
    end
  end

  def destroy
    @comment = current_user.find(params[:id])
    respond_to do |format|
      @comment.destroy
        format.html { redirect_to @comment.commentable, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human) }
    end
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

#  def comment_params
#    params.require(:comment).permit(:body).merge(user_id: current_user.id)
3  end

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
