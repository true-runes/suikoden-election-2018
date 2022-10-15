# frozen_string_literal: true

module TwitterApi
  module Tasks
    class UpdateUserObject
      # TODO: アイコンが存在しないユーザのidを取得する

      # 非推奨（ユーザ数分だけ API にアクセスするため）
      def self.execute_by_each_user(user_ids: [])
        user_ids.each do |_user_id|
          execute_by_one_user(user_id: twitter_user_id)
        end
      end

      def self.execute_by_one_user(user_id:)
        user_object = TwitterApi::SpecificUserObject.execute_by_one_user(user_id:)

        TwitterApi::UpsertObjects::UsersTable.upsert([user_object]) # TODO: each 前提なので引数を配列にしないといけない
      end
    end
  end
end
