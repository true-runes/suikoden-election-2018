class PracticeController < ApplicationController
  def insert_user
    obj = InsertTweet.new

    tweet_objects = obj.search_tweet(search_word: '#私のセイ')
    @message = tweet_objects

    obj.mazu_upsert_users(tweet_objects, search_word: '#私のセイ')
    obj.upsert_to_tweets_table(tweet_objects, search_word: '#私のセイ')

    obj = OperateSpreadsheet.new
    obj.debug
  end
end
