# frozen_string_literal: true

module TwitterApi
  module UpsertObjects
    class InUserUrisTable
      def self.upsert(user_objects) # rubocop:disable Metrics/AbcSize
        user_objects.each do |user_object|
          user_attrs = user_object.attrs
          in_user_uri_object = user_attrs[:entities][:description][:urls]

          next if in_user_uri_object.empty?

          @bulk_upsert_objects = []

          # TODO: user_number が nil のときどうする？（依存性があるから大丈夫だが、万一のとき）
          # TODO: UPSERTに対応してる？（On Duplicate Key Update）
          in_user_uri_object.each do |in_user_uri|
            @bulk_upsert_objects << User.find_by(user_number: user_object.id).in_user_uris.new(
              uri: in_user_uri[:url],
              expanded_uri: in_user_uri[:expanded_url],
              indices: in_user_uri[:indices].to_s # 一意性確保のためなので、正規化は考えずに to_s する
            )
          end

          InUserUri.import @bulk_upsert_objects, on_duplicate_key_update: [:updated_at]
        end
      end
    end
  end
end
