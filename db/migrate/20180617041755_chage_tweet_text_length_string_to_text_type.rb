class ChageTweetTextLengthStringToTextType < ActiveRecord::Migration[5.2]
  # Twitter の文字数制限が 280文字 になったので :string では収まりきらないときがある
  def up
    change_column :tweets, :text, :string, limit: 320, default: 'NOTHING'
  end

  def down
    change_column :tweets, :text, :string, default: 'NOTHING'
  end
end
