class API::V1::ApiController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :set_default_format
  rescue_from ActiveRecord::RecordNotFound, with: :render_404


  private

  def current_user
    id, access_token = request.headers[:HTTP_AUTHORIZATION].split(':')
    @current_user ||= User.where(id: id, access_token: access_token).first
  end

  def authenticate_user!
    if request.headers[:HTTP_AUTHORIZATION].nil? || current_user.nil?
      render status: :unauthorized, json: {message: "No Authentication token."}
    end
  end

  def set_default_format
    request.format = :json unless params[:format]
  end

  def render_404
    render status: :not_found, nothing: true
  end

end
