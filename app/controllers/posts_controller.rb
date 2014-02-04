class PostsController < ApplicationController
  
  def index
    if @current_user
      @feeds = @current_user.feeds
      @feeds.each do | feed |
        feed.save_posts
      end
      @all_the_posts = @current_user.posts.order('post_date DESC')
    else
      redirect_to welcome_path, notice: "You have to sign in to perform this action."
    end
  end
end
