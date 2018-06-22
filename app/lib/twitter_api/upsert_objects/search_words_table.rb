class TwitterApi::UpsertObjects::SearchWordsTable
  def self.upsert(tweet_objects, search_word:)
    ActiveRecord::Base.connection_pool.with_connection do |c|
      Upsert.batch(c, :search_words) do |upsert|
        tweet_objects.each do |tweet_object|
          upsert.row(
            {
              word: search_word,
            },
            {
              created_at: Time.now,
              updated_at: Time.now,
            },
          )
        end
      end
    end
  end
end
