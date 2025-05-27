# frozen_string_literal: true

class ReportCommentsController < CommentsController
  private

  def set_resource
    @commentable = Report.find(params[:report_id])
  end

  def view_path
    'reports'
  end
end
