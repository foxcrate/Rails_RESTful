class Student < ApplicationRecord
  has_many :courses_student
  has_many :courses, through: :courses_student
end
