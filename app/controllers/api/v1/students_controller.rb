class Api::V1::StudentsController < ApplicationController
  authorize_resource
  before_action :authenticate_user , only: [:get_courses, :add_courses]


  class NoTokenError < StandardError; end
  rescue_from NoTokenError, with: :no_token_error

  def get_courses
    p "-- enter get_courses --"
    the_student = Student.find(params[:student_id])
    student_courses = the_student.courses
    render json: student_courses , status: :ok
  end

  def add_courses
    the_student = Student.find(params[:student_id])
    courses_ids = params[:courses_to_add]
    courses_ids.each do |course_id|
      the_course = Course.find(course_id)
      the_student.courses << the_course
    end
    render json: "Courses Added Successfully", status: :ok
  end

  # def current_user
  #   params.require(:token).inspect
  #   decoded_token = AuthenticationCreator.decode(params[:token])
  #   user_id = decoded_token[0]
  #   current_user = User.find(user_id)
  #   p "-- current user from student controller: #{current_user} --"
  #   current_user
  # end

  private

  def authenticate_user
    if request.authorization
      token =  request.authorization.split(' ').last
    else
      raise NoTokenError
    end
    # p "-- token: #{token} --"
    user_id = AuthenticationCreator.decode(token)
    User.find(user_id)
  rescue ActiveRecord::RecordNotFound
    render status: :unauthorized
    # end
    p "-- user authenticated successfully --"
  end

  def no_token_error
    render json: "No Token Provided" , status: :not_found
  end

end