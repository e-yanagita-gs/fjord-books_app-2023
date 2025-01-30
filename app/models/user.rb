# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  validate :avatar_type

  private

  def avatar_type
    return unless avatar.attached? && !avatar.blob.content_type.in?(%('image/jpeg image/png image/gif'))

    avatar.purge
    errors.add(User.human_attribute_name(:avatar), 'はjpegまたはpngまたはgif形式でアップロードしてください')
  end
end
