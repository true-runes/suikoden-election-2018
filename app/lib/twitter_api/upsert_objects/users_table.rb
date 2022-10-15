# frozen_string_literal: true

module TwitterApi
  module UpsertObjects
    class UsersTable
      def self.upsert(user_objects)
        ActiveRecord::Base.connection_pool.with_connection do |c|
          Upsert.batch(c, :users) do |upsert|
            user_objects.each do |user_object|
              user_hash = TwitterApi::UpsertedColumnsHash::UserHash.new

              upsert.row(
                {
                  user_number: user_object.id
                },
                user_hash.all_columns(user_object)
              )
            end
          end
        end
      end
    end
  end
end
