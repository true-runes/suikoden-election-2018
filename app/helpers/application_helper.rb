module ApplicationHelper
  def time_type_to_japanese_datetime_str(time_type_object)
    time_type_object.strftime("%Y/%m/%d(#{%w(日 月 火 水 木 金 土)[Time.now.wday]}) %H:%M:%S")
  end

  def normalize_tweet_text(tweet_text)
    CGI.unescapeHTML(tweet_text)
  end
end
