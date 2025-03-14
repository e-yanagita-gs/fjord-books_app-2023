# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'editable?' do
    user = User.new(name: 'Alice')
    report = Report.new(user: user)

    target_user = report.user
    assert report.editable?(user)
  end
end
