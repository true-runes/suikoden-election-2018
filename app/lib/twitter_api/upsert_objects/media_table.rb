class TwitterApi::UpsertObjects::MediaTable
  def self.upsert(tweet_objects)
    tweet_objects.each do |tweet_object|
      if tweet_object.media?
        @bulk_upsert_objects = []

        tweet_object.media.each do |medium|
          # TODO: mp4, gif...
          if medium.type == 'photo'
            @thumbnail_uri = "#{medium.media_uri_https.to_s}:thumb"
          end

          @bulk_upsert_objects << Tweet.find_by(tweet_number: tweet_object.id).media.new(
            medium_own_id: medium.id,
            uri: medium.media_uri_https.to_s,
            thumbnail_uri: @thumbnail_uri,
            media_type: medium.type, # TODO: enum
          )
        end

        Medium.import @bulk_upsert_objects
      end
    end
  end
end
