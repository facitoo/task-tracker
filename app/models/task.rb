class Task < ApplicationRecord
	belongs_to :requester, class_name: 'User', foreign_key: 'requester_id'
	belongs_to :assignee, class_name: 'User', foreign_key: 'assignee_id' , optional: true
	belongs_to :status

	validates :title, presence: true
end
