# USAGE
# TwitterApi::SearchTweet.insert(TwitterApi::SearchTweet.search(search_word: '#幻水総選挙2018'), search_word: '#幻水総選挙2018')

class TwitterApi::SearchTweet
  include TwitterApi::Client
  TAKE_TWEETS_NUMBER = 100

  # TODO: search_word は冗長なので削除する方向でリファクタリングする
  def self.insert(tweet_objects, search_word:)
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

  def search_word_tweet_exists?(search_word:)
    # TODO: 汚い
    if SearchWord.where(word: search_word).first.nil?
      return false
    elsif SearchWord.where(word: search_word).first.tweets.empty?
      return false
    else
      true
    end
  end

  def latest_tweet_number(search_word:)
    search_word_tweet_exists?(search_word: search_word) ? SearchWord.where(word: search_word).first.tweets.order(tweet_number: :desc).first[:tweet_number].to_s : 0
  end

  def oldest_tweet_number(search_word:)
    search_word_tweet_exists?(search_word: search_word) ? SearchWord.where(word: search_word).first.tweets.order(tweet_number: :asc).first[:tweet_number].to_s : 0
  end

  # TODO: since_id や max_id を柔軟に変更できるように options をマージする
  def self.search(search_word:, options: nil)
    search_tweet = TwitterApi::SearchTweet.new

    search_tweet.twitter_api_client.search(
      search_word,
      {
        tweet_mode: 'extended',
        result_type: 'recent',
        count: 100,
        since_id: search_tweet.latest_tweet_number(search_word: search_word),
        # max_id: search_tweet.oldest_tweet_number(search_word: search_word),
      }
    ).take(TAKE_TWEETS_NUMBER)
  end
end
