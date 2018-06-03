class ReModifyDateTimeFormatInUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :account_created_at, Time.local(1980, 1, 1, 12, 0, 0, 0).utc
  end
end
