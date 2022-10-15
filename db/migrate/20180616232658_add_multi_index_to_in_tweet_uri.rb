# frozen_string_literal: true

class AddMultiIndexToInTweetUri < ActiveRecord::Migration[5.2]
  def change
    # TODO: これ、同じ URI が複数埋め込まれていたらユニークにならない（実際そういうツイートがあった……）
    # TODO: こうするんじゃなくて、すでにレコードが存在していれば書き込まない、という論理ロジックしか無い……
    # add_index :in_tweet_uris, [:tweet_id, :uri], unique: true
  end
end
