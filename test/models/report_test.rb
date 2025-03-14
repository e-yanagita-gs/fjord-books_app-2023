# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @alice = users(:alice)
    @bob = users(:bob)
    @alice_report = reports(:alice_report)
  end

  test 'editable?' do
    assert_equal true, @alice_report.editable?(@alice)
    assert_equal false, @alice_report.editable?(@bob)
  end
end
