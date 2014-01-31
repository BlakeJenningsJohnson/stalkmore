class PostsController < ApplicationController
  
  def index
    @feeds = @current_user.feeds
    @all_the_posts = @current_user.posts.order('post_date DESC')
  end
end
