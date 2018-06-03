class ModifyDateTimeFormatInUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :account_created_at, Time.local(1980, 1, 1, 21, 0, 0, 0).utc
    # default: "1980-01-01 21:00:00", null: false
  end
end
