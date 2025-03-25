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
    assert_equal Date.new(2024, 3, 22), report.created_on
  end

  test 'save_mentions' do
    bob_report = @bob.reports.build(title: 'MentioningReport', content: "http://localhost:3000/reports/#{@alice_report.id}")
    assert_empty bob_report.mentioning_reports
    bob_report.save!
    assert_includes bob_report.mentioning_reports, @alice_report

    alice_second_report = @alice.reports.create!(title: 'MentionedReport', content: 'This is a mentioned report.')
    bob_report.update!(content: "http://localhost:3000/reports/#{alice_second_report.id}")
    bob_report.mentioning_reports.reload
    assert_includes bob_report.mentioning_reports, alice_second_report
    assert_not_includes bob_report.mentioning_reports, @alice_report

    bob_report.destroy!
    bob_report.mentioning_reports.reload
    assert_empty bob_report.mentioning_reports
  end
end
