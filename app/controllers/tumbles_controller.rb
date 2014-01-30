class TumblesController < ApplicationController

  def search
    @search = params[:search].split(" ").join("-")
    @tumbles = TumblrFeed.client.posts(@search)
    if @tumbles == {"status"=>404, "msg"=>"Not Found"}
      redirect_to "/", notice: "No match found.  <a onclick=\"tumblrfocus()\">Please search again.</a>".html_safe 
    else
      @title = @tumbles["blog"]["title"]
      @url   = @tumbles["blog"]["url"]
    end
  end
end
