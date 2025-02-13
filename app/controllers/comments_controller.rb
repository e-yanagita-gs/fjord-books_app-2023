class CommentsController < ApplicationController
  before_action :set_commentable, only: %i[create destroy]

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    if comment.save
      redirect_to @commentable, notice: 'Success'
    else
      redirect_to @commentable, alert: 'Failed'
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

=begin
  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
      end
    end
    nil
  end
=end
end
