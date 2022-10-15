# frozen_string_literal: true

module TwitterApi
  module UpsertObjects
    class TweetsTable
      def self.upsert(tweet_objects, search_word: nil)
        ActiveRecord::Base.connection_pool.with_connection do |c|
          Upsert.batch(c, :tweets) do |upsert|
            tweet_objects.each do |tweet_object|
              tweet_hash = TwitterApi::UpsertedColumnsHash::TweetHash.new

              # 対応する user_id が存在しないと undefined method になる
              upsert.row(
                {
                  tweet_number: tweet_object.id
                },
                tweet_hash.all_columns(tweet_object, search_word:)
              )
            end
          end
        end
      end
    end
  end
end
