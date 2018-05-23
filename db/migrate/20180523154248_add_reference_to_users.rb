class AddReferenceToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :tweets, :user, index: true, after: :tweet_number, null: false
  end
end
