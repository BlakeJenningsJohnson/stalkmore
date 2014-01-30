require 'spec_helper'

describe Feed do let(:feed) { Feed.new(uid: "123456", type: "twitter") }

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
    let(:feed) { Feed.find_or_create_by(uid: params["uid"], type: params[:tumblr_feed]) }

    it "creates a valid user" do
      expect(user).to be_valid
    end

    context "when it's invalid" do
      it "returns nil" do
        user = User.find_or_create_from_omniauth({"uid" => "123", "info" => {}})
        expect(user).to be_nil
      end
    end
  end
end