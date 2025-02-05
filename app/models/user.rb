# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar do |attachable|
    attachable.variant :small, resize_to_limit: [100, 100]
    attachable.variant :large, resize_to_limit: [150, 150]
  end

  validates :avatar, blob: { content_type: ['image/png', 'image/gif', 'image/jpeg'] }

end
