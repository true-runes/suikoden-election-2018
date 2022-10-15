# frozen_string_literal: true

module TwitterApi
  module UpsertObjects
    class MediaTable
      def self.upsert(tweet_objects)
        tweet_objects.each do |tweet_object|
          next unless tweet_object.media?

          @bulk_upsert_objects = []

          tweet_object.media.each do |medium|
            # TODO: 動画URIは全く別のカラムを用意する必要がある
            @thumbnail_uri = "#{medium.media_uri_https}:thumb"

            @bulk_upsert_objects << Tweet.find_by(tweet_number: tweet_object.id).media.new(
              tweet_id: tweet_object.id,
              medium_own_id: medium.id,
              uri: medium.media_uri_https.to_s,
              thumbnail_uri: @thumbnail_uri,
              media_type: medium.type # TODO: enum
            )
          end

          Medium.import @bulk_upsert_objects, on_duplicate_key_update: [:updated_at]
        end
      end
    end
  end
end
