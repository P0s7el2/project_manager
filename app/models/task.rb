class Task < ApplicationRecord
  has_many :tasks_projects
  has_many :projects, through: :tasks_projects
  belongs_to :user
  validates :title, presence: true
end
