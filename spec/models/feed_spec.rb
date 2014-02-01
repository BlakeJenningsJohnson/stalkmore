require 'spec_helper'

describe Feed do let(:feed) { Feed.new(uid: "123456", type: "TwitterFeed") }

  describe "validations" do
    it "requires a uid" do
      feed.uid = nil
      expect(feed).to be_invalid
    end

    it "requires a type" do
      feed.type = nil
      expect(feed).to be_invalid
    end
  end

  describe "create a new feed" do
    let(:feed) { Feed.find_or_create_by(uid: "laughingsquid", type: "TumblrFeed") }

    it "creates a valid feed" do
      expect(feed).to be_valid
    end

    context "when it's invalid" do
      it "returns nil" do
        feed = Feed.find_or_create_by(uid: "123", type: "")
        expect(feed).to be_nil
      end
    end
  end
end