# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  def new
    # redirect_to root_url unless Rails.env.test?
  end

  def destroy
    super
    session[:keep_signed_out] = true # Set a flag to suppress auto sign in
  end
end
# class SessionsController < ApplicationController
# def new; end

# def create
#   user = User.find_by(email: params[:session][:email].downcase)
#   if user&.authenticate(params[:session][:password])
#     log_in user
#     params[:session][:remember_me] == '1' ? remember(user) : forget(user)
#     redirect_back_or user
#   else
#     # ログイン失敗のメッセージ
#     flash.now[:danger] = 'Invalid email/password combination'
#     render 'new'
#   end
# end

# def destroy
#   log_out if logged_in?
#   # redirect_to root_url React側で書く
# end
# end
