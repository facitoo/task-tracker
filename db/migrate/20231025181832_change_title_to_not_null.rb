class ChangeTitleToNotNull < ActiveRecord::Migration[7.0]
  def change
    change_column :tasks, :title, :string, null: false
  end
end
