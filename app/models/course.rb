class Course < ApplicationRecord
  has_many :courses_student
  has_many :students, through: :courses_student
  has_many :reviews, as: :reviewable
  has_many :lessons, dependent: :destroy
end
