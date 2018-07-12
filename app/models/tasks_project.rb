class TasksProject < ApplicationRecord
  belongs_to :project
  belongs_to :task

  validates :task_id, uniqueness: true
end