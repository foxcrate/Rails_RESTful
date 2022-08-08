class Api::V1::AuthenticationController < ApplicationController
    class AuthenticationError < StandardError; end
    class UserNotFoundError < StandardError; end

    rescue_from ActionController::ParameterMissing, with: :parameter_missing
    rescue_from AuthenticationError, with: :unauthenticated
    rescue_from UserNotFoundError, with: :user_not_found
    
    def sign_up
        params.require(:user_name).inspect
        params.require(:password).inspect

        new_user = User.new(name: params[:user_name],password: params[:password])
        if new_user.save
            user_object = UserRepresenter.get(new_user)
            render json: user_object , status: :created
        else 
            render json: new_user.errors, status: :unprocessable_entity
        end

    end
    
    def token_sign_up
        params.require(:user_name).inspect
        params.require(:password).inspect
        the_user = User.find_by(name:params[:user_name])
        raise UserNotFoundError if the_user == nil 
        p "-- the user: #{the_user.name} --"
        raise AuthenticationError unless the_user.authenticate(params[:password])
        jwt_code = AuthenticationCreator.encode(the_user.id)
        render json: jwt_code
    end

    def token_sign_in
        params.require(:token).inspect
        decoded_token = AuthenticationCreator.decode(params[:token])
        render json: decoded_token
    end

    private

    def parameter_missing(e)
        render json: {error: e.message}, status: :unprocessable_entity
    end

    def unauthenticated(e)
        render json: {error: "Wrong Credentials"}, status: :unauthorized
    end

    def user_not_found(e)
        render json: {error: "User Not Found"}, status: :not_found
    end

end