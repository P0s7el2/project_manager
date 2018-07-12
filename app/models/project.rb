class Project < ApplicationRecord
  has_many :tasks_projects
  has_many :tasks, through: :tasks_projects

  validates :name, presence: true

  def attached?(task)
    self.tasks.include?(task)
  end

  def unattached_tasks
    Task.all - self.tasks
  end
end
