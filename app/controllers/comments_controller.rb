# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_resource
  before_action :set_comment, only: %i[destroy]
  before_action :authorize_user, only: %i[destroy]

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      flash.now[:alert] = t('views.common.error')
      render "#{view_path}/show"
    end
  end

  def destroy
    @comment.destroy!
    redirect_to @commentable
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_comment
    @comment = @commentable.comments.find(params[:id])
  end

  def authorize_user
    redirect_to root_path, alert: t('controllers.common.unauthorized_access') unless @comment.user == current_user
  end
end
