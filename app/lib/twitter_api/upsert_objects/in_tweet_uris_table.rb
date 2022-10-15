# frozen_string_literal: true

module TwitterApi
  module UpsertObjects
    class InTweetUrisTable
      def self.upsert(tweet_objects)
        tweet_objects.each do |tweet_object|
          next unless tweet_object.uris?

          @bulk_upsert_objects = []

          tweet_object.uris.each do |uri|
            @bulk_upsert_objects << Tweet.find_by(tweet_number: tweet_object.id).in_tweet_uris.new(
              uri: uri.expanded_url.to_s,
              indices: uri.indices.to_s # 一意性確保のためなので、正規化は考えない
            )
          end

          InTweetUri.import @bulk_upsert_objects, on_duplicate_key_update: [:updated_at]
        end
      end
    end
  end
end
