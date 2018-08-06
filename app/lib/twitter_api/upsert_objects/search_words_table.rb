class TwitterApi::UpsertObjects::SearchWordsTable
  def self.upsert(search_word:)
    ActiveRecord::Base.connection_pool.with_connection do |c|
      Upsert.batch(c, :search_words) do |upsert|
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
