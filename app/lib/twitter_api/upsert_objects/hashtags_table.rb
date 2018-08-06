class TwitterApi::UpsertObjects::HashtagsTable
  def self.upsert(tweet_objects)
    tweet_objects.each do |tweet_object|
      if tweet_object.hashtags?
        @bulk_upsert_objects = []

        tweet_object.hashtags.each do |hashtag|
          @bulk_upsert_objects << Tweet.find_by(tweet_number: tweet_object.id).hashtags.new(
            name: hashtag.text,
            indices: hashtag.indices.to_s, # 一意性確保のためなので、正規化は考えない
          )
        end

        Hashtag.import @bulk_upsert_objects, on_duplicate_key_update: [:updated_at]
      end
    end
  end
end
