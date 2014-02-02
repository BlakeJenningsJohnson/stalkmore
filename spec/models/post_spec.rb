require 'spec_helper'

describe Post do let(:post) { Post.new(post_date: "2013-04-15 03:11:26") }

  describe "validations" do
    it "requires a post date" do
      post.post_date = nil
      expect(post).to be_invalid
    end
  end
end