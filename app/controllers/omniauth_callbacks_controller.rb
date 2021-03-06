# frozen_string_literal: true

require 'devise_token_auth'

class OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
  def facebook
    basic_action
  end

  def github
    basic_action
  end

  def twitter
    basic_action
  end
  # def google; basic_action; end

  private

  def basic_action
    @omniauth = request.env['omniauth.auth']
    if @omniauth.present?
      @profile = SocialProfile.where(provider: @omniauth['provider'], uid: @omniauth['uid']).first
      unless @profile
        @profile = SocialProfile.where(provider: @omniauth['provider'], uid: @omniauth['uid']).new
        @profile.user = current_user || User.create!(name: @omniauth['name'])
        @profile.save!
      end
      if current_user
        raise 'user is not identical' if current_user != @profile.user
      else
        sign_in(:user, @profile.user)
      end
      @profile.set_values(@omniauth)
    end
    render :close, layout: false
  end
end
