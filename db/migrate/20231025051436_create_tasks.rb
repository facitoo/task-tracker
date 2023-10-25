class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :status_id
      t.integer :assignee_id
      t.integer :requester_id

      t.timestamps
    end
  end
end
