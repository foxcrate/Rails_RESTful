class User < ApplicationRecord
    has_secure_password
    validates :name, presence: true, length: {minimum: 5}
    validates :password, presence: true, length: {minimum: 6}

    def admin?
        if role == 'admin'
            return true
        else
            return false
        end
    end
end
