class TwitterApi::UpsertedColumnsHash::TweetHash
  include TwitterApi::UpsertedColumnsHash::KillNil

  def all_columns(tweet_object, search_word: nil)
    user_id = User.where(user_number: tweet_object.user.id).first.id

    # TODO: ちょっと分かりにくい
    if search_word.nil?
      search_word_id = SearchWord.where(word: '検索語なし').first.id # seedを忘れずにいれること（マジックワードなので危険みがある）
    else
      if SearchWord.where(word: search_word).blank?
        search_word_id = SearchWord.where(word: '検索語なし').first.id
      else
        search_word_id = SearchWord.where(word: search_word).first.id
      end
    end

    {
      user_id: user_id,
      has_user_mentions: kill_nil(tweet_object.user_mentions?),
      has_uris: kill_nil(tweet_object.uris?),
      has_symbols: kill_nil(tweet_object.symbols?),
      has_media: kill_nil(tweet_object.media?),
      has_hashtags: kill_nil(tweet_object.hashtags?),
      is_retweet: kill_nil(tweet_object.retweet?),
      tweeted_at: kill_nil(tweet_object.created_at),
      uri: kill_nil(tweet_object.uri.to_s),
      client_name: kill_nil(tweet_object.source),
      retweet_count: kill_nil(tweet_object.retweet_count),
      lang: kill_nil(tweet_object.lang),
      in_reply_to_user_id: kill_nil(tweet_object.in_reply_to_user_id),
      in_reply_to_status_id: kill_nil(tweet_object.in_reply_to_status_id),
      in_reply_to_screen_name: kill_nil(tweet_object.in_reply_to_screen_name),
      favorite_count: kill_nil(tweet_object.favorite_count),
      text: kill_nil(tweet_object.attrs[:full_text]),
      search_word_id: kill_nil(search_word_id),

      created_at: Time.now,
      updated_at: Time.now,
    }
  end
end