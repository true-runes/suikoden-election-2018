class TwitterApi::Tasks::UpsertSpecificUserTimeline
  def self.execute(user_id: nil, screen_name: nil, options: {})
    # TODO: user_id で取得するロジックがまだ無い
    # TODO: since_id をハードコーディングで決め打ちしているのは良くない
    since_id = Tweet.new.latest_original_tweet_number_of_specific_screen_name(screen_name)
    options = {
      since_id: since_id,
    }
    target_tweet_objects = TwitterApi::SpecificUserTimeline.execute(user_id: user_id, screen_name: screen_name, options: options)
    target_user_objects = TwitterApi::ExchangeTweetToUser.execute(target_tweet_objects);

    # 下の2つの順番には依存性がある
    TwitterApi::UpsertObjects::UsersTable.upsert(target_user_objects)
    TwitterApi::UpsertObjects::TweetsTable.upsert(target_tweet_objects, search_word: '検索語なし') # TODO: ハードコーディング

    TwitterApi::UpsertObjects::InUserUrisTable.upsert(target_user_objects)
    TwitterApi::UpsertObjects::HashtagsTable.upsert(target_tweet_objects)
    TwitterApi::UpsertObjects::InTweetUrisTable.upsert(target_tweet_objects)
    TwitterApi::UpsertObjects::MediaTable.upsert(target_tweet_objects)
  end

  # TODO: this is an example method
  def self.execute_for_gensosenkyo_account
    execute(screen_name: 'gensosenkyo')
  end
end
