FactoryBot.define do
  factory :rss_feed do
    url { "http://www.examplefeed.com/" }
    syndicatable { association(:user) }
  end
end
