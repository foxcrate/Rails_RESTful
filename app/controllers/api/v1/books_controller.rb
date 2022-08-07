class Api::V1::BooksController < ApplicationController
    MAX_PAGINATION_LIMIT = 100

    class NoTokenError < StandardError; end

    before_action :authenticate_user , only: [:index, :create, :destroy]
    rescue_from NoTokenError, with: :no_token_error

    def index
        @books = Book.limit(limit).offset(params[:offset])
        # p "-- the limit: #{limit}--"
        render json: @books
    end

    def teto
        @books = Book.limit(limit).offset(params[:offset])
        # p "-- the limit: #{limit}--"
        render json: @books
    end

    def create
        @book = Book.new(book_parameter)
        if @book.save
            render json: @book, status: :created
        else 
            render json: @book.errors, status: :unprocessable_entity
        end
        
    end

    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        render head: :ok
    # rescue ActiveRecord::RecordNotFound =>e
    #     render json: e , status: :unprocessable_entity 
    end

    private
    def book_parameter
        params.require(:book).permit(:title, :writer)
    end

    def limit
        x =  params.fetch(:limit,MAX_PAGINATION_LIMIT).to_i
        [x, MAX_PAGINATION_LIMIT].min
    end

    def no_token_error
        render json: "No Token Provided" , status: :not_found
    end

    def authenticate_user
        # token, _options = token_and_options(request)
        # p "the request"
        # p request.authorization
        # p "-- headers: #{headers} --"
        if request.authorization
            token =  request.authorization.split(' ').last
        else
            raise NoTokenError
        end
        p "-- token: #{token} --"
        user_id = AuthenticationCreator.decode(token)
        User.find(user_id)
        rescue ActiveRecord::RecordNotFound
        render status: :unauthorized
        # end
        p "-- user authenticated successfully --"
    end
end
