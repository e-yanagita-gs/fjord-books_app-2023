class AddUserIdToReports < ActiveRecord::Migration[7.0]
  def change
    add_references :reports, :user, foreign_key: true
  end
end
