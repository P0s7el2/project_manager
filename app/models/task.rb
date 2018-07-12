class Task < ApplicationRecord
  has_many :tasks_projects
  has_many :projects, through: :tasks_projects

  validates :title, presence: true
end
