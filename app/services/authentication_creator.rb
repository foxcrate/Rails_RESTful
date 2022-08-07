class AuthenticationCreator
    ALGORITHM = 'HS256'
    SECRET = 'my_secret'

    def self.encode(user_id)
        payload = {"user_id" => user_id}
        JWT.encode payload, SECRET, ALGORITHM
    end

    def self.decode(token)
        decoded_token = JWT.decode token, SECRET, true, {algorithm: ALGORITHM}
        decoded_token[0]["user_id"]
    end
end