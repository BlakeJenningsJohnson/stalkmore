require 'spec_helper'

describe TwitterFeed do 
  let(:feed) { Feed.create!(uid: "161286812", type: "TwitterFeed") }

  it "saves posts to a feed" do
    
    expect {
      feed.save_posts 
    }.to change(Post, :count)

    expect(Post.last.feed_id).to eq(feed.id)
  end
end  