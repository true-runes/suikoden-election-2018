class TwitterApi::SearchTweet
  extend TwitterApi::Client

  # 昨年の実績から、毎分100ツイートを超えることは考えにくい
  TAKE_TWEETS_NUMBER = 100

  def self.insert(search_word:, options: nil)
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

  def tweet_number_exists?(search_word:)
    # TODO: 汚い……
    if SearchWord.where(word: search_word).first.nil?
      return false
    elsif SearchWord.where(word: search_word).first.tweets.nil?
      return false
    else
      true
    end
  end

  def latest_tweet_number(search_word:)
    tweet_number_exists?(search_word: search_word) ? SearchWord.where(word: search_word).first.tweets.order('tweet_number DESC').first[:tweet_number].to_s : 0
  end

  def oldest_tweet_number(search_word:)
    tweet_number_exists?(search_word: search_word) ? SearchWord.where(word: search_word).first.tweets.order('tweet_number ASC').first[:tweet_number].to_s : 0
  end

  # HACK: 検索以外の手段での取得にも対応する（特定ユーザタイムライン、自分のタイムライン）
  # HACK: since_id や max_id を手動で設定（フォーム）
  def self.search(search_word:, options: nil)
    search_tweet = TwitterApi::SearchTweet.new

    twitter_api_client.search(
      search_word,
      {
        tweet_mode: 'extended',
        result_type: 'recent',
        count: 100,
        since_id: search_tweet.latest_tweet_number(search_word: search_word),
      }
    ).take(100)
  end
end
