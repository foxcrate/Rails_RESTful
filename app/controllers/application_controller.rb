class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :no_record_found
    def no_record_found(e)
        render json: e , status: :unprocessable_entity 
    end
end
