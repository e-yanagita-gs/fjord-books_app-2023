# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :store_current_avatar, only: [:update]

  private

  def store_current_avatar
    return unless current_user.avatar.attached?

    @original_avatar = current_user.avatar
  end
end
