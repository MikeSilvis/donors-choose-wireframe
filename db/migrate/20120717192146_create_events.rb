class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :project_id
      t.text :content
      t.string :event_type

      t.timestamps
    end
  end
end
