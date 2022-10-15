# frozen_string_literal: true

module TwitterApi
  module UpsertObjects
    class SearchWordsTable
      def self.upsert(search_word:)
        ActiveRecord::Base.connection_pool.with_connection do |c|
          Upsert.batch(c, :search_words) do |upsert|
            upsert.row(
              {
                word: search_word
              },
              {
                created_at: Time.zone.now,
                updated_at: Time.zone.now
              }
            )
          end
        end
      end
    end
  end
end
