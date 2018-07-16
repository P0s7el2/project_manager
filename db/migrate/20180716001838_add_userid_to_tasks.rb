class AddUseridToTasks < ActiveRecord::Migration[5.2]
  def change
    add_belongs_to :tasks, :user
  end
end
