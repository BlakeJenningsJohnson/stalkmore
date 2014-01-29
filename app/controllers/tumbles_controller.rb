class TumblesController < ApplicationController

  def search
    @search = params[:search].split(" ").join("-")
    @tumbles = TumblrFeed.client.posts(@search)
    if @tumbles == {"status"=>404, "msg"=>"Not Found"}
      redirect_to "/", notice: "No users match your search." 
    else
      @title = @tumbles["blog"]["title"]
      @url   = @tumbles["blog"]["url"]
    end
  end
end
