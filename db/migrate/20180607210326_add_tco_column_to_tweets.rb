class AddTcoColumnToTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :uri_t_co, :string, after: :uri, null: false, default: 'UNKNOWN'
  end
end
