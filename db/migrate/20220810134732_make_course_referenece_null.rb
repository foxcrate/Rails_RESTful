class MakeCourseRefereneceNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :lessons, :course_id, true
  end
end
