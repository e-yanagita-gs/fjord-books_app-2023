# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar do |attachable|
    attachable.variant :small, resize_to_limit: [100, 100]
    attachable.variant :large, resize_to_limit: [150, 150]
  end
#  validate :avatar_type
  validates :avatar, blob: { content_type: ['image/png', 'image/gif', 'image/jpeg'], }

  private

=begin
  def avatar_type
    return unless avatar.attached? && !avatar.blob.content_type.in?(%('image/jpeg image/png image/gif'))

    avatar.purge
    errors.add(:avatar, 'はjpgまたはpngまたはgif形式でアップロードしてください')
  end
=end
end
