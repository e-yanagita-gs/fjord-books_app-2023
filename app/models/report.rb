# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :active_mentions, class_name: 'Mention', foreign_key: 'mentioner_id', dependent: :destroy, inverse_of: :mentioner
  has_many :mentioning_reports, through: :active_mentions, source: :mentionee
  has_many :passive_mentions, class_name: 'Mention', foreign_key: 'mentionee_id', dependent: :destroy, inverse_of: :mentionee
  has_many :mentioned_reports, through: :passive_mentions, source: :mentioner

  validates :title, presence: true
  validates :content, presence: true

  after_save :update_mentions

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  private

  def update_mentions
    mentioned_report_ids = extract_mentioned_report_ids
    return if mentioned_report_ids.empty?

    active_mentions.destroy_all
    mentioned_report_ids.each do |id|
      active_mentions.create(mentionee_id: id)
    end
  end

  def extract_mentioned_report_ids
    content.scan(%r{http://localhost:3000/reports/(\d+)}).flatten.map(&:to_i).uniq
  end
end
