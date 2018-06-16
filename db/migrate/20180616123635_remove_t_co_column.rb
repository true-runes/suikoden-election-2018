class RemoveTCoColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column  :in_tweet_uris, :uri_t_co, :string
  end
end
