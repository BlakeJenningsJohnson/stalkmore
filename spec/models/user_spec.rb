require 'spec_helper'

describe User do let(:user) { User.new(username: "Blake", uid: "161286812", provider: "twitter") }

  describe "validations" do
    it "requires a username" do
      user.username = nil
      expect(user).to be_invalid
    end

    it "requires a uid" do
      user.uid = nil
      expect(user).to be_invalid
    end
    it "requires a provider" do
      user.provider = nil
      expect(user).to be_invalid
    end
  end

  describe ".initialize_from_omniauth" do
    let(:user) { User.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:twitter]) }

    it "creates a valid user" do
      # p OmniAuth.config.mock_auth[:twitter]
      expect(user).to be_valid
    end

    context "when it's invalid" do
      let(:user) { }
      it "returns nil" do
        user = User.find_or_create_from_omniauth({"uid" => "123", "info" => {}, "credentials" => {}})
        expect(user).to be_nil
      end
    end
  end
end