# frozen_string_literal: true

# module Api
#   module V1
class Api::V1::Auth::ApplicationController < ActionController::API # Note: here is not ::BASE
  include DeviseTokenAuth::Concerns::SetUserByToken
  skip_before_action :verify_authenticity_token, raise: false, if: :devise_controller?

  include SessionsHelper

  # protect_from_forgery unless: -> { request.format.json? }

  # session[:_csrf_token]
  # include ActionController::RequestForgeryProtection
  # protect_from_forgery with: :exception
  # protect_from_forgery with: :null_session
  # include DeviseTokenAuth::Concerns::SetUserByToken
  # include SessionsHelper

  # before_filter :set_host

  # def set_host
  #   Rails.application.routes.default_url_options[:host] = request.host_with_port
  # end
  #   end
  # end
end
