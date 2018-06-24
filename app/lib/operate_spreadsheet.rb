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
    # Tweet.new.final_valid_vote_tweets.each do
    spreadsheet_uri = Rails.application.credentials.spreadsheet_uri
    spreadsheet = session.spreadsheet_by_url(spreadsheet_uri)
    worksheet_name = 'マスターデータ'
    worksheet = spreadsheet.worksheet_by_title(worksheet_name)

    # 添字の始まりは 1 であることに注意する
    # 指定の仕方は WORKSHEET[行, 列]
    tweet_text_column_index = 2 # B列
    uri_column_index = 15 # O列

    valid_users_with_tweets = Tweet.new.valid_users_with_tweets
    valid_users_with_tweets.each do |user_with_tweets|
      user_with_tweets.tweets.each do |tweet|
        cell_text = <<~TEXT
          #{tweet.text}

          #{user.name} (#{user.screen_name})
        TEXT

        worksheet[2, tweet_text_column_index] = cell_text
        worksheet[2, uri_column_index] = %Q(=HYPERLINK("#{tweet.uri}","ツイートへのリンク"))

        break
      end
    end

    worksheet.save

    # target_tweets = User.joins(:tweets).joins(:search_words).includes(:tweets).includes(:search_words).where(tweets: { id: 1006680791961628673 })
    # users = User.joins(:tweets).includes(:tweets).where(users: { screen_name: 'gensosenkyo' })
    # users = users.order('tweets.tweeted_at DESC')

    # users.each do |user|
    #   user.tweets.each.with_index(2) do |tweet, i|
    #     worksheet[i, tweet_text_column_index] = tweet.text
    #     worksheet[i, tweet_account_column_index] = user.screen_name
    #     worksheet[i, tweeted_at_column_index] = tweet.tweeted_at
    #     worksheet[i, tweet_uri_column_index] = %Q(=HYPERLINK("#{tweet.uri}","ツイートへのリンク"))
    #     break if i > 100
    #   end
    # end
  end
end
