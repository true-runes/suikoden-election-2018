class StoreTweets
  attr_reader :store_tweets

  def initialize
    @store_tweets = 'Hello, StoreTweets class!'
  end

  def insert_to_search_words(search_word)
    # search_word = SearchWord.new(
    #   word: search_word,
    # )

    # if search_word.save
    #   @ret_message = 'save successful'
    # else
    #   @ret_message = 'save failed'
    # end

    insert_words = [
      '幻水',
      '#幻水',
      '#幻水総選挙',
      '#幻想水滸伝',
    ]

    begin
      ActiveRecord::Base.connection_pool.with_connection do |c|
        Upsert.batch(c, :search_words) do |upsert|
          insert_words.each do |insert_word|
            upsert.row(
              { word: insert_word },
              {
                created_at: Time.now.utc,
                updated_at: Time.now.utc,
              },
            )
          end
        end
      end
    rescue e
      # Duplicate entry '刀剣乱舞' for key 'index_search_words_on_word'
      @error_message = e
    end
  end
end