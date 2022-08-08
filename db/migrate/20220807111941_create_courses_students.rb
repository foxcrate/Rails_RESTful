class CreateCoursesStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :courses_students do |t|
      t.references :course, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.integer :grade

      t.timestamps
    end
  end
end
