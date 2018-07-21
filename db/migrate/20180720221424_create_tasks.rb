class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description, null: true
      t.datetime :target_at, null: true
      t.datetime :completed_at, null: true
      t.boolean :completed, null: false, default: false
      t.integer :user_id, null: true
      t.timestamps
    end
  end
end
