class PracticeController < ApplicationController
  def insert_user
    @message = 'foo'

    obj = InsertTweet.new

    tweet_objects = obj.search_tweet(search_word: '#私のセイ')
    @message = tweet_objects

    obj.mazu_upsert_users(tweet_objects, search_word: '#私のセイ')
    obj.upsert_to_tweets_table(tweet_objects, search_word: '#私のセイ')

    # # @saidaichi = SearchWord.where(word: '#幻水総選挙2018').first.tweets # .all # .order('tweet_number ASC') # .first[:tweet_number].to_s
    # # @saidaichi = SearchWord.includes(:tweets).where(word: '#私のセイ').first[:text]

    # search_words = SearchWord.joins(:tweets).includes(:tweets).where(word: '#私のセイ')
    # @target_tweets = []
    # search_words.each do |search_word|
    #   @target_tweets = search_word.tweets.where(is_retweet: false).limit(10)
    # end
  end
end
