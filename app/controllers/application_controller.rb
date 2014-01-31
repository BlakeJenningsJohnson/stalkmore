class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :get_posts

  def current_user
    current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  # Moved greeting from sessions to here so that all controllers have access for validations. (revisit)

  def greeting
    if current_user
      current_user.username
    else
      "Potential Stalker"
    end
  end

  helper_method :greeting, :get_post_type

  # def disable_nav
  #   @disable_nav = true
  # end

  # def get_post_type(post)
  #   Feed.find(post.feed_id).type
  # end

  # def get_posts
  #   user_subs = Subscription.where("user_id = #{current_user.id}") unless current_user.nil?  # user_subs is all subscriptions that match user_id
  #   @posts = [] # Start w/empty array of posts
  #   if user_subs.nil? # If there aren't any subs for that user return
  #     return
  #   else
  #     user_subs.each { |sub|  # Otherwise, for each subscription, for its corresponding feed, add all the posts association with that feed to the posts array (Post table has feed_id)
  #       @posts = @posts + Post.where("feed_id = #{sub.feed_id}") 
  #     }  
  #   end
  # end
end
