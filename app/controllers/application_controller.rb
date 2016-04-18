class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    render json: {error: exception.message}, status: :forbidden
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    render plain: exception
  end
end
