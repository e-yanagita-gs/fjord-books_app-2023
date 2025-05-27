# frozen_string_literal: true

class BookCommentsController < CommentsController
  private

  def set_resource
    @commentable = Book.find(params[:book_id])
  end

  def view_path
    'books'
  end
end
