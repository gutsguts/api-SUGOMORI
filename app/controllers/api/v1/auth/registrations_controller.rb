# frozen_string_literal: true

# class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private

  def sign_up_params
    params.permit(:name, :email, :uid, :password, :password_confirmation, :registration)
  end

  def account_update_params
    params.permit(:name, :email, :uid, :password, :password_confirmation, :registration)
  end
end
