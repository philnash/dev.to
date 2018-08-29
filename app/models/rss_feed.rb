class RssFeed < ApplicationRecord
  validates :url, presence: true
  validate  :validate_feed_url

  belongs_to :syndicatable, polymorphic: true

  private

  def validate_feed_url
    return unless url.present?
    errors.add(:url, "is not a valid rss feed") unless RssReader.new.valid_feed_url?(url)
  end
end
