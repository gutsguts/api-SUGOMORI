# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show update destroy]

  def index
    posts = Post.order(created_at: :desc)
    render json: { status: 'SUCCESS', message: 'Loaded posts', data: posts }
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded the post', data: @post }
  end

  def create
    post = Post.new(post_params)
    if post.save
      render json: { status: 'SUCCESS', data: post }
    else
      render json: { status: 'ERROR', data: post.errors }
    end
  end

  def destroy
    @post.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the post', data: @post }
  end

  def update
    if @post.update(post_params)
      render json: { status: 'SUCCESS', message: 'Updated the post', data: @post }
    else
      render json: { status: 'SUCCESS', message: 'Not updated', data: @post.errors }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title)
  end

  # def index
  #   @post = Post.all
  #   render json: @post
  # end

  # def create
  #   @post = Post.create(post: params[:post])
  #   render json: @post
  # end

  # def update
  #   @post = Post.find(params[:id])
  #   @post.update_attributes(post: params[:post])
  #   render json: @post
  # end

  # def destroy
  #   @post = Post.find(params[:id])
  #   if @post.destroy
  #     head :no_content, status: :ok
  #   else
  #     render json: @post.errors, status: :unprocessable_entity
  #   end
  # end
end
