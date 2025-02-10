# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :store_current_avatar, only: [:update]

  def update
    super do |user|
      restore_avatar(user) if user.errors.any?
    end
  end

  def store_current_avatar
    user = current_user
    return unless user.avatar.attached?

    session[:original_avatar_url] = url_for(current_user.avatar.variant(:small))
  end

  def restore_avatar(user)
    return unless session[:original_avatar_url].present? && !user.avatar.attached?

    user.avatar.attach(ActiveStorage::Blob.find_signed(session[:original_avatar_url]))
  end
end
