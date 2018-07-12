class CreateProjectsTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks_projects do |t|
      t.integer :task_id
      t.integer :project_id
    end
  end
end
