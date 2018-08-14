class CreateLessonreservations < ActiveRecord::Migration
  def change
    create_table :lessonreservations do |t|
      t.integer :lesson_id
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
