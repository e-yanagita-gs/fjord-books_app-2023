# frozen_string_literal: true

class Mention < ApplicationRecord
  belongs_to :mentioner, class_name: 'Report'
  belongs_to :mentionee, class_name: 'Report'

  validates :mentioner_id, presence: true
  validates :mentionee_id, presence: true
  validates :mentioner_id, uniqueness: { scope: :mentionee_id }
end
