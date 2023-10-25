class AddReferencesToTasks < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key "tasks", "users", column: "assignee_id"
    add_foreign_key "tasks", "users", column: "requester_id"
  end
end
