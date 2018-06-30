class TwitterApi::Tasks::UpdateUserObject
  # 非推奨（ユーザ数分だけ API にアクセスするため）
  def self.execute_by_each_user(twitter_user_ids: [])
    twitter_user_ids.each do |twitter_user_id|
      execute_by_one_user(twitter_user_id: twitter_user_id)
    end
  end

  def self.execute_by_one_user(twitter_user_id:)
    user_object = TwitterApi::SpecifyUserObject.execute_by_one_user(twitter_user_id.to_i)

    TwitterApi::UpsertObjects::UsersTable.upsert([user_object]) # TODO: each 前提なので引数を配列にしないといけない
  end
end
