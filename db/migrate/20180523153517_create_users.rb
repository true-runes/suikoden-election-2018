class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :screen_name, null: false, default: ''
      t.string :user_number, null: false, default: ''

      t.timestamps
    end
  end
end
