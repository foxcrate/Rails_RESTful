class Book < ApplicationRecord
    validates :title, presence: true, length: {minimum: 3}
    validates :writer, presence: true, length: {minimum: 3}
end
