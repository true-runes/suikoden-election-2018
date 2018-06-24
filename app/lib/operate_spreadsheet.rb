class OperateSpreadsheet
  def self.session
    credentials = Google::Auth::UserRefreshCredentials.new(
      client_id: Rails.application.credentials.spreadsheet_api[:client_id],
      client_secret: Rails.application.credentials.spreadsheet_api[:client_secret],
      scope: [
        'https://www.googleapis.com/auth/drive',
        'https://spreadsheets.google.com/feeds/',
      ],
      refresh_token: Rails.application.credentials.spreadsheet_api[:refresh_token],
    )
    # @session = GoogleDrive::Session.from_credentials(credentials)
    GoogleDrive::Session.from_credentials(credentials)
  end

  def self.debug
    spreadsheet_uri = Rails.application.credentials.spreadsheet_uri
    spreadsheet = session.spreadsheet_by_url(spreadsheet_uri)

    tweet_text_column_index = 2 # B列
    uri_column_index        = 15 # O列
    tweet_id_index          = 17 # Q列
    tweeted_at_index        = 18 # R列

    # TODO: whereの条件を分割する
    tweets_ascending = Tweet.where(is_retweet: 0).where(tweeted_at: '2018-06-22 21:00:00'.in_time_zone('Tokyo')..'2018-06-24 09:00:00'.in_time_zone('Tokyo')).where.not(user_id: 28).order(tweeted_at: :asc)

    # TODO: NOT DRY
    target_worksheets = [
      'ツイ 01',
      'ツイ 02',
      'ツイ 03',
      'ツイ 04',
      'ツイ 05',
      'ツイ 06',
      'ツイ 07',
      'ツイ 08',
      'ツイ 09',
      'ツイ 10',
      'ツイ 11',
      'ツイ 12',
      'ツイ 13',
      'ツイ 14',
      'ツイ 15',
      'ツイ 16',
      'ツイ 17',
      'ツイ 18',
      'ツイ 19',
      'ツイ 20',
    ]

    # 100 ごとに分割
    worksheet = spreadsheet.worksheet_by_title('マスターデータ')

    # 分割するときに index が 0 以外から始まると分かりにくいので、あえて 0 から始める
    tweets_ascending.each_with_index do |tweet, i|
      # break if i > 99

      user = User.find(tweet.user_id)
      user_name = user.name
      screen_name = user.screen_name

      tweet_content = <<~TEXT
        #{tweet.text}

        #{user_name} (@#{screen_name})
      TEXT
      tweet_content.chomp!

      worksheet[i + 2, tweet_text_column_index] = tweet_content
      worksheet[i + 2, uri_column_index] = %Q(=HYPERLINK("#{tweet.uri}", "リンク")) # ダブルクォーテーションでないとダメ
      worksheet[i + 2, tweet_id_index] = tweet.id
      worksheet[i + 2, tweeted_at_index] = tweet.tweeted_at

      # This version of the Google Sheets API has a limit of 500 requests per 100 seconds per project, and 100 requests per 100 seconds per user. Limits for reads and writes are tracked separately. There is no daily usage limit.
      worksheet.save
    end
  end
end
