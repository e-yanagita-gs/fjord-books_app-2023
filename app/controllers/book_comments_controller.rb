# frozen_string_literal: true

class BookCommentsController < ApplicationController
  before_action :set_book

  def create
    @comment = @book.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @book, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      flash.now[:alert] = t('views.common.error')
      render 'books/show'
    end
  end

  def destroy
    @book.comments.find(params[:id]).destroy!
    redirect_to @book
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
