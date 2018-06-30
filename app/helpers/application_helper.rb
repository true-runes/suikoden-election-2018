module ApplicationHelper
  def time_type_to_japanese_datetime_str(time_type_object)
    time_type_object.strftime("%Y/%m/%d(#{%w(日 月 火 水 木 金 土)[time_type_object.wday]}) %H:%M:%S")
  end

  def normalize_tweet_text(tweet_text)
    CGI.unescapeHTML(tweet_text)
  end

  def remove_t_co_link(tweet_text)
    tweet_text.gsub(/( https:\/\/t\.co\/[0-9a-zA-Z]{10})/, '') # TODO: 行頭だとマッチしない
  end

  def this_page_title
    default_title = '幻水総選挙 2018'

    if @this_page_title
      "#{@this_page_title} | #{default_title}"
    else
      "#{default_title}"
    end
  end
end
