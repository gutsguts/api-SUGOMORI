# frozen_string_literal: true

class StaticPagesController < ApplicationController
  include ActionController::MimeResponds
  def home
    if logged_in?
      @insta_post = current_user.insta_posts.build

      if params[:q]
        relation = InstaPost.joins(:user)
        @feed_items = relation.merge(User.search_by_keyword(params[:q]))
                              .or(relation.search_by_keyword(params[:q]))
                              .paginate(page: params[:page])
      else
        @feed_items = current_user.feed.paginate(page: params[:page])
      end
    end
    render json: @users
  end

  def help; end

  def about; end

  def contact; end
end
