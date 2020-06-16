# frozen_string_literal: true

# module Api
#   module V1
class Api::V1::Auth::ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  skip_before_action :verify_authenticity_token, raise: false, if: :devise_controller?

  include SessionsHelper

  serialization_scope :view_context

  before_action :authenticate_account!, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def devise_token_auth_controller?
    params[:controller].split('/')[0] == 'devise_token_auth'
  end

  def configure_permitted_parameters
    # DBにaccounts.nameカラムがある場合
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
