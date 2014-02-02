require 'spec_helper'

describe TumblrFeed do 
  let(:feed) { Feed.new(uid: "laughingsquid", type: "TumblrFeed") }

  it "saves posts to a feed" do
    
    expect {
      feed.save_posts 
    }.to change(Post, :count)

    expect(Post.last.feed_id).to eq(feed.id)
  end
end  