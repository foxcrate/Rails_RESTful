class ApplicationController < ActionController::API
    include CanCan::ControllerAdditions

    rescue_from CanCan::AccessDenied do |exception|
        # redirect_to root_url, :alert => exception.message
        render json: "Access Denied", status: 406
    end

    def current_user
        if token
            @current_user ||= User.find(token)
            p "-- current user: #{@current_user} --"
            @current_user
        else
            @current_user ||= User.new(role: "visitor")
            p "-- current user: #{@current_user} --"
            @current_user
        end
    end

    def token
        # value = request.headers["Authorization"]
        value =  request.authorization.split(' ').last
        p "-- token in the request before decoding #{value} --"
        p "-- constant: #{AuthenticationCreator::ALGORITHM} --"
        return if value.blank?
        @token ||= JWT.decode(value, AuthenticationCreator::SECRET, true, { algorithm: AuthenticationCreator::ALGORITHM })[0]["user_id"]

        p "-- token in the request after decoding #{@token} --"
        @token

    end





end
