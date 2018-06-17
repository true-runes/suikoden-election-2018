class PracticeController < ApplicationController
  def insert_user
    obj = InsertTweet.new

    tweet_objects = obj.search_tweet(search_word: '#幻水総選挙運動')
    @message = tweet_objects

    obj.mazu_upsert_users(tweet_objects, search_word: '#幻水総選挙運動')
    obj.upsert_to_tweets_table(tweet_objects, search_word: '#幻水総選挙運動')
  end
end
