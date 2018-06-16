class AddTCoInMedia < ActiveRecord::Migration[5.2]
  def change
    add_column :media, :uri_t_co, :string, after: :uri, null: false, default: 'UNKNOWN'
  end
end
