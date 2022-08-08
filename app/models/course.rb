class Course < ApplicationRecord
  has_many :courses_student
  has_many :students, through: :courses_student
end
