require 'upsert/active_record_upsert'

class HelloController < ApplicationController
  include Collection
  before_action :sample_method, only: [:index]

  def upsert
    ActiveRecord::Base.connection_pool.with_connection do |c|
      Upsert.batch(c, :users) do |upsert|
        tweets_by_hashtag.each do |tweet|
          upsert.row(
            { user_number: tweet.user.id },
            {
              user_number: tweet.user.id,
              screen_name: tweet.user.screen_name,
              created_at: Time.now.utc,
              updated_at: Time.now.utc,
            },
          )
        end
      end
    end
  end

  def index
    rows = [
      [
        'Alvin',
        'Eclair',
        '$0.87',
      ],
      [
        'Alan',
        'J ellybean',
        '$3.76',
      ],
      [
        'Jonathan',
        'Lollipop',
        '$7.00',
      ],
      [
        'Shannon',
        'Eclair',
        "$#{sample_method}.00",
      ],
      [
        MyConstants::MY_NAME,
        MyConstants::MY_FAVORITE_GAME,
        "$#{sample_method}.00",
      ],
    ]

    HardWorker.perform_async('bob', 5)

    @headers = ['screen_name', 'tweet_text', 'tweet_id' ,'created_at']
    @return_value = rows
    @tweets = tweets_by_hashtag
  end

  private
  def sample_method
    a = 1
    b = 2

    a + b
  end
end
