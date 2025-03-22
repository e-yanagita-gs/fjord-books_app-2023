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
    created_time = Time.zone.local(2024, 3, 22, 10, 0, 0)
    report = Report.create!(
      created_at: created_time,
      user: @alice,
      title: @alice_report.title,
      content: @alice_report.content
    )
    assert_equal created_time.to_date, report.created_on
  end

  test 'save_mentions' do
    bob_report = @bob.reports.build(title: 'MentioningReport', content: "http://localhost:3000/reports/#{@alice_report.id}")
    assert_empty bob_report.mentioning_reports
    bob_report.save!
    assert_includes bob_report.mentioning_reports, @alice_report
  end
end
