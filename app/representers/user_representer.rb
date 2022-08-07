class UserRepresenter
    def self.get(user)
        new_user_object = {
            id: user.id,
            name: user.name
        }
        new_user_object
    end
end