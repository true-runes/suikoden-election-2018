class TwitterApi::SearchTweet
  extend TwitterApi::Client
  TAKE_TWEETS_NUMBER = 100

  def self.search(search_word:, options: {})
    default_options = {
      tweet_mode: 'extended',
      result_type: 'recent',
      count: 100,
    }
    options = default_options.update(options)

    twitter_api_client.search(search_word, options).take(TAKE_TWEETS_NUMBER)
  end

  def self.search_word_tweet_exists?(search_word:)
    # TODO: 汚い
    if SearchWord.where(word: search_word).first.nil?
      return false
    elsif SearchWord.where(word: search_word).first.tweets.empty?
      return false
    else
      true
    end
  end

  def self.latest_tweet_number(search_word:)
    search_word_tweet_exists?(search_word: search_word) ? SearchWord.where(word: search_word).first.tweets.order(tweet_number: :desc).first[:tweet_number].to_s : 0
  end

  def self.oldest_tweet_number(search_word:)
    search_word_tweet_exists?(search_word: search_word) ? SearchWord.where(word: search_word).first.tweets.order(tweet_number: :asc).first[:tweet_number].to_s : 0
  end
end
