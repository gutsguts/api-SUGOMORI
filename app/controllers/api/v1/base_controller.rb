# frozen_string_literal: true

class Api::V1::BaseController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  # protect_from_forgery with: :null_session # トークン認証のためCSRFは使わない
end
