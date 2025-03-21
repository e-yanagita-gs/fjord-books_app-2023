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

  test 'created_on' do
    assert_equal Time.zone.today, @alice_report.created_on
  end

  test 'save_mentions' do
    bob_report = @bob.reports.build(title: 'MentioningReport', content: "http://localhost:3000/reports/#{@alice_report.id}")
    assert_empty bob_report.mentioning_reports
    bob_report.save!
    assert_includes bob_report.mentioning_reports, @alice_report
  end
end
