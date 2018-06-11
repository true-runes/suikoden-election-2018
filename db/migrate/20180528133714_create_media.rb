class CreateMedia < ActiveRecord::Migration[5.2]
  def change
    create_table :media do |t|
      t.references :tweet, foreign_key: true
      t.string :uri, null: false, default: 'UNKNOWN'

      t.timestamps
      t.timestamps
    end
  end
end

# Module: Twitter::Media
# Defined in:
# lib/twitter/media/photo.rb more...
# Defined Under Namespace
# Classes: AnimatedGif, Photo, Video, VideoInfo