# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_resource

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
    @commentable.comments.find(params[:id]).destroy!
    redirect_to @commentable
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
