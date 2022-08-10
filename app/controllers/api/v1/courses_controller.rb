class Api::V1::CoursesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user , only: [:get_students,:add_students]

  class NoTokenError < StandardError; end
  rescue_from NoTokenError, with: :no_token_error

  def get_students
    the_course = Course.find(params[:course_id])
    course_students = the_course.students
    render json: course_students , status: :ok
  end

  def add_students
    the_course = Course.find(params[:course_id])
    students_ids = params[:students_to_add]
    students_ids.each do |student_id|
      the_student = Student.find(student_id)
      the_course.students << the_student
    end
    render json: "Students Added Successfully", status: :ok
  end

  private

  def authenticate_user
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

  def no_token_error
    render json: "No Token Provided" , status: :not_found
  end

end