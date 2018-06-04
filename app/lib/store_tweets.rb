class StoreTweets
  attr_reader :store_tweets

  def initialize
    @store_tweets = 'Hello, StoreTweets class!'
  end

  def insert_to_search_words(search_word)
    search_word = SearchWord.new(
      word: search_word,
    )

    if search_word.save
      @ret_message = 'save successful'
    else
      @ret_message = 'save failed'
    end

    # begin
    #   search_word.save
    # rescue e
    #   # Duplicate entry '刀剣乱舞' for key 'index_search_words_on_word'
    #   @error_message = e
    # end
  end
end