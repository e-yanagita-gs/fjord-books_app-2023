# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :store_current_avatar, only: [:update]

  def update
    super do |user|
      restore_avatar(user) if user.errors.any?
    end
  end

  private

  def store_current_avatar
    return unless current_user.avatar.attached?

    @original_avatar_blob = current_user.avatar.blob
  end

  def restore_avatar(user)
    return unless @original_avatar_blob && !user.avatar.attached?

    user.avatar.attach(@original_avatar_blob)
  end
end
