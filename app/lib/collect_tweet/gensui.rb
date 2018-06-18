# TODO: あとで消す
class CollectTweet::Gensui
  extend CollectTweet::TwitterApiClient

  def self.suikoden
    client = twitter_api_client

    user_object = client.user('gensosenkyo')
    command = %Q(echo #{user_object.name} >> /tmp/foobarsuikoden.txt)
    result = `#{command}`
  end
end
