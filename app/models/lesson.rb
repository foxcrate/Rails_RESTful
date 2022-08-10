class Lesson < ApplicationRecord
  belongs_to :course , optional: true
end
