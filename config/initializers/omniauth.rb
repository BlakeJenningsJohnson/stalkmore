Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer # unless Rails.env.production?
  # provider :twitter, ENV["TWITTER_ACCESS_TOKEN"], ENV["TWITTER_ACCESS_TOKEN_SECRET"]
  provider :twitter, ENV["TWITTER_CONSUMER_KEY"], ENV["TWITTER_CONSUMER_SECRET"]
end