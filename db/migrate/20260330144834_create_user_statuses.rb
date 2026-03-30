class CreateUserStatuses < ActiveRecord::Migration[7.2]
  def change
    create_table :user_statuses do |t|
      t.string :full_name, null: false
      t.string :experience, null: false
      t.integer :pending_task_count, null: false
      t.string :next_urgent_task

      t.timestamps
    end
  end
end
