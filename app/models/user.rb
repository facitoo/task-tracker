class User < ApplicationRecord
    has_many :created_tasks, class_name: 'Task', foreign_key: 'requester_id' , inverse_of: :requester
    has_many :assigned_tasks, class_name: 'Task', foreign_key: 'assignee_id' , inverse_of: :assignee
end
