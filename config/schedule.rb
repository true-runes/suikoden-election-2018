require File.expand_path(File.dirname(__FILE__) + "/environment")
rails_env = ENV['RAILS_ENV'] || :development
set :environment, rails_env
set :output, "#{Rails.root}/log/whenever.log"
env :PATH, ENV['PATH']

if @environment.to_sym == :development
  every 5.minute, roles: [:batch] do
    runner "TwitterApi::Tasks::SearchAndUpsertTweets.execute(search_word: '#幻水総選挙2018')"
  end
end

if @environment.to_sym == :production
  every 1.minute, roles: [:batch] do
    runner "TwitterApi::Tasks::SearchAndUpsertTweets.execute(search_word: '#幻水総選挙2018')"
  end
end