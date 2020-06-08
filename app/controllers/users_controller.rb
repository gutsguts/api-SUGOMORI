# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  # before_action :logged_in_user, only: %i[index edit update]
  before_action :logged_in_user, only: %i[edit update]

  before_action :admin_user,     only: :destroy

  def index
    users = User.order(created_at: :desc)
    render json: { status: 'SUCCESS', message: 'Loaded users', data: users }
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded the user', data: @user }
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if @user.save
      log_in @user
      render json: { status: 'SUCCESS', data: user }
      redirect_to @user
    else
      render json: { status: 'ERROR', data: user.errors }
      # render 'new'
    end
  end

  def destroy
    @user.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the user', data: @user }
    # flash[:success] = "User deleted"
    redirect_to users_url
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    # if @user.update_attributes(user_params)
    #   render json: { status: 'SUCCESS', message: 'Updated the user', data: @user }
    #   # redirect_to @user
    # else
    #   render json: { status: 'SUCCESS', message: 'Not updated', data: @user.errors }
    #   # render 'edit'
    # end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    p params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  # def logged_in_user
  #   return if logged_in?

  #   store_location
  #   # flash[:danger] = 'Please log in.'
  #   redirect_to login_url
  # end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
