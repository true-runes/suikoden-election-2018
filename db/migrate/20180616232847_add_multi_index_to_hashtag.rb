class AddMultiIndexToHashtag < ActiveRecord::Migration[5.2]
  def change
    # TODO: これ、同じ ハッシュタグ が複数埋め込まれていたらユニークにならない（実際そういうツイートがあった……）
    # TODO: こうするんじゃなくて、すでにレコードが存在していれば書き込まない、という論理ロジックしか無い……
    # add_index :hashtags, [:tweet_id, :name], unique: true
  end
end
