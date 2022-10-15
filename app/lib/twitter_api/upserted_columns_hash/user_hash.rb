# frozen_string_literal: true

module TwitterApi
  module UpsertedColumnsHash
    class UserHash
      include TwitterApi::UpsertedColumnsHash::KillNil

      def all_columns(user_object)
        # TODO: 切り出す
        uri = if user_object.uri.nil?
                'NOTHING'
              else
                user_object.uri.to_s
              end

        uri_t_co = if user_object.respond_to? :attrs
                     user_object.attrs[:url].to_s
                   else
                     'NOTHING'
                   end

        # TODO: ハードコードは切り出す
        {
          screen_name: kill_nil(user_object.screen_name.to_s),
          name: kill_nil(user_object.name.to_s),
          description: kill_nil(user_object.description.to_s, default_value: 'NOTHING'),
          uri: kill_nil(uri.to_s),
          uri_t_co: kill_nil(uri_t_co, default_value: 'NOTHING'), # 場合によってnilになる……
          tweet_count: kill_nil(user_object.statuses_count),
          profile_banner_uri: kill_nil(user_object.profile_banner_uri_https('1500x500').to_s),
          profile_image_uri: kill_nil(user_object.profile_image_uri_https('400x400').to_s),
          favorite: kill_nil(user_object.favourites_count),
          followers: kill_nil(user_object.followers_count),
          followee: kill_nil(user_object.friends_count),
          listed: kill_nil(user_object.listed_count),
          language: kill_nil(user_object.lang),
          location: kill_nil(user_object.location, default_value: 'NOTHING'),
          website: kill_nil(user_object.website.to_s, default_value: 'NOTHING'),
          bg_color: kill_nil(user_object.profile_background_color),
          link_color: kill_nil(user_object.profile_link_color),
          border_color: kill_nil(user_object.profile_sidebar_border_color),
          side_color: kill_nil(user_object.profile_sidebar_fill_color),
          text_color: kill_nil(user_object.profile_text_color),
          time_zone: kill_nil(user_object.time_zone, default_value: 'NOTHING'),
          utc_offset: kill_nil(user_object.utc_offset, default_value: 'NOTHING'),
          account_created_at: kill_nil(user_object.created_at),
          connections: kill_nil(user_object.connections, default_value: 'NOTHING'),
          email: kill_nil(user_object.email, default_value: 'NOTHING'),

          created_at: Time.zone.now,
          updated_at: Time.zone.now
        }
      end
    end
  end
end
