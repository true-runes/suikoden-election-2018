class ArrangeMediaModel < ActiveRecord::Migration[5.2]
  def change
    remove_column :media, :uri_t_co, :string

    add_column :media, :thumbnail_uri, :string, after: :uri, null: false, default: 'UNKNOWN'
    add_column :media, :type, :string, after: :thumbnail_uri, null: false, default: 'UNKNOWN'
  end
end
