require "rails_helper"

RSpec.describe RssFeed, type: :model do
  let (:rss_feed) { create(:rss_feed) }

  it { is_expected.to validate_presence_of(:url) }
  it { is_expected.to belong_to(:syndicatable) }

  it "validates the url is a valid feed" do
    WebMock.
      stub_request(:get, rss_feed.url).
      to_return(body: valid_rss)
    expect(rss_feed).to be_valid
  end

  it "is not valid if the feed does not return RSS" do
    rss_feed.url = "http://example.com/not-feed"
    WebMock.
      stub_request(:get, rss_feed.url).
      to_return(body: "Not a feed")
    expect(rss_feed).not_to be_valid
  end
end

def valid_rss
  <<~RSS
    <?xml version="1.0" encoding="UTF-8" ?>
    <rss version="2.0">
      <channel>
        <title>Example RSS Feed</title>
        <link>https://www.example.com</link>
        <description>An example empty RSS Feed</description>
      </channel>
    </rss>
  RSS
end
